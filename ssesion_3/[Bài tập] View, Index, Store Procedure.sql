create database demo;
use demo;

create table Products (
id int primary key auto_increment,
productCode int,
productName varchar(45),
productPrice double,
productAmount varchar(45),
productDescription varchar(45),
productStatus bit
);
INSERT INTO `demo`.`products` (`productCode`, `productName`, `productPrice`, `productAmount`, `productDescription`, `productStatus`) 
VALUES (113, 'iphone8', 7, 15, 'new', 1);

INSERT INTO `demo`.`products` (`productCode`, `productName`, `productPrice`, `productAmount`, `productDescription`, `productStatus`) 
VALUES (114, 'samsungS10', 8, 20, 'new', 1);

INSERT INTO `demo`.`products` (`productCode`, `productName`, `productPrice`, `productAmount`, `productDescription`, `productStatus`) 
VALUES (115, 'oppoF5', 4, 5, 'like new', 1);

INSERT INTO `demo`.`products` (`productCode`, `productName`, `productPrice`, `productAmount`, `productDescription`, `productStatus`) 
VALUES (116, 'xiaomiMi9', 6, 10, 'new', 1);

INSERT INTO `demo`.`products` (`productCode`, `productName`, `productPrice`, `productAmount`, `productDescription`, `productStatus`) 
VALUES (117, 'huaweiP30', 9, 8, 'new', 1);

INSERT INTO `demo`.`products` (`productCode`, `productName`, `productPrice`, `productAmount`, `productDescription`, `productStatus`) 
VALUES (118, 'nokia7.1', 5, 12, 'new', 1);

INSERT INTO `demo`.`products` (`productCode`, `productName`, `productPrice`, `productAmount`, `productDescription`, `productStatus`) 
VALUES (119, 'sonyXperiaXZ3', 7, 7, 'like new', 1);

INSERT INTO `demo`.`products` (`productCode`, `productName`, `productPrice`, `productAmount`, `productDescription`, `productStatus`) 
VALUES (120, 'googlePixel3', 8, 6, 'new', 1);

INSERT INTO `demo`.`products` (`productCode`, `productName`, `productPrice`, `productAmount`, `productDescription`, `productStatus`) 
VALUES (121, 'onePlus7', 7, 9, 'new', 1);

INSERT INTO `demo`.`products` (`productCode`, `productName`, `productPrice`, `productAmount`, `productDescription`, `productStatus`) 
VALUES (122, 'lgG8ThinQ', 6, 4, 'like new', 1);

-- B3: 
alter table products add index idx_productName(productName);
explain select * from products where productName ='iphone7';
alter  table products drop index idx_productName;

alter table products add index idx_infor(productName,productPrice);
explain select * from products where productName ='iphone7' or productName ='oppoF3';
alter table products drop index idx_infor;
-- B4:
create view product_views as
select productCode,productName,productPrice,productStatus from products; 
create or replace view product_views as
select productCode,productName,productPrice,productDescription,productStatus
from products
where productDescription = 'new';

select * from view product_views;
drop view product_views;

-- B5:
-- Lay thong tin
DELIMITER //
create procedure findAllProducts() 
begin
select * from products;
end //
DELIMITER ; 

call findAllProducts();

-- them san pham moi 
DELIMITER //
drop procedure if exists addNewProduct//
create procedure addNewProduct()
begin
insert into products(`productCode`, `productName`, `productPrice`, `productAmount`, `productDescription`, `productStatus`) values (1,'iphone8',20,'10','new',0);
end //
DELIMITER ;
call addNewProduct();

-- sua thong tin theo id
DELIMITER //
create procedure updateProduct( 
in proCode int,
in proName varchar(45),
in proPrice double,
in proAmount varchar(45),
in proDescription varchar(45),
in proStatus bit
)
begin
update products
set 
	productName = proName,
    productPrice = proPrice,
    productAmount = proAmount,
    productDescription = proDescription,
    productStatus = proStatus
where productCode = proCode;
end // 
DELIMITER ; 

set sql_safe_updates = 0;
call updateProduct(1,'iphone11',10,'10','likenew',1);
set sql_safe_updates = 1;
-- xoa sp theo id

DELIMITER //
create procedure removeProduct(code int)
begin
	delete from products
    where productCode = code;
end //
DELIMITER ;
set sql_safe_updates = 0;
call removeProduct(1);
set sql_safe_updates = 1;
