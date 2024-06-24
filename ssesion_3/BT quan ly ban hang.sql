create database quanLyBanHang;
use quanLyBanHang;

create table Customers (
cID int primary key,
Name varchar(25),
cAge tinyint
);

create table Orders (
oID int primary key,
cID int,
oDate datetime,
oTotalPrice int,
foreign key(cID) references Customers(cID) 
);

create table Products (
pID int primary key,
pName varchar(25),
pPrice int
);

create table OrderDetail  (
oID int,
pID int,
odQTY int,
foreign key(oID) references Orders(oID),
foreign key(pID) references Products(pID),
primary key(oID,pID)
);

select oID , oDate , oTotalPrice from orders;

select c.Name as 'khách Hàng' , p.pName as 'Sản phẩm đã mua' from orders o
join customers c on c.cID = o.cID
join orderdetail od on od.oID = o.oID
join products p on p.pID = od.pID;

select c.Name from customers c
left join orders o on  c.cID = o.cID
where o.cID is null ;

select o.oID as 'Mã hóa đơn', o.oDate as 'Ngày bán' , sum(od.odQTY * p.pPrice) as 'Tổng tiền' from orders o
join orderdetail od on od.oID = o.oID
join products p on p.pID = od.pID
group by od.oID;


