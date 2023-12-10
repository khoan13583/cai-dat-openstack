1. Mô hình luận lý

Nhằm xây một đám mây cung cấp các dịch vụ về hạ tầng, các máy chủ, tài nguyên tính toán (RAM, CPU), lưu trữ. Trên đó người dùng sẽ tạo các máy ảo với hệ điều hành, triển khai ứng dụng theo nhu cầu của mình nên mô hình dịch vụ được lựa chọn để triển khai hệ thống là Infrastructure as a Service (IaaS).
  
Các dịch vụ OpenStack cần thiết để triển khai hệ thống theo mô hình IaaS được mô tả ở hình và bảng bên dưới:

![image](https://github.com/khoan13583/cai_dat_openstack_victoria/assets/88971108/28f391d4-a766-488d-849a-193ba0bde830)

Mô hình tổng quan của hệ thống ở mức luận lý:

![image](https://github.com/khoan13583/cai_dat_openstack_victoria/assets/88971108/0e62b8e7-7684-43d5-821d-9bd687869ed5)

Có bốn máy tính được kết nối trong một hệ thống mạng:

•	Một máy tính đóng vai trò là bộ điều khiển (Controller). Chịu trách nhiệm chạy các dịch vụ, phần mềm phục vụ các lệnh yêu cầu từ người dùng hệ thống; Xác minh danh tính của người dùng; Quản lý việc sử dụng tài nguyên và là vị trí hệ thống cơ sở dữ liệu dùng để lưu trữ dữ liệu của toàn bộ hệ thống.  
•	Một máy tính đóng vai trò quản lý hệ thống mạng (Network). Chịu trách nhiệm quản lý việc trao đổi dữ liệu giữa các máy tính ảo được tạo trong hệ thống OpenStack với các máy tính bên ngoài mạng Internet.  
•	Hai máy tính đóng vai trò tính toán (Compute và Compute1).  Đây là máy có trách nhiệm chạy các máy tính ảo được tạo ra bởi người dùng. Các dịch vụ và phần mềm của OpenStack trên bộ điều khiển quyết định máy ảo của người dùng sẽ chạy trên máy tính nào.  

2. Mô hình vật lý

Chuẩn bị bốn máy Ubuntu Server 20.04 có cấu hình như bảng bên dưới để triển khai hệ thống:

![image](https://github.com/khoan13583/cai_dat_openstack_victoria/assets/88971108/c3303e57-2885-4583-a4bb-4f1475bb2e92)

Mô hình cấu trúc của hệ thống máy tính và mạng để cài đặt hệ thống như hình bên dưới:

![image](https://github.com/khoan13583/cai_dat_openstack_victoria/assets/88971108/ee2463b8-036a-40ab-99e4-13c042bf4d9d)

Chuẩn bị hệ thống mạng kết nối bốn máy tính như sau:  
•	Mạng quản lý (Management Network – 192.l68.1.0/24): là hệ thống mạng giúp cho các dịch vụ, phần mềm của OpenStack trên các máy tính (của hệ thống) có để truyền đạt các lệnh và dữ liệu nhằm thực hiện các chức năng hệ thống khác nhau. Mạng này cũng được sử dụng để cài đặt các dịch vụ và phần mềm.  
•	Mạng đường hầm dữ liệu (Data Tunel Network – 10.0.1.0/24): là hệ thống mạng được sử dụng để liên lạc dữ liệu giữa các máy ảo có thể được cấu hình để chạy trên các máy chủ khác nhau.(Được sử dụng để liên lạc dữ liệu giữa các máy ảo và các bộ định tuyến ảo mà OpenStack tạo trên máy chủ mạng. Để truyền dữ liệu VM đến các hệ thống mạng bên ngoài và truyền dữ liệu từ các hệ thống mạng bên ngoài đến VM).  
•	Hệ thống mạng VLAN (VLAN Network): Các máy tính trong cùng VLAN có thể giao tiếp với nhau trong cùng một miền quảng bá.  
•	Mạng bên ngoài (External Network – 192.168.1.160 -- 200) : Dãy mạng cung cấp dịch vụ Internet.  

![image](https://github.com/khoan13583/cai_dat_openstack_victoria/assets/88971108/cd31235d-6eaa-44aa-83aa-6b02dd6d8e90)

3. Mô hình cài đặt  

Thông tin chi tiết các dịch vụ được cài đặt trên các Node được thể hiện như hình bên dưới:  

![image](https://github.com/khoan13583/cai_dat_openstack_victoria/assets/88971108/02b175f0-b5e7-4719-acdc-ea28bd49dccf)  

•	Máy tính đóng vai trò là bộ điều khiển (Controller): Dịch vụ cơ sở dữ liệu MariaDB, RabbitMQ, Keystone, Glance, Placement, Nova, Neutron, Horizon, Cinder.  
•	Máy tính đóng vai trò quản lý hệ thống mạng (Network): Dịch vụ cơ sở dữ liệu MariaDB, Neutron.  
•	Hai máy tính đóng vai trò tính toán (Compute và Compute1): Dịch vụ cơ sở dữ liệu MariaDB, Nova, Neutron, Cinder.  

4. Cài đặt hệ thống  

Việc triển khai hệ thống gồm 3 giai đoạn:  
1.	Tạo các máy ảo (có thể bỏ qua giai đoạn này nếu triển khai trên máy thật).  
2.	Cập nhật và cài đặt môi trường cho các máy ảo trước khi cài đặt.  
3.	Tiến hành bằng cách thực hiện các tập tin Shell Script đã được chuẩn bị theo từng bước như bên dưới.  

![image](https://github.com/khoan13583/cai_dat_openstack_victoria/assets/88971108/c0158b7d-b0e3-4203-9142-1b8d00b9d532)

Mô hình tóm tắt các bước cài đặt được mô tả ở hình bên dưới:  
Ghi chú:  

![image](https://github.com/khoan13583/cai_dat_openstack_victoria/assets/88971108/0a00e13b-b9e3-469b-9869-e0990c8f27ba)  

![image](https://github.com/khoan13583/cai_dat_openstack_victoria/assets/88971108/687e9a85-35a4-46aa-8f88-f2b8752abb8c)  \

5. Tiến hành cài đặt

Git clone về máy controller:  
$ screen  
$ git init  
$ git clone https://github.com/kasidit/openstack-victoria-basic-installer  
Cloning into 'openstack-victoria-basic-installer'...  
$ ls  
openstack-victoria-basic-installer  

7. Đ
  5.1. Cài đặt môi trường 



