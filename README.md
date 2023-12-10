1. Mô hình luận lý
Nhằm xây một đám mây cung cấp các dịch vụ về hạ tầng, các máy chủ, tài nguyên tính toán (RAM, CPU), lưu trữ. Trên đó người dùng sẽ tạo các máy ảo với hệ điều hành, triển khai ứng dụng theo nhu cầu của mình nên mô hình dịch vụ được lựa chọn để triển khai hệ thống là Infrastructure as a Service (IaaS).
Các dịch vụ OpenStack cần thiết để triển khai hệ thống theo mô hình IaaS được mô tả ở hình và bảng bên dưới.
![image](https://github.com/khoan13583/cai_dat_openstack_victoria/assets/88971108/28f391d4-a766-488d-849a-193ba0bde830)

Dịch vụ cung cấp	Tên dịch vụ	Mô tả
Indentity Service	Keystone	Quản lý người dùng, cung cấp dịch vụ chứng thực
Compute Service	Nova	Quản lý máy ảo
Image Service	Glance	Quản lý đĩa ảo (Kernel Images, Disk Image)
Dashboard Service	Horizon	Cung cấp bảng điều khiển qua nền Web
Block Storage	Cinder	Quản lý lưu trữ cho máy ảo
Network Service	Neutron	Quản lý mạng ảo


2. 
