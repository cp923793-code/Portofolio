drop table customers
CREATE TABLE Customers (
    CustomerID VARCHAR(20) NOT NULL PRIMARY KEY,
    FirstName VARCHAR(50),
    LastName VARCHAR(50)
);
use oltp
-- drop table podetail
select *from vendors
CREATE TABLE Vendors (
    VendorID VARCHAR(20) NOT NULL PRIMARY KEY,
    VendorName VARCHAR(50)
);
select *from itemmaster
drop table Item_Master
CREATE TABLE ItemMaster (
    ItemID VARCHAR(20) NOT NULL PRIMARY KEY,
    ItemName VARCHAR(50),
    UnitPrice numeric(10,2),
    Qty numeric(10,2)
);
insert into poheader values('P001','22222','2025-11-04','0','OPN')
use oltp
select *from poheader       
CREATE TABLE POHeader ( 
    POID VARCHAR(10) NOT NULL PRIMARY KEY,
    VendorId varchar(20),
    OrderDate date,
    Amount numeric(12,2),
    Sts varchar(3)
);
insert into podetail select 'P002' as poid,itemid,qty,price,amount from podetail where poid='P001'
use oltp
SELECT *FROM PODETAIL
-- delete from podetail where poid='P001' and itemid='A555C'
create TABLE PODetail (
    POID VARCHAR(10) NOT NULL,
    ItemId varchar(20) not null,
    Qty numeric(10,2) not null,
    Price numeric(10,2) not null,
    Amount numeric(12,2) not null,
    primary key (poid,itemid)
);
ALTER TABLE dbo.PODetail
ALTER COLUMN price DECIMAL(10, 2) NOT NULL; 
 

use oltp
select *from customers

use dwh
--drop table sales
--delete from sales
update sales set distcode='150001191'
--truncate table sales --where distcode='150030255'
select *from sales where isnull(itemid,'')='' order by distcode
CREATE TABLE sales ( 
    DistCode VARCHAR(20) NOT NULL,
    InvDate date,
    InvNo varchar(50),
    CustId varchar(20),
    ItemId varchar(50),
    Qty numeric(10,0)
);
--drop table dim_distributor
select * from dim_distributor
update dim_distributor set dtcColHdr='KODE PRODUK',prodNameColumnIndex=1 
 where distcode='150030255'
CREATE TABLE Dim_Distributor ( 
    DistCode VARCHAR(20),
    DistName varchar(50),
    FileLoc varchar(50),
    FlNm varchar(20),
    prodNameColumnIndex smallint,
    custIdColumnIndex smallint,
    maxBlankRows smallint,
    DtcColHdr varchar(50),
    InvNoColumnIndex smallint,
    TrDateColumnIndex smallint,
    QtyColumnIndex smallint,
    primary key (distcode)
);
 

--delete from dim_distributor
select *from dim_distributor
insert into Dim_Distributor select '150001191' as DistCode,'Karya_Sukses_Prima' as DistName,
 'c:\Etl_Danone\KaryaSuksesPrima\' as FileLoc,  'sales.xls' as FlNm,'2' as prodNameColumnIndex,'10' as custIdColumnIndex,
 '29' as maxBlankRows,'NMBR' as DtcColHdr,'1' as InvNoColumnIndex,'0' as TrDateColumnIndex,
 '3' as QtyColumnIndex  

insert into Dim_Distributor select '150030255' as DistCode,'Fajar_Lestari' as DistName,
 'c:\Etl_Danone\FajarLestari\' as FileLoc,  'sales.xls' as FlNm,'1' as prodNameColumnIndex,'2' as custIdColumnIndex,
 '29' as maxBlankRows,'KODE PRODUK' as DtcColHdr,'3' as InvNoColumnIndex,'0' as TrDateColumnIndex,
 '6' as QtyColumnIndex

 -- drop table itemconversion
 create TABLE ItemConversion (
    DistCode VARCHAR(20) NOT NULL,
    ItemIdDst varchar(50),
    ItemDistDsc varchar (70) NOT Null,
    ItemId varchar(20)
    primary key (DistCode,itemDistDsc)
);
select *from ItemConversion where itemdistdsc like '%MILKUAT APPLE      60 X 70 ML%'

insert into ItemConversion
select distcode,itemiddst,'MILKUAT APPLE       60 X 70 ML' as itemdistdsc,itemid
 from ItemConversion 
where itemdistdsc like '%MILKUAT APPLE      60 X 70 ML%'

select *into itemconversion_bak from itemconversion
insert into itemconversion select *from itemconversion_bak

--delete from itemconversion where distcode='150030255'

 