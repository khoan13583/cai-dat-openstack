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


4. 



