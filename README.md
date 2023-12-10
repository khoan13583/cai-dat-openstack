# openstack-victoria-basic-installer

Author: Nguyễn Trần Đăng Khoa <br>
Contact: khoan13583@gmail.com <br>

<p>
<h2> 1. Chuẩn bị máy tính để cài đặt </h2>
	
![image](https://github.com/khoan13583/cai_dat_openstack_victoria/assets/88971108/0d229658-bde9-4470-b1e9-47457417c2fd)

<p>
Có bốn máy tính được kết nối trong một hệ thống mạng: <br>
•	Một máy tính đóng vai trò là bộ điều khiển (Controller). Chịu trách nhiệm chạy các dịch vụ, phần mềm phục vụ các lệnh yêu cầu từ người dùng hệ thống; Xác minh danh tính của người dùng; Quản lý việc sử dụng tài nguyên và là vị trí hệ thống cơ sở dữ liệu dùng để lưu trữ dữ liệu của toàn bộ hệ thống.<br>
•	Một máy tính đóng vai trò quản lý hệ thống mạng (Network). Chịu trách nhiệm quản lý việc trao đổi dữ liệu giữa các máy tính ảo được tạo trong hệ thống OpenStack với các máy tính bên ngoài mạng Internet.<br>
•	Hai máy tính đóng vai trò tính toán (Compute và Compute1).  Đây là máy có trách nhiệm chạy các máy tính ảo được tạo ra bởi người dùng. Các dịch vụ và phần mềm của OpenStack trên bộ điều khiển quyết định máy ảo của người dùng sẽ chạy trên máy tính nào.<br>

<p>
Hệ điều hành của 4 máy tính đều là 20.04 LTS, tất cả các máy đều có thông tin đăng nhập với username là "openstack" và password là "openstack". Ngoài ra 4 máy tính cũng phải ở tình trạng đồng bộ về thời gian.
<p>
	
<p>
  Chuẩn bị hệ thống mạng kết nối bốn máy tính như sau:
<ul>
<li>	Mạng quản lý (Management Network – 192.l68.1.0/24): là hệ thống mạng giúp cho các dịch vụ, phần mềm của OpenStack trên các máy tính (của hệ thống) có để truyền đạt các lệnh và dữ liệu nhằm thực hiện các chức năng hệ thống khác nhau. Mạng này cũng được sử dụng để cài đặt các dịch vụ và phần mềm.
  <li>	Mạng đường hầm dữ liệu (Data Tunel Network – 10.0.1.0/24): là hệ thống mạng được sử dụng để liên lạc dữ liệu giữa các máy ảo có thể được cấu hình để chạy trên các máy chủ khác nhau.(Được sử dụng để liên lạc dữ liệu giữa các máy ảo và các bộ định tuyến ảo mà OpenStack tạo trên máy chủ mạng. Để truyền dữ liệu VM đến các 
    <li>	Hệ thống mạng VLAN (VLAN Network): Các máy tính trong cùng VLAN có thể giao tiếp với nhau trong cùng một miền quảng bá.
      <li>	Mạng bên ngoài (External Network – 192.168.1.160 -- 200) : Dãy mạng cung cấp dịch vụ Internet.
</ul>

![image](https://github.com/khoan13583/cai_dat_openstack_victoria/assets/88971108/5a04ce23-9163-4abd-82c9-4724f4179674)

<h2> 2. Cài đặt </h2>
<p>
Tải tập tin cài đặt về máy Controller bằng công cụ Git.
<pre>
On controller: 
$ screen
$ git init
$ git clone https://github.com/kasidit/openstack-victoria-basic-installer
Cloning into 'openstack-victoria-basic-installer'...
$ ls
openstack-victoria-basic-installer
</pre>

<p>
  Sau đó cd vào thư mục openstack-victoria-basic-installer và liệt kê các thư mục có trong đó.
<pre>
On controller: 
$ cd openstack-victoria-basic-installer/
$ ls
config.d     example.install-paramrc.sh  LICENSE                  Untarfiles
Deployments  exe-config-installer.sh     OPSInstaller-init.tar    vmhosts-scripts
documents    install-paramrc.sh          README.md
$ 
</pre>

<p>
  Sau khi điều chỉnh các thông số cài đặt theo mong muốn, chạy lệnh ./exe-config-installer.sh cài đặt theo các thông số đã đặt.
<pre>
On controller: 
$ pwd
/home/openstack/openstack-victoria-basic-installer
$ ./exe-config-installer.sh
</pre>

<p><p>
Cấu trúc và chức năng của tập lệnh cài đặt OpenStack sẽ chạy trên từng máy:	

![image](https://github.com/khoan13583/cai_dat_openstack_victoria/assets/88971108/6ed52263-fe02-474f-8b1c-978d053881ef)
<p>
Tên của mỗi script có chuỗi ký tự “*StageNN*”, trong đó NN là số chỉ thứ tự của lượt chạy. Các tập lệnh này được tổ chức thành các nhóm, mỗi nhóm thực hiện một “chức năng” được chỉ định trong cột “Chức năng”.	
</p>
<h3>1. Cài đặt môi trường</h3>
<p>
	Chuyển đến thư mục installer để phân phối các tập tin cài đặt và cấu hình đến các máy chủ.<br>
	1) $ sudo ./exe-preinstall00-SUDO-update.sh cài đặt và cập nhật dịch vụ SSH để phân phối các tệp tin.<br>
 	2) ./exe-preinstall01-USER-set-remote-access.sh định cấu hình Private key (khóa riêng) và Public key (khóa chung) để cho phép thực thi và truyền dữ liệu từ xa mà không cần mật khẩu.<br>
  	3) ./exe-preinstall02-USER-set-openstack-nodes.sh phân phối các tập tin dưới dạng tarball (tập tin nén) đến các máy tương ứng. <br>
	
<pre>
On controller: 
$ cd installer
$ pwd
/home/openstack/openstack-wallaby-basic-installer/OPSInstaller/installer
$ sudo ./exe-preinstall00-SUDO-update.sh
$ ./exe-preinstall01-USER-set-remote-access.sh
$ ./exe-preinstall02-USER-set-openstack-nodes.sh
</pre>
<h3>2. Cập nhật Ubuntu và cập nhật OpenStack Repository</h3>
<p>
Thực hiện cập nhật các máy chủ Ubuntu, cập nhật kho phần mềm APT của Ubuntu và kho dịch vụ của OpenStack để chuẩn bị cho việc cài đặt.
<p>
Khi các máy Network và hai máy Compute & Compute1 khởi động lại xong thì tiến hành khởi động lại máy Controller.
<pre>
On controller: 
$ cd
$ cd OPSInstaller/controller/
$ sudo ./exe-stage00-SUDO-update.sh
…
Press [ENTER] to continue or Ctrl-c to cancel adding it.
…
update-initramfs: Generating /boot/initrd.img-5.4.0-58-generic 

… tốn khoảng 5-10 phút …
$
$ sudo reboot
</pre>

<p>
 Thực hiện trên máy Network (chuyển đến thư mục /network) và thực hiện trên máy lần lượt trên hai máy chủ Compute và Compute1 (chuyển đến thư mục /compute và /compute1):
<pre>
On network: 
$ cd OPSInstaller/network/
$ sudo ./exe-stage00-SUDO-update.sh
…
On compute: 
$ cd OPSInstaller/network/
$ sudo ./exe-stage00-SUDO-update.sh
…
On compute1: 
$ cd OPSInstaller/network/
$ sudo ./exe-stage00-SUDO-update.sh
…
</pre>
<p>
<h3>3. Thiết lập giao diện mạng (Setting up Network Interfaces)</h3>
<p>
Sau khi tất cả các máy chủ đã được khởi động lại, tiến hành định cấu hình IP (địa chỉ mạng) và kích hoạt các NIC (card giao tiếp mạng) mà OpenStack yêu cầu trên các máy chủ.

<pre>
On controller: 
$ screen
$ cd OPSInstaller/controller/
$ sudo ./exe-stage01-SUDO-preinstall.sh
$ 
</pre>

Thực hiện trên máy Network (chuyển đến thư mục /network):
<pre>
On network: 
$ cd OPSInstaller/network/
$ sudo ./exe-stage02-SUDO-network-preinstall.sh

</pre>
Thực hiện lần lượt trên hai máy chủ Compute và Compute1 (chuyển đến thư mục /compute và /compute1):
<pre>
On compute: 
$ cd OPSInstaller/compute/
$ sudo ./exe-stage03-SUDO-compute-preinstall.sh
...
</pre>

<pre>
On compute1: 
$ cd OPSInstaller/compute1/
$ sudo ./exe-stage03-SUDO-compute-preinstall.sh
...
</pre>

<p>
<h3>4. Cài đặt hệ thống cơ sở dữ liệu MariaDB (Setting up mariadb)</h3>
<p>
 MariaDB là một hệ quản trị cơ sở dữ liệu mã nguồn mở được phát triển từ MySQL. Trong môi trường OpenStack, MariaDB thường được sử dụng làm cơ sở dữ liệu cho các dịch vụ do tính nhất quán với mô hình mã nguồn mở của OpenStack.
Thực hiện trên máy Controller (chuyển đến thư mục /controller) để sử dụng phần mềm chronyc để đồng bộ thời gian với máy chủ NTP, đồng thời cài đặt hệ thống cơ sở dữ liệu MariaDB:
<pre>
On controller: 
$ pwd
/home/openstack/OPSInstaller/controller
$ sudo ./exe-stage04-SUDO-mysql.sh
…
*** First, enter blank for mysql password. Then set new password to mysqlpassword ***
…
Enter current password for root (enter for none): ấn enter
…
Change the root password? [Y/n] nhập Y
…
New password: mysqlpassword
Re-enter new password: mysqlpassword
…
Remove anonymous users? [Y/n] nhập Y
…
Disallow root login remotely? [Y/n] nhập Y
…
Remove test database and access to it? [Y/n] nhập Y
…
Reload privilege tables now? [Y/n] nhập Y
$ 
</pre>

Thực hiện trên máy Network (chuyển đến thư mục /network) để chạy phần mềm chronyc để đồng bộ thời gian với máy điều khiển (Controller), đồng thời cài đặt hệ thống cơ sở dữ liệu MariaDB:
<pre>
On network: 
$ cd OPSInstaller/network/
$ sudo ./exe-stage05-SUDO-network-mysql.sh
$ 
...
</pre>

Thực hiện trên máy lần lượt trên hai máy chủ Compute và Compute1 (chuyển đến thư mục /compute và /compute1) chạy phần mềm chronyc để đồng bộ thời gian với máy điều khiển (Controller), đồng thời cài đặt hệ thống cơ sở dữ liệu MariaDB:
<pre>
On compute: 
$ cd OPSInstaller/compute/
$ sudo ./exe-stage06-SUDO-compute-mysql.sh
$ 
...
On compute1: 
$ cd OPSInstaller/compute1/
$ sudo ./exe-stage06-SUDO-compute-mysql.sh
$ 
</pre>
<p>
<h3>5. Cài đặt phần mềm RabbitMQ (Setting up rabbitmq)</h3>
<p>
Trong môi trường điện toán đám mây, như OpenStack, RabbitMQ thường được sử dụng để quản lý và truyền tải các thông điệp giữa các thành phần khác nhau của hệ thống. 
OpenStack sử dụng phần mềm này để giao tiếp các lệnh và dữ liệu giữa các thành phần phần mềm khác nhau có thể nằm trên cùng một chủ hoặc trên các máy khác nhau. <br>
<p>
	Thực hiện trên máy Controller (chuyển đến thư mục /controller) để cài đặt phần mềm RabbitMQ lên máy chủ điều khiển: 
<pre>
On controller: 
$ sudo ./exe-stage07-SUDO-rabbit.sh
</pre>

<p>
<h3>6. Cài đặt Keystone (Keystone Installation)</h3>
<p>
Thực hiện trên máy Controller (chuyển đến thư mục /controller) để cài đặt Keystone lên máy chủ điều khiển: 
<pre>
On controller: 
$ sudo ./exe-stage08-SUDO-keystone-database.sh
$ sudo ./exe-stage09-SUDO-keystone.sh
$ ./exe-stage10-USER-service-endpoints.sh
$ ./exe-stage11-USER-test-envscript.sh
</pre>

<p>
<h3>7. Cài đặt Glance (Glance Installation)</h3>
<p>
Thực hiện trên máy Controller (chuyển đến thư mục /controller) để cài đặt Glance lên máy chủ điều khiển:
<pre>
On controller: 
$ sudo ./exe-stage12-SUDO-glance-database.sh
$ ./exe-stage13-USER-glance-endpoints.sh
$ sudo ./exe-stage14-SUDO-glance.sh
$ sudo ./exe-stage14-x1-SUDO-glance.sh
$ ./exe-stage15-USER-verify-glance.sh
</pre>

<p>
<h3>8. Cài đặt Placement (Placement Installation)</h3>
<p>
Nền tảng là một dịch vụ phần mềm ngăn xếp mở có chức năng xác định các lớp và thuộc tính của tài nguyên hệ thống như CPU ảo, bộ nhớ và bộ lưu trữ, đồng thời thu thập dữ liệu lịch sử sử dụng (theo dõi) của các tài nguyên đó.
<p>
Thực hiện trên máy Controller (chuyển đến thư mục /controller) để cài đặt Placement lên máy chủ điều khiển:
<pre>
On controller: 
$ sudo ./exe-stage15-x1-SUDO-placement-database.sh
$ ./exe-stage15-x2-USER-placement-endpoints.sh
$ sudo ./exe-stage15-x3-SUDO-placement.sh
</pre>

<p>
<h3>9. Cài đặt Nova (Nova Installation)</h3>
<p>
Thực hiện trên máy Controller (chuyển đến thư mục /controller) để cài đặt Nova lên máy chủ điều khiển:
<pre>
On controller: 
$ sudo ./exe-stage16-SUDO-nova-database.sh
$ ./exe-stage17-USER-nova-endpoints.sh
$ sudo ./exe-stage18-SUDO-nova.sh
</pre>

Thực hiện lần lượt trên hai máy chủ Compute và Compute1 (chuyển đến thư mục /compute và /compute1):
<pre>
On compute & compute1: 
$ cd OPSInstaller/compute/
$ sudo ./exe-stage19-SUDO-nova-compute.sh
$ sudo ./exe-stage19-x1-SUDO-nova-compute.sh
</pre>

Thực hiện trên máy Controller (chuyển đến thư mục /controller) để kiểm tra khả năng phối hợp đồng bộ của của máy chủ điều khiển với hai chủ máy tính toán:
<pre>
On controller: 
$ ./exe-stage20-0-USER-verify-nova-compute.sh
…
Found 2 cell mappings.
Skipping cell0 since it does not contain hosts.
Getting computes from cell 'cell1': 3ddc4f3d-4eb8-45cc-8b64-53bf6d2918d8
Checking host mapping for compute host 'compute': ef9471a4-72f3-48d2-8b35-0e066f9c37ef
Creating host mapping for compute host 'compute': ef9471a4-72f3-48d2-8b35-0e066f9c37ef
Checking host mapping for compute host 'compute1': 9e76d546-b88e-4d19-9b87-28cf59815c32
Creating host mapping for compute host 'compute1': 9e76d546-b88e-4d19-9b87-28cf59815c32
…
$ ./exe-stage20-1-USER-verify-nova-compute1.sh
$ ./exe-stage20-2-USER-verify-nova.sh
</pre>

<h3>10. Cài đặt Neutron (Neutron Installation)</h3>
<p>
Thực hiện trên máy Controller (chuyển đến thư mục /controller) để cài đặt Neutron lên máy chủ điều khiển:
<pre>
On controller: 
$ sudo ./exe-stage21-SUDO-neutron-database.sh
$ ./exe-stage22-USER-neutron-endpoints.sh
$ sudo ./exe-stage23-SUDO-neutron.sh
$ ./exe-stage24-USER-verify-neutron.sh
</pre>

Thực hiện trên máy Network (chuyển đến thư mục /network):
<pre>
On network: 
$ cd OPSInstaller/network/
$ sudo ./exe-stage25-SUDO-network-neutron.sh
</pre>

Thực hiện trên máy Controller (chuyển đến thư mục /controller):
<pre>
On controller: 
$ sudo ./exe-stage26-SUDO-reconfig-neutron-nova.sh
</pre>

Thực hiện trên máy Network (chuyển đến thư mục /network):
<pre>
On network: 
$ cd OPSInstaller/network/
$ sudo ./exe-stage27-SUDO-ovs-service.sh
</pre>

Thực hiện trên máy Controller (chuyển đến thư mục /controller):
<pre>
On controller: 
$ ./exe-stage28-USER-verify-neutron2.sh
</pre>

Thực hiện lần lượt trên hai máy chủ Compute và Compute1 (chuyển đến thư mục /compute và /compute1):
<pre>
On compute & compute1: 
$ cd OPSInstaller/compute/
$ sudo ./exe-stage29-SUDO-compute-neutron.sh
</pre>

Thực hiện trên máy Controller (chuyển đến thư mục /controller):
<pre>
On controller: 
$ ./exe-stage30-USER-verify-neutron3.sh
</pre>

<h3>11. Tạo một mạng ảo ban đầu để kiểm thử (Test Initial Networks)</h3>
<p>
Thực hiện trên máy Controller (chuyển đến thư mục /controller):

<pre>
On controller: 
$ ./exe-stage36-USER-initial-network.sh
</pre>

<p>
<h3>12. Cài đặt Horizon (Horizon Installation)</h3>
<p>
Thực hiện trên máy Controller (chuyển đến thư mục /controller):
<pre>
On controller: 
$ sudo ./exe-stage37-SUDO-horizon.sh
</pre>

<p>
<h3>13. Cài đặt Cinder (Cinder Installation)</h3>
<p>
Thực hiện trên máy Controller (chuyển đến thư mục /controller) để cài đặt Cinder:
<pre>
On controller: 
$ sudo ./exe-stage38-SUDO-cinder-database.sh
$ ./exe-stage39-USER-cinder-endpoints.sh
$ sudo ./exe-stage40-SUDO-cinder.sh
</pre>

<p>
Thực hiện trên máy Compute (chuyển đến thư mục /compute):
<pre>
On compute: 
$ cd OPSInstaller/compute/
$ sudo ./exe-stage41-SUDO-cinder-storage.sh
</pre>



  
