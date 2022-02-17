create database Ecommerce;
use Ecommerce;
create table Supplier(SUPP_ID int primary key,SUPP_NAME varchar(30),SUPP_CITY varchar (20),SUPP_PHONE varchar(50) );
create table Customer(CUS_ID int primary key,CUS_NAME varchar(30),CUS_PHONE varchar(50), CUS_CITY varchar (20), CUS_GENDER char);
create table Category(CAT_ID int primary key,CAT_NAME varchar (50));
create table Product(PRO_ID int primary key,PRO_NAME varchar(50) null default null,PRO_DESC varchar (60) null default null,CAT_ID int not null, foreign key(CAT_ID) references category(CAT_ID));
create table ProductDetails(PROD_ID int primary key ,PRO_ID int not null,SUPP_ID int not null ,PROD_PRICE int not null, foreign key(PRO_ID) references Product(PRO_ID), foreign key(SUPP_ID) references Supplier(SUPP_ID));
create table Orders(ORD_ID int primary key,ORD_AMOUNT int not null,ORD_DATE date,CUS_ID int not null,PROD_ID int not null, foreign key(PROD_ID) references ProductDetails(PROD_ID), foreign key(CUS_ID) references Customer(CUS_ID));
create table Rating(RAT_ID int primary key,CUS_ID int not null,SUPP_ID int not null,RAT_RATSTARS int not null,foreign key(CUS_ID) references Customer(CUS_ID), foreign key(SUPP_ID) references Supplier(SUPP_ID));
insert into Supplier values (1,'Rajesh Retails','Delhi',1234567890);
insert into Supplier values (2,'Appario Ltd.','Mumbai',2589631470);
insert into Supplier values (3,'Knome products','Banglore',9785462315);
insert into Supplier values (4,'Bansal Retails','Kochi',8975463285);
insert into Supplier values (5,'Mittal Ltd.','Lucknow',7898456532);
insert into Customer values(1,'AAKASH',9999999999,'DELHI','M');
insert into Customer values(2,'AMAN',9785463215,'NOIDA','M');
insert into Customer values(3,'NEHA',9999999999,'MUMBAI','F');
insert into Customer values(4,'MEGHA',9994562399,'KOLKATA','F');
insert into Customer values(5,'PULKIT',7895999999,'LUCKNOW','M');
insert into Category values(1,'BOOKS');
insert into Category values(2,'GAMES');
insert into Category values(3,'GROCERIES');
insert into Category values(4,'ELECTRONICS');
insert into Category values(5,'CLOTHES');
insert into Product values(1,'GTA V','DFJDJFDJFDJFDJFJF',2);
insert into Product values(2,'TSHIRT','DFDFJDFJDKFD',5);
insert into Product values(3,'ROG LAPTOP','DFNTTNTNTERND',4);
insert into Product values(4,'OATS','REURENTBTOTH',3);
insert into Product values(5,'HARRY POTTER','NBEMCTHTJTH',1);
insert into ProductDetails values(1,1,2,1500);
insert into ProductDetails values(2,3,5,30000);
insert into ProductDetails values(3,5,1,3000);
insert into ProductDetails values(4,2,3,2500);
insert into ProductDetails values(5,4,1,1000);
insert into Orders values(20,1500,'2021-10-12',3,5);
insert into Orders values(25,30500,'2021-09-16',5,2);
insert into Orders values(26,2000,'2021-10-05',1,1);
insert into Orders values(30,3500,'2021-08-16',4,3);
insert into Orders values(50,2000,'2021-10-06',2,1);
insert into Rating values(1,2,2,4);
insert into Rating values(2,3,4,3);
insert into Rating values(3,5,1,5);
insert into Rating values(4,1,3,2);
insert into Rating values(5,4,5,4);
Select Customer.CUS_GENDER, count(Customer.CUS_GENDER) as count from Customer Customer inner join Orders on Customer.CUS_ID = Orders.CUS_ID where Orders.ORD_AMOUNT>=3000 group by Customer.CUS_GENDER;
Select Orders.*, Product.PRO_NAME from Orders, ProductDetails, Product where Orders.CUS_ID=2 and Orders.PROD_ID= ProductDetails.PROD_ID and ProductDetails.PROD_ID= Product.PRO_ID;
Select Supplier.* from Supplier, ProductDetails where Supplier.SUPP_ID in (select ProductDetails.SUPP_ID from ProductDetails group by ProductDetails.SUPP_ID having count(ProductDetails.SUPP_ID)>1) group by Supplier.SUPP_ID;
Select Category.* from Orders inner join ProductDetails on Orders.PROD_ID = ProductDetails.PROD_ID inner join Product on Product.PRO_ID = ProductDetails.PRO_ID inner join Category on Category.CAT_ID = Product.CAT_ID order by Orders.ORD_AMOUNT limit 1;
Select Product.PRO_ID, Product.PRO_NAME from Orders inner join ProductDetails on Orders.PROD_ID = ProductDetails.PROD_ID inner join Product on Product.PRO_ID = ProductDetails.PRO_ID where Orders.ORD_DATE > '2021-10-05';
Select Customer.CUS_NAME, Customer.CUS_GENDER from Customer Customer where Customer.CUS_NAME like 'A%' or Customer.CUS_NAME like '%A';
Select Supplier.SUPP_ID, Supplier.SUPP_NAME, Rating.RAT_RATSTARS, case when Rating.RAT_RATSTARS > 4 then 'Genuine Suppliers' when Rating.RAT_RATSTARS > 2 then 'Average Suppliers' else 'Supplier wont be considered' end as verdict from Rating inner join Supplier on Supplier.SUPP_ID= Rating.SUPP_ID;
call new_procedure()