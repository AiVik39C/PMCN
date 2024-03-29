CREATE DATABASE CAPHE

USE CAPHE

--NHANVIEN
CREATE TABLE NHANVIEN
(	manv Int Identity PRIMARY KEY,
	TenNV Nvarchar(100)NOT NULL,
	Ngaysinh Date NOT NULL,
	Sodienthoai Nvarchar(11) NOT NULL,
	Gioitinh Nvarchar(10) NOT NULL CHECK(Gioitinh=N'Nữ' or Gioitinh=N'Nam')DEFAULT N'Nam',--1: N? 0: NAM
	Username Nvarchar(100)NOT NULL,
	Passwd Nvarchar(1000)NOT NULL,
	Quyen Nvarchar(1000) NOT NULL CHECK(Quyen=N'NHÂN VIÊN' or Quyen=N'ADMIN')DEFAULT N'NHÂN VIÊN'
)
drop table NHANVIEN

--KHACHHANG
CREATE TABLE KHACHHANG
(	maKH Int Identity PRIMARY KEY,
	TenKH Nvarchar(100)NOT NULL,
	Ngaysinh Date NOT NULL,
	Sodienthoai Nvarchar(11) NOT NULL,
	Gioitinh Nvarchar(10) NOT NULL CHECK(Gioitinh=N'Nữ' or Gioitinh=N'Nam')DEFAULT N'Nam',--1: N? 0: NAM
	tichluy FLOAT default 0
)
drop table KHACHHANG
--FOOD CATEGORY
CREATE TABLE FoodCategory
(	id Int IDENTITY PRIMARY KEY,
	name Nvarchar(100)NOT NULL
)
-- food
CREATE TABLE Food
(	id Int IDENTITY PRIMARY KEY,
	name Nvarchar(100)NOT NULL,
	idCategory INT Not Null,
	Gia Float NOT NULL,
	FOREIGN KEY (idCategory) REFERENCES FoodCategory(id)
)

--Ban
CREATE TABLE BAN
(
	IDBAN INT IDENTITY(1,1) PRIMARY KEY,
	TEN NVARCHAR(50) NOT NULL,
	TRANGTHAI NVARCHAR(20) CHECK(TRANGTHAI=N'Trống' or TRANGTHAI=N'Có Người') default N'Trống' not null,
	ODER INT NOT NULL,
)
--BILL
CREATE TABLE Bill
(	id Int IDENTITY PRIMARY KEY,
	dateCheckin date,
	dateCheckout date,
	idban int Not null,
	idnv int not null,
	trangthai nvarchar(100) CHECK(trangthai=N'Chưa' or trangthai=N'Thanh toán') default N'Chưa' not null,
	FOREIGN KEY (idban) REFERENCES BAN(IDBAN),
	FOREIGN KEY (idnv) REFERENCES NHANVIEN(manv)
)
drop table Bill

-- BILLINFO 
CREATE TABLE BillInfo
(	id Int IDENTITY PRIMARY KEY,
	idbill INT NOT NULL,
	idban int,
	idfood INT NOT NULL,
	idnv INT not null,
	idkh INT not null,
	soluong INT NOT NULL DEFAULT 0,
	FOREIGN KEY (idbill) REFERENCES Bill(id),
	FOREIGN KEY (idfood) REFERENCES Food(id),
	FOREIGN KEY (idnv) REFERENCES NHANVIEN(manv),
	FOREIGN KEY (idkh) REFERENCES KHACHHANG(maKH),
	FOREIGN KEY (idban) REFERENCES BAN(IDBAN)
)	
drop table BillInfo
CREATE TABLE Bill_OLD
(
id_OLD INT IDENTITY(1,1)PRIMARY KEY,
idbill INT NOT NULL ,
idban INT NOT NULL,
manv char(20) NOT NULL,
Ngaylap DATE NOT NULL DEFAULT GETDATE(),
Trangthai NVARCHAR(20) DEFAULT N'Chưa' NOT NULL,
Tongtien FLOAT DEFAULT 0 NOT NULL,
CONSTRAINT IDHD_DUYNHAT UNIQUE (idbill)
)
CREATE TABLE BillInfo_OLD
(
idbillinfo_OLD INT IDENTITY(1,1)PRIMARY KEY,
idbill_OLD INT NOT NULL,
idfood INT NOT NULL,
soluong INT DEFAULT 0 NOT NULL,
FOREIGN KEY(idbill_OLD) REFERENCES Bill_OLD(id_OLD)
)
-- Kho
create table Kho
(
	mamh nvarchar(20) primary key,
	Tenhang nvarchar(400),
	Gia decimal,
	DVT nvarchar(1000)CHECK(DVT=N'Thùng' or DVT=N'Kg' or DVT=N'Lon' ) default N'Thùng' not null,
	Ngaynhap Date
		
)
delete  NHANVIEN

--
SELECT * FROM Account WHERE Username = N'admin' and Passwd = N'admin'
SELECT * FROM NHANVIEN
select * from BAN
SELECT COUNT(*) FROM Account WHERE Account.Username='admin' AND Account.Passwd='admin'

SELECT Account.Quyen,NHANVIEN.TenNV,NHANVIEN.manv FROM Account INNER JOIN NHANVIEN ON Account.MaNV=NHANVIEN.manv WHERE Account.Username='admin' AND Account.Passwd='admin'

SELECT * FROM BAN ORDER BY ODER ASC
SELECT * FROM BAN WHERE BAN.TRANGTHAI=N'Trống'
SELECT * FROM BAN WHERE BAN.TRANGTHAI=N'Có người'

select Bill.id from Bill where Bill.idban='1'

INSERT INTO Bill(dateCheckin,dateCheckout,idban,idnv,trangthai) VALUES('9-9-2019','9-9-2019','1','1',N'Chưa')
select * from Bill

UPDATE Bill SET dateCheckin='10-11-2019',dateCheckout='10-11-2019',idban='3',idnv='3',trangthai='0' WHERE id='3'

DELETE FROM Bill WHERE id='1'
SELECT COUNT(*) from Bill where Bill.idban='1'
DELETE FROM Bill WHERE idban='4'
select Bill.idban from Bill where Bill.id='3'
UPDATE Bill SET idban='1' WHERE id='3'
--load billinfo
SELECT BillInfo.id,BillInfo.idbill,BAN.TEN,NHANVIEN.TenNV,KHACHHANG.TenKH,FoodCategory.name,Food.name,BillInfo.soluong,Food.Gia,(BillInfo.soluong*Food.Gia)
FROM BillInfo
inner join Food on BillInfo.idfood=Food.id
inner join BAN on BillInfo.idban=BAN.IDBAN
inner join NHANVIEN on BillInfo.idnv= NHANVIEN.manv
inner join KHACHHANG on BillInfo.idkh= KHACHHANG.maKH
inner join FoodCategory on Food.idCategory=FoodCategory.id
WHERE BillInfo.idban='1'
--load billinfo thanh toán
SELECT Food.id,Food.name,BillInfo.soluong,Food.Gia,(BillInfo.soluong*Food.Gia),FoodCategory.name
FROM BillInfo
inner join Food on BillInfo.idfood=Food.id
inner join FoodCategory on Food.idCategory=FoodCategory.id
WHERE BillInfo.idbill='3'
--
INSERT INTO BillInfo(idbill,idban,idfood,idnv,idkh,soluong) VALUES('5','4','4','1','3','4')
select * from BillInfo
--
DELETE FROM BillInfo WHERE idbill='3' AND idfood='4'
--Nhanvien
select * from NHANVIEN
INSERT INTO NHANVIEN(TenNV,Ngaysinh,Sodienthoai,Gioitinh,Username,Passwd,Quyen) VALUES(N'Phan Hoài Thu','2-4-1998','035664899','0','thu222','thu222',N'NHÂN VIÊN')
--load nv
SELECT NHANVIEN.manv,NHANVIEN.TenNV,NHANVIEN.Ngaysinh,NHANVIEN.Sodienthoai,NHANVIEN.Gioitinh,Account.Username,Account.Passwd,Account.Quyen FROM NHANVIEN
inner join Account on NHANVIEN.manv=Account.MaNV
--
DELETE FROM NHANVIEN WHERE manv='5'
SELECT COUNT(*)+ABS(CHECKSUM(NewId())) % 1000 FROM NHANVIEN
--tìm tên nv
SELECT NHANVIEN.manv,NHANVIEN.TenNV,NHANVIEN.Ngaysinh,NHANVIEN.Sodienthoai,NHANVIEN.Gioitinh,Account.Username,Account.Passwd,Account.Quyen
FROM NHANVIEN
inner join Account on NHANVIEN.manv=Account.MaNV
where NHANVIEN.TENNV like '%'+'Vi'+'%'
--load bill old
SELECT Bill_OLD.id_OLD,Bill_OLD.idbill,BAN.TEN,NHANVIEN.TenNV,Bill_OLD.Ngaylap,Bill_OLD.Trangthai,Bill_OLD.Tongtien
FROM Bill_OLD
INNER JOIN Ban ON Bill_OLD.idban=BAN.IDBAN
INNER JOIN NHANVIEN ON Bill_OLD.manv=NHANVIEN.manv
--load bill old không id
SELECT Bill_OLD.id_OLD,BAN.TEN,NHANVIEN.TenNV,Bill_OLD.Ngaylap,Bill_OLD.Trangthai,Bill_OLD.Tongtien
FROM Bill_OLD
INNER JOIN BAN ON Bill_OLD.idban=BAN.IDBAN
INNER JOIN NHANVIEN ON Bill_OLD.manv=NHANVIEN.manv
INSERT INTO Bill_OLD(idbill,idban,manv,Ngaylap,Trangthai,Tongtien) VALUES('4','3','3','8-8-2019',N'Thanh toán','100000')
select * from Bill_OLD
DELETE FROM Bill_OLD WHERE id_OLD=''
--tìm bill theo tên bàn
SELECT Bill_OLD.idbill,BAN.TEN,NHANVIEN.TenNV,Bill_OLD.Ngaylap,Bill_OLD.Trangthai,Bill_OLD.Tongtien
FROM Bill_OLD
INNER JOIN BAN ON Bill_OLD.idban=BAN.IDBAN
INNER JOIN NHANVIEN ON Bill_OLD.manv=NHANVIEN.manv
WHERE BAN.TEN =N'Bàn 4' 
-- tìm bill theo tên nv
SELECT Bill_OLD.idban,BAN.TEN,NHANVIEN.TenNV,Bill_OLD.Ngaylap,Bill_OLD.Trangthai,Bill_OLD.Tongtien
FROM Bill_OLD
INNER JOIN BAN ON Bill_OLD.idban=BAN.IDBAN
INNER JOIN NHANVIEN ON Bill_OLD.manv=NHANVIEN.manv
WHERE NHANVIEN.TENNV =N'Lê Thị Ái Vi'  
-- load bill theo ngày
SELECT Bill_OLD.idbill,BAN.TEN,NHANVIEN.TenNV,Bill_OLD.Ngaylap,Bill_OLD.Trangthai,Bill_OLD.Tongtien
FROM Bill_OLD
INNER JOIN BAN ON Bill_OLD.idban=BAN.IDBAN
INNER JOIN NHANVIEN ON Bill_OLD.manv=NHANVIEN.manv
WHERE DAY(Bill_OLD.Ngaylap)='11'
-- load bill theo năm
SELECT Bill_OLD.idbill,BAN.TEN,NHANVIEN.TenNV,Bill_OLD.Ngaylap,Bill_OLD.Trangthai,Bill_OLD.Tongtien
FROM Bill_OLD
INNER JOIN BAN ON Bill_OLD.IDBAN=BAN.IDBAN
INNER JOIN NHANVIEN ON Bill_OLD.manv=NHANVIEN.manv
WHERE MONTH(Bill_OLD.Ngaylap)='11'
-- load billinfo old
SELECT BillInfo_OLD.idbillinfo_OLD,BillInfo_OLD.idbill_OLD,BillInfo_OLD.idfood,Food.name,BillInfo_OLD.soluong,Food.Gia,(BillInfo_OLD.soluong*Food.Gia)
FROM BillInfo_OLD
INNER JOIN Food ON BillInfo_OLD.idfood=Food.id
WHERE idbill_OLD='1'
--
SELECT Food.name,BillInfo_OLD.soluong,Food.Gia,(BillInfo_OLD.soluong*Food.Gia)
FROM BillInfo_OLD
INNER JOIN Food ON BillInfo_OLD.idfood=Food.id
WHERE idbill_OLD='2'
-- 
INSERT INTO BillInfo_OLD(idbill_OLD,idfood,soluong) VALUES ('3','5','6')
select * from BillInfo_OLD
--
DELETE FROM BillInfo_OLD WHERE idbill_OLD='3'
--Food
SELECT Food.id,Food.idCategory,FoodCategory.name,Food.name,Food.Gia FROM Food inner join FoodCategory on FoodCategory.id=Food.idCategory
--
SELECT Food.name,Food.Gia FROM Food
--
SELECT * FROM Food WHERE food.idCategory='3'
--
SELECT name,Gia FROM Food WHERE idCategory='6'
--
SELECT Food.id,FoodCategory.name,Food.name,Food.Gia FROM Food 
INNER JOIN FoodCategory ON Food.idCategory=FoodCategory.id WHERE Food.name LIKE '%Cà%'
--
select * from Food
INSERT INTO Food(idCategory,name,Gia) VALUES('3',N'Cà phê sữa đá','10000')
--
UPDATE Food SET idCategory='4',name=N'Kem sầu riêng',Gia='20000' WHERE id='7'
--
DELETE FROM Food WHERE id='7'
--FoodCategory
SELECT * FROM FoodCategory
--
INSERT INTO FoodCategory(name) VALUES(N'Sinh tố')
--
UPDATE FoodCategory SET name=N'Trà nhiệt đới' WHERE id='1'
--
DELETE FROM FoodCategory WHERE id='7'
--
UPDATE BillInfo SET idfood='2',soluong='1' where idbill='5'
select * from BillInfo
--
UPDATE NHANVIEN SET TenNV=N'Phan Nhi A',Ngaysinh ='3-2-1995',Sodienthoai='035446622',Gioitinh='1',Username='abcdef',Passwd='abcdef',Quyen=N'NHÂN VIÊN'
 where manv='5'
--
SELECT * FROM NHANVIEN
--
SELECT Food.name,Food.Gia FROM Food 
SELECT Food.id,FoodCategory.name,Food.name,Food.Gia FROM Food inner join FoodCategory on FoodCategory.id=Food.idCategory
--

