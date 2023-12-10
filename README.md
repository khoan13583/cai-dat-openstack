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
โนวา (Nova) (หรือ โอเพ่นสแตค คอมพิวต์) (OpenStack Compute) เป็นซอฟต์แวร์คอมโพเน้นสำคัญของระบบโอเพ่นสแตคที่ทำหน้าที่ให้บริการและบริหารจัดการประมวลผลวีเอ็มบนเครื่องโฮสคอมพิวเตอร์ที่เป็นทรัพยากรสำหรับการประมวลผลกลุ่มเมฆภายในระบบโอเพ่นสแตค โครงสร้างของโนวาประกอบไปด้วยซอฟต์แวร์เอเจนท์ (agent) หลายเอเจนท์ที่รันอยู่บนเครื่องคอนโทรเลอร์ เครื่องคอมพิวต์โฮส (เครื่องคอมพิวต์และคอมพิวต์หนึ่ง) 
<p>
ซอฟต์แวร์เอเจ้นท์สำคัญของโนวาที่รันบนเครื่องคอนโทรเลอร์ได้แก่ 
<ul>
  <li>	โนวาเอพีไอ (nova-api) ให้บริการรับคำสั่งจากผู้ใช้และซอฟต์แวร์คอมโพเน้นอื่น
  <li>	โนวาสเคดูลเลอร์ (nova-scheduler) ทำหน้ารับคำขอสร้างวีเอ็มและตัดสินใจว่าจะรันวีเอ็มบนคอมพิวต์โฮสเครื่องใด
  <li>	โนวาคอนดัคเตอร์ (nova-conductor) เป็นซอฟต์แวร์ตัวกลางที่ทำให้ซอฟต์แวร์เอเจ้นท์ nova-compute ซึ่งรันอยู่บนเครื่องคอมพิวต์โฮสสามารถติดต่อสื่อสารดับระบบฐานข้อมูลได้ (ระบบโอเพ่นสแตคไม่อนุญาตให้ซอฟต์แวร์เอเจ้นท์นอกเครื่องคอนโทรเลอร์เข้าถึงระบบฐานข้อมูลโดยตรง) 
  <li>	โนวาเอพีไอเมตาดาต้า (nova-api-metadata) คือซอฟต์แวร์อเจนท์ที่ให้บริการเมตาดาต้า เมื่อวีเอ็มที่ถูกสร้างขึ้นบนเครื่องคอมพิวต์โฮสร้องขอข้อมูลเมตาดาต้าเพื่อนำไปประมวลผล
  <li>	โนวาโนวีเอ็นซีพร้อกซี่ (nova-novnc-proxy) เป็นซอฟต์แวร์เอเจนท์ที่ให้บริการวีเอ็นซีพร้อกซี่ (VNC proxy) ที่ทำให้ผู้ใช้สามารถเข้าถึงหน้าจอวีเอ็นซีของวีเอ็มจากเครื่องคอนโทรเลอร์ได้
</ul>
ซอฟต์แวร์เอเจนท์ที่รันอยู่บนเครื่องคอมพิวต์โฮสมีดังนี้ 
<ul>
  <li>	โนวาคอมพิวต์ (nova-compute) เป็นซอฟต์แวร์เอเจ้นที่เป็นเดมอนโปรเซส (daemon process) ที่ทำหน้าที่รันและจัดการวีเอ็ม โดยเรียกใช้เอพีไอของไฮเปอร์ไวเซอร์ที่ได้รับการติดตั้งบนเครื่องคอมพิวต์โฮส ยกตัวอย่างเช่น โนวาคอมพิวต์จะใช้ลิปเวอร์ทเอพีไอ (Libvirt API) ถ้าไฮเปอร์ไวเซอร์ที่จะรันวีเอ็มคือ เควีเอ็ม (KVM) หรือคิวมู (Qemu) หรือใช้วีเอ็มแวร์เอพีไอ (VmwareAPI) ถ้าไฮเปอร์ไวเซอร์ที่ใช้คือวีเอ็มแวร์ (Vmware) เป็นต้น
</ul>
<p>
ในการติดตั้งโนวา ผู้ติดตั้งจะต้องรันสคริปต์ต่อไปนี้บนเครื่องคอมโทรเลอร์ 1) สคริปต์ exe-stage16-SUDO-nova-database.sh เพื่อสร้างเทเบิ้ลในระบบฐานข้อมูล 2) exe-stage17-USER-nova-endpoints.sh เพื่อสร้างยูอาร์แอลสำหรับให้บริการโนวา และ 3) exe-stage18-SUDO-nova.sh  เพื่อติดตั้งโนวาเอเจ้นท์ได้แก่ โนวาเอพีไอ โนวาคอนดัคเตอร์ โนวาโนวีเอ็นซีพร้อกซี่ และโนวาสเคดูเลอร์ 
<pre>
On controller: 
$ sudo ./exe-stage16-SUDO-nova-database.sh
$ ./exe-stage17-USER-nova-endpoints.sh
$ sudo ./exe-stage18-SUDO-nova.sh
</pre>
<pre>
Video 12: <a href="https://youtu.be/1Q5O0UkxXIQ">https://youtu.be/1Q5O0UkxXIQ</a>
</pre>
ถัดไป ผู้ติดตั้งต้องล็อกอินเข้าสู่เครื่องคอมพิวต์เพื่อรันสคริปต์ exe-stage19-SUDO-nova-compute.sh และ exe-stage19-x1-SUDO-nova-compute.sh เพื่อติดตั้งโนวาคอมพิวต์ หลังจากเสร็จแล้วให้ทำแบบเดียวกันบนเครื่องคอมพิวต์หนึ่ง 
<pre>
On compute & compute1: 
$ cd OPSInstaller/compute/
$ sudo ./exe-stage19-SUDO-nova-compute.sh
$ sudo ./exe-stage19-x1-SUDO-nova-compute.sh
</pre>
<pre>
Video 13: <a href="https://youtu.be/7Vbt6dWBANU">https://youtu.be/7Vbt6dWBANU</a>
</pre>
หลังจากนั้น ผู้ติดตั้งต้องรันสคริปต์ exe-stage20-0-USER-verify-nova-compute.sh exe-stage20-1-USER-verify-nova-compute1.sh และ exe-stage20-2-USER-verify-nova.sh บนเครื่องคอนโทรเลอร์ เพื่อตรวจสอบว่าโนวาเอเจ้นท์บนเครื่องคอนโทรเลอร์สามารถประสานงานกับโนวาเอเจนท์บนเครื่องคอมพิวต์โฮสทั้งสองหรือไม่ ในตัวอย่างข้างล่างสคริปต์รายงานว่าพบเครื่องคอมพิวต์และคอมพิวต์หนึ่งเป็นโฮสในระบบ
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
<pre>
Video 14: <a href="https://youtu.be/_xGPkLL6YZQ">https://youtu.be/_xGPkLL6YZQ</a>
</pre>
<h3>10 ติดตั้งนิวตรอน (Neutron Installation)</h3>
<p>
นิวตรอน (หรือ โอเพ่นสแตค เน็ตเวิร์ค) (OpenStack Network) เป็นคอมโพเน้นที่ทำหน้าสร้างและจัดการเน็ตเวิร์คเสมือนสำหรับให้วีเอ็มเชื่อมต่อ และจัดการการสื่อสารระหว่างระบบเครือข่ายเสมือนเหล่านั้นกับระบบเครือข่ายภายนอกระบบโอเพ่นสแตคเช่นระบบเครือข่ายอินเทอร์เน็ต 
<p>
ซอฟต์แวร์เอเจ้นท์ของระบบนิวตรอนที่รันบนเครื่องคอนโทรเลอร์ คือนิวตรอนเซริฟเวอร์เอเจ้นท์ (neutron-server) ซึ่งทำหน้าที่รับคำสั่งสร้างและบริหารจัดการระบบเครือข่ายเสมือน นิวตรอนเซริฟเวอร์จะประสานงานกับโนวาเพื่อจัดการให้วีเอ็มที่สร้างขึ้นสามารถสื่อสารข้อมูลผ่านระบบเครือข่ายได้
<p>
ระบบนิวตรอนมีเอเจ้นท์จำนวนหนึ่งบนเครื่องเน็ตเวิร์คเพื่อทำหน้าจัดการให้การสื่อสารข้อมูลระหว่างวีเอ็มและจากวีเอ็มสู่ระบบเครือข่ายภายนอกเป็นไปอย่างเรียบร้อย เอเจ้นท์เหล่านี้ได้แก่ 
<ul>
  <li>	นิวตรอนแอลสามเอเจ้นท์ (neutron-l3-agent) ที่ทำหน้าที่จัดการเร้าเตอร์เสมือนสำหรับระบบเครือข่ายเสมือน 
  <li>	นิวตรอนดีเอชซีพีเอเจ้นท์ (neutron-dhcp-agent) ทำหน้าที่ส่งค่าไอพีแอดเดรสให้กับวีเอ็ม 
  <li>	นิวตรอนเมตาดาต้าเอเจ้น (neutron-metadata-agent) ทำหน้าที่ช่วยให้วีเอ็มและนิวตรอนเอเจ้นท์สามารถขอข้อมูลเมตาดาต้าจากโนวาได้ และ 
  <li>	นิวตรอนโอเพ่นวีสวิชต์เอเจ้นท์ (neutron-openvswitch-agent) ทำหน้าที่จัดการสวิชต์เสมือนบนเครื่องเน็ตเวิร์คและคอมพิวต์โฮส 
</ul>
<p>
นอกจากนั้นนิวตรอนยังมีซอฟต์แวร์เอเจ้นท์ที่รันอยู่บนเครื่องคอมพิวต์โฮสแต่ละเครื่องด้วยได้แก่ 1) นิวตรอนดีเอชซีพีเอเจ้นท์ 2) นิวตรอนโอเมตาดาต้าเอเจ้นท์ และ 3) นิวตรอนโอเพ่นวีสวิชต์เอเจ้นท์ เอเจ้นท์เหล่านี้ประสานงานกับโนวาเพื่อให้วีเอ็มสามารถสื่อสารข้อมูลได้อย่างถูกต้องและมีประสิทธิภาพ
<p>
ในการติดตั้งนิวตรอน ผู้ติดตั้งต้องรันสคริปต์ต่อไปนี้บนเครื่องคอนโทรเลอร์ได้แก่ 1) สคริปต์ exe-stage21-SUDO-neutron-database.sh เพื่อสร้างเทเบิ้ลในระบบฐานข้อมูล 2) exe-stage22-USER-neutron-endpoints.sh เพื่อสร้างยูอาร์แอลสำหรับให้ผู้ใช้หรือคอมโพเน้นอื่นขอใช้บริการ 3) exe-stage23-SUDO-neutron.sh เพื่อติดตั้งซอฟต์แวร์แพคเกจของนิวตรอน โดยเฉพาะอย่างยิ่งนิวตรอนเซริฟเวอร์เอเจ้นท์ ซึ่งจะรันอยู่ที่เครื่องคอนโทรเลอร์นี้ และ 4) exe-stage24-USER-verify-neutron.sh เพื่อตรวจสอบว่าการติดตั้งขั้นต้นบนเครื่องคอนโทรเลอร์เป็นไปอย่างถูกต้อง
<pre>
On controller: 
$ sudo ./exe-stage21-SUDO-neutron-database.sh
$ ./exe-stage22-USER-neutron-endpoints.sh
$ sudo ./exe-stage23-SUDO-neutron.sh
$ ./exe-stage24-USER-verify-neutron.sh
</pre>
<pre>
Video 15: <a href="https://youtu.be/20Rk3KcNeBs">https://youtu.be/20Rk3KcNeBs</a>
</pre>
ถัดจากนั้นผู้ติดตั้งจะต้องล็อกอินเข้าสู่เครื่องเน็ตเวิร์ค เพื่อรันสคริปต์ exe-stage25-SUDO-network-neutron.sh เพื่อติดตั้งนิวตรอนซอฟต์แวร์แพคเกจ
<pre>
On network: 
$ cd OPSInstaller/network/
$ sudo ./exe-stage25-SUDO-network-neutron.sh
</pre>
<pre>
Video 16: <a href="https://youtu.be/GmTl5_cLURc">https://youtu.be/GmTl5_cLURc</a>
</pre>
หลังจากนั้น ผู้ติดตั้งต้องกลับมารันสคริปต์ exe-stage26-SUDO-reconfig-neutron-nova.sh เพื่อรันโอเพ่นวีสวิชต์ (openvswitch) บนเครื่องคอนโทรเลอร์
<pre>
On controller: 
$ sudo ./exe-stage26-SUDO-reconfig-neutron-nova.sh
</pre>
ถัดไป ผู้ติดตั้งต้องกลับไปยังเครื่องเน็ตเวิร์คและรันสคริปต์ exe-stage27-SUDO-ovs-service.sh เพื่อกำหนดค่าในไฟล์กำหนดค่าของนิวตรอนเอเจ้นท์และรันนิวตรอนเอเจ้นท์เหล่านั้นบนเครื่องเน็ตเวิร์ค
<pre>
On network: 
$ cd OPSInstaller/network/
$ sudo ./exe-stage27-SUDO-ovs-service.sh
</pre>
หลังจากนั้น ผู้ติดตั้งจะต้องกลับไปยังเครื่องคอนโทรเลอร์เพื่อรันสคริปต์ exe-stage28-USER-verify-neutron2.sh เพื่อตรวจสอบความถูกต้องของการติดตั้งนิวตรอน 
<pre>
On controller: 
$ ./exe-stage28-USER-verify-neutron2.sh
</pre>
ต่อจากนั้น ผู้ติดตั้งจะต้องล๊อกอินเข้าสู่เครื่องคอมพิวต์ และรันสคริปต์ exe-stage29-SUDO-compute-neutron.sh เพื่อติดตั้งนิวตรอนเอเจ้นท์ และปรับเปลี่ยนไฟล์กำหนดค่าของโนวาให้โนวาคอมพิวต์เอเจ้นท์สามารถปฏิบัติงานร่วมกับนิวตรอนเอเจนท์บนเครื่องคอมพิวต์ได้ เมื่อเสร็จแล้ว ผู้ติดตั้งจะต้องล็อกอินเข้าสู่เครื่องคอมพิวต์หนึ่งเพื่อทำแบบเดียวกัน
<pre>
On compute & compute1: 
$ cd OPSInstaller/compute/
$ sudo ./exe-stage29-SUDO-compute-neutron.sh
</pre>
<pre>
Video 17: <a href="https://youtu.be/gv65B1OXkco">https://youtu.be/gv65B1OXkco</a>
</pre>
หลังจากนั้น ผู้ติดตั้งจะกลับมาที่เครื่องคอนโทรเลอร์เพื่อรันสคริปต์ exe-stage30-USER-verify-neutron3.sh เพื่อตรวจสอบความถูกต้องอีกครั้งหนึ่ง
<pre>
On controller: 
$ ./exe-stage30-USER-verify-neutron3.sh
</pre>
<pre>
Video 18: <a href="https://youtu.be/1qCPJSZEjAI">https://youtu.be/1qCPJSZEjAI</a>
</pre>
<p>
ในอันดับถัดไป ผู้เขียนจะข้ามการรันสคริปต์ “*stage31*.sh” ถึง “*stage35*.sh” เนื่องจากสคริปต์เหล่านั้นใช้สำหรับกำหนดให้นิวตรอนเปลี่ยนโหมดการปฏิบัติงานแบบใช้เครื่องเนตเวิร์คเป็นศูนย์กลางสำหรับรันเร้าเตอร์เสมือน เป็นแบบกำหนดให้เครื่องคอมพิวต์โฮสทุกเครื่องรันเร้าเตอร์เสมือนได้ด้วย หรือเรียกอีกอย่างหนึ่งว่าเป็นนิวตรอนคอมโพเน้นที่ปฏิบัติงานแบบเร้าเตอร์แบบกระจาย (Distributed Virtual Router) หรือดีวีอาร์ (DVR) ซึ่งผู้เขียนเห็นว่าเป็นที่นิยมน้อยกว่านิวตรอนแบบปกติ และจะไม่กล่าวถึงการติดตั้งนิวตรอนแบบดีวีอาร์ ณ ที่นี้
<p>
<h3>11 ทดสอบโอเพ่นสแตคด้วยการสร้างระบบเครือข่ายเสมือนตั้งต้น (Test Initial Networks)</h3>
<p>
ในอันดับถัดไป ผู้ติดตั้งจะรันสคริปต์ exe-stage36-USER-initial-network.sh บนเครื่องคอนโทรเลอร์เพื่อสร้างระบบเครือข่ายตั้งต้น ด้วยคอมมานด์ไลน์อินเตอร์เฟส (Command Line Interfaces) หรือ ซีแอลไอ (CLI) ของระบบโอเพ่นสแตค ระบบเครือข่ายเสมือนตั้งต้นที่สคริปต์จะสร้างให้ได้แก่ 
<ul>
  <li>	ระบบเครือข่ายโพรไวเดอร์ (Provider Network) ซึ่งเป็นระบบเครือข่ายเสมือนที่เป็นตัวแทนของระบบเครือข่ายภายนอกของระบบโอเพ่นสแตค ข้อมูลที่ส่งออกจากวีเอ็มจะต้องถูกเร้ามาที่ระบบเครือข่ายนี้เพื่อส่งข้อมูลออกสู่โลกภายนอก ค่าบล้อคของไอพีบนระบบเครือข่ายภายนอกที่โอเพ่นสแตคสามารถใช้ได้ (ตามที่ระบุค่าไว้พารามีเตอร์ START_FLOATING_IP และ END_FLOATING_IP ในไฟล์ install_paramrc.sh) จะได้รับการกำหนดให้เป็นคุณสมบัติหนึ่งของสับเนต (subnet) ของระบบเครือข่ายโพรไวเดอร์นี้
  <li>	ระบบเครือข่ายภายในสำหรับผู้ใช้ระบบโอเพ่นสแตคที่เป็นแอดมิน และระบบเครือข่ายภายในสำหรับผู้ใช้แบบธรรมดา สคริปต์จะสร้างเร้าเตอร์เสมือนให้กับระบบเครือข่ายทั้งสอง เร้าเตอร์จะถูกเชื่อมต่อเข้ากับระบบเครือข่ายโพรไวเดอร์เพื่อให้วีเอ็มที่ใช้ระบบเครือข่ายภายในสามารถสื่อสารกับระบบเครือข่ายภายนอกได้
</ul>
<pre>
On controller: 
$ ./exe-stage36-USER-initial-network.sh
</pre>
<pre>
Video 19: <a href="https://youtu.be/Ib9OpV8CoyE">https://youtu.be/Ib9OpV8CoyE</a>
</pre>
<p>
<h3>12 ติดตั้งฮอไรสัน (Horizon Installation)</h3>
<p>
ก่อนอื่น ณ. จุดนี้ผู้ใช้ระบบโอเพ่นสแตค สามารถออกคำสั่งให้โอเพ่นสแตคปฏิบัติงานทุกอย่างที่คอมพเน้นหลักได้แก่ คีย์สโตน แกล๊นซ์ โนวา และนิวตรอน ทำได้ ผ่านทางคอมมานด์ไลน์ ซึ่งผู้เขียนจะได้กล่าวถึงคำสั่งเหล่านั้นต่อไปในอนาคต 
<p>
อย่างไรก็ตาม ผู้พัฒนาโอเพ่นสแตคได้พัฒนาคอมโพเน้นอีกคอมโพเน้นหนึ่งชื่อฮอไรซัน (Horizon) หรือ โอเพ่นสแตคดาสช์บอร์ด (OpenStack Dashboard)  ที่ให้บริการเว็บไซต์ ที่ช่วยให้ผู้ใช้สามารถออกคำสั่งให้โอเพ่นสแตคปฏิบัติงานตามฟังก์ชั่นที่คอมโพเน้นทั้งสี่ให้บริการ 
<p>
ในการติดตั้งฮอไรซัน ผู้ติดตั้งจะต้องรันสคริปต์ exe-stage37-SUDO-horizon.sh บนเครื่องคอนโทรเลอร์ ซึ่งสคริปต์จะติดตั้งแพคอกจของฮอไรซัน และรีสตาร์ตเว็บเซริฟเวอร์ หลังจากที่ติดตั้งแล้วผู้ใช้สามารถเข้าใช้บริการได้ที่ยูอาร์แอล “http://10.100.20.11/horizon” 
<pre>
On controller: 
$ sudo ./exe-stage37-SUDO-horizon.sh
</pre>
<pre>
Video 20: <a href="https://youtu.be/LMM36dzvBec">https://youtu.be/LMM36dzvBec</a>
</pre>
<p>
<h3>13 ติดตั้งซินเดอร์ (Cinder Installation)</h3>
<p>
ซินเดอร์ (Cinder) หรือ โอเพ่นสแตคโวลู่ม (OpenStack Volume) เป็นคอมโพเน้นที่อนุญาตให้ผู้ใช้สร้างเกสโอเอสอิมเมจของวีเอ็ม บนบล้อกสตอเรจ (Block Storage) หรือสร้างบล้อกสตอเรจขึ้นตามขนาดที่ต้องการและนำไปเชื่อมต่อให้เป็นอุปกรณ์หนึ่งของวีเอ็มก็ได้ ซินเดอร์ประกอบไปด้วยซอฟต์แวร์เอเจ้นที่รันอยู่บนเครื่องคอนโทรเลอร์ และเอยู่บนครื่องสตอเรจโฮส (storage host)
<p>
เครื่องสตอเรจโฮส เป็นเครื่องโอสคอมพิวเตอร์ที่มีอุปกรณ์หน่วยเก็บข้อมูลที่จะถูกนำมาใช้เป็นบล้อคสตอเรของระบบซินเดอร์ ในระบบโอเพ่นสแตค เครื่องสตอเรจโฮสอาจมีมากกว่าหนึ่งเครื่องก็ได้ แต่ในตัวอย่างการติดตั้งนี้เราจะสมมุติว่าเครื่องคอมพิวต์เป็นเครื่องสตอเรจโอส และสมมุติดิสค์ว่างเปล่าสองดิสค์บนเครื่องคอมพิวต์จะถูกนำมาใช้เป็นทรัพยากร ดังภาพ 7-1
<p>
ในการติดตั้ง ผู้ติดตั้งจะต้องรันสคริปต์บนเครื่องคอนโทรเลอร์ ดังนี้ 1) สคริปต์ exe-stage38-SUDO-cinder-database.sh ทำหน้าที่สร้างเทเบิ้ลสำหรับซินเดอร์ในระบบฐานข้อมูล 2) สคริปต์ exe-stage39-USER-cinder-endpoints.sh ทำหน้าที่สร้างยูอาร์แอลเพื่อให้ผู้ใช้หรือคอมโพเน้นอื่นเรียกใช้บริการซินเดอร์ และ 3) สคริปต์ exe-stage41-SUDO-cinder-storage.sh เพื่อติดตั้งซินเดอร์แพคเกจ
<pre>
On controller: 
$ sudo ./exe-stage38-SUDO-cinder-database.sh
$ ./exe-stage39-USER-cinder-endpoints.sh
$ sudo ./exe-stage40-SUDO-cinder.sh
</pre>
<pre>
Video 21: <a href="https://youtu.be/rb2AHvrL5mU">https://youtu.be/rb2AHvrL5mU</a>
</pre>
<p>
ในอันดับถัดไป ผู้ติดตั้งต้องล็อกอินเข้าสู่เครื่องคอมพิวต์ และเช็คให้แน่ใจว่าเครื่องคอมพิวต์มีดิสค์เปล่าสองดิสค์เชื่อมต่อเป็นอุปกรณ์ไอโออยู่แล้ว ในจังหวะนี้ผู้ติดตั้งอาจต้องตรวจสอบด้วยว่าดิสค์เปล่าที่จะใช้มีชื่อของอุปกรณ์ตรงกันกับที่ระบุในสคริปต์ exe-stage41-SUDO-cinder-storage.sh หรือไม่ ถ้าไม่ตรงผู้ติดตั้งจะต้องปรับเปลี่ยนค่าในสคริปต์ให้หมาะสม 
<p>
ในตัวอย่างการติดตั้งนี้ ผู้เขียนได้กำหนดให้เครื่องคอมพิวต์มีดิสค์เปล่าสองดิสค์ ซึ่งเกสโอเอสตั้งชื่อเป็น <b>/dev/sdb</b> และ <b>/dev/sdb</b> ดังภาพที่ 1 ผู้ติดตั้งจะต้องตรวจสอบให้แน่ใจว่าชื่อและจำนวนของดิสค์ที่ใช้ในสคริปต์ดังกล่าวถูกต้อง
<p>
หลังจากนั้นผู้ติดตั้งจึงจะรันสคริปต์ exe-stage41-SUDO-cinder-storage.sh เพื่อฟอร์แมตบล้อกสตอเรจและรีจิสเตอร์บล้อคสตอเรจให้เป็นทรัพยากรของซินเดอร์ 
<pre>
On compute: 
$ cd OPSInstaller/compute/
$ sudo ./exe-stage41-SUDO-cinder-storage.sh
</pre>
<pre>
Video 22: <a href="https://youtu.be/Usf2_FFvSus">https://youtu.be/Usf2_FFvSus</a>
Video 23: <a href="https://youtu.be/x1BcL3WzfB8">https://youtu.be/x1BcL3WzfB8</a>
</pre>
<p>
<h3>14 สรุปการติดตั้ง</h3>
<p>
ที่ผ่านมาผู้เขียนได้บรรยายการติดตั้งระบบโอเพ่นสแตคด้วยสคริปต์ เราได้ติดตั้งคอมโพเน้นพื้นฐานห้าคอมโพเน้นของระบบโอเพ่นสแตค ได้แก่ คียสโตน แกล๊นซ์ โนวา นิวตรอน ฮอไรซัน และซินเดอร์ ผู้อ่านสามารถหาข้อมูลเกี่ยวกับสคริปต์ที่ใช้ในการติดตั้งได้โดยเข้าไปดูรายละเอียดที่ไฟล์ configuration files ที่เกี่ยวข้องใน github page นี้ นอกจากนั้น ผู้ติดตั้งสามารถศึกษารายละเอียดของสคริปต์และ configuration files ในการติดตั้งของตนเอง ได้จากไฟล์ในไดเรกทอรี่ /home/openstack/openstack-victoria-basic-installer/OPSInstaller บนเครื่องคอนโทรเลอร์
<p>
<h3>15 เบ็ดเตล็ด</h3>
<p>
<b>ทิปที่ 1.</b> เมื่อผู้ใช้ต้องการใช้อูบุนตูอิมเมจจาก https://cloud-images.ubuntu.com หลังจากที่ผู้ใช้อัพโหลดอิมเมจเข้าสู่แกล๊นซืแล้ว 
มื่อรันวีเอ็ม ผู้ใช้สามารถกำหนดวิธีการล็อกอินแบบใดแบบหนึ่งต่อไปนี้  
<ul>
<li>สร้าง ssh keypair ในโอเพ่นสแตคและดาวน์โหลด private key มาเก็บไว้ และกำหนดให้วีเอ็มใช้ keypair นั้นในการล็อกอิน จะทำให้ล็อกอินได้จากเครื่อง รีโมทคอมพิวเตอร์ โดยไม่ต้องป้อนพาสเวิร์ด
<li>ใน customization script ให้กำหนดค่า เช่น
<pre>
#cloud-config
password: vasabilab
chpasswd: { expire: False }
ssh_pwauth: True
</pre>
และมาร์คเครื่องหมายถูก บนปุ่ม <b>configuration drive</b> จะทำให้ล็อกอินได้โดยใช้ username: "ubuntu" และ password: "vasabilab"
</ul>
<p>
<h3>อ้างอิง</h3>
<p><p>
[1] https://docs.openstack.org/install-guide/ <br>
[2] https://docs.openstack.org/arch-design/ <br>
[3] https://mariadb.org <br>

  
