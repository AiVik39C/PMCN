create database QLCF
 

create table nhanvien
(
	manv nvarchar(20) primary key,
	hoten nvarchar(50),
	ngaysinh nvarchar(15),
	gtinh nvarchar(3),
	chucvu nvarchar(30),
)
create table khachhang
(
	makh nvarchar(20) primary key,
	hoten nvarchar(50),
	ngaysinh nvarchar(15),
	gtinh nvarchar(3),
	sdt nvarchar(10),
	diem nvarchar(5)
)

create table ban
(
	maban nvarchar(20) primary key,
	tenban nvarchar(20),
	soluongkhach int,
	checkban int
	
)
create table taikhoan
(
	tentaikhoan nvarchar(20) primary key,
	matkhau nvarchar(8)
	
)
create table mondagoi
(
	tenmon nvarchar(300),
	giatien decimal,
	maban nvarchar(20),
	soluong int,
	constraint maban_FK foreign key(maban) references ban(maban)
	
)
create table menu
(
	mamon nvarchar(20) primary key,
	ten_mon nvarchar(400),
	giatien decimal
		
)
create table kho
(
	mamh nvarchar(20) primary key,
	tenhang nvarchar(400),
	giatien decimal,
	donvtinh nvarchar(15),
	ngaynhap nvarchar(15),
		
)
create table hoadon
(
	mahd nvarchar(10) primary key,
	manv nvarchar(20),
	makh nvarchar(20),
	maban nvarchar(20),
	thanhtienhd decimal,
	constraint manv_FK foreign key(manv) references nhanvien(manv),
	constraint makh_FK foreign key(makh) references khachhang(makh),
	constraint maban2_FK foreign key(maban) references ban(maban)
)