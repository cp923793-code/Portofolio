CREATE TABLE STTWK (
    BRANCH_ID VARCHAR2(15) NOT NULL,
    SP_ID VARCHAR2(50) NOT NULL,
    CUSTD_ID VARCHAR2(50) NOT NULL,
    PROD_ID VARCHAR2(20) NOT NULL,
    SLS_ID VARCHAR2(15) NOT NULL,
    YR varchar(4) NOT NULL, -- Renamed 'YEAR' as it is an Oracle reserved keyword
    MTH varchar(2) NOT NULL, -- Renamed 'MONTH' as it is an Oracle reserved keyword
    WK varchar(2) NOT NULL,  -- Renamed 'WEEK' as it is an Oracle reserved keyword
    NET_QTY NUMBER(12, 4),
    NET_AMT NUMBER(18, 4),
    GRS_QTY NUMBER(12, 4),
    GRS_AMT NUMBER(18, 4),
    RTN_QTY NUMBER(10, 2),
    RTN_AMT NUMBER(15, 2)
);

USE sttwk_2025a_par
GO

/****** Object:  Table dbo.customerdist_orc    Script Date: 26/11/2025 21:05:31 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO
select * from customerdist_orc
CREATE TABLE customerdist_orc(
	branch_id varchar(15) NOT NULL,
	sp_id varchar(15) NOT NULL,
	gtype_id varchar(5) NULL,
	type_id varchar(5) NULL,
	gcust_id varchar(5) NULL,
	custd_id varchar(20) NULL,
	custd_name varchar(50) NULL,
	custdid varchar(10) NULL,
	channel varchar(5) NULL,
	customer_group varchar(30) NULL,
	address_1 varchar(50) NULL,
	sub_channel varchar(10) NULL,
	type_outlet varchar(30) NULL,
	crm varchar(1) NULL,
	gsm varchar(1) NULL,
	chiller varchar(1) NULL,
	hanger varchar(1) NULL,
	kode_iap varchar(42) NOT NULL,
	kelurahan varchar(50) NULL,
	gtype_name varchar(50) NULL,
	NewOutlet varchar(1) NULL,
	RetWhs varchar(30) NULL,
	type_outlet1 varchar(30) NULL,
	Mkt varchar(1) NULL
);
drop table product
CREATE TABLE product(
	prod_id varchar(20) primary key,
	prod_name varchar(45) NULL,
	text_id varchar(15) NULL,
	uom_text varchar(10) NULL,
	uom numeric(6, 0) NULL,
	brand_id varchar(10) NULL,
	psub_id varchar(10) NULL,
	konversi numeric(6, 4) NULL,
	konversi_kg numeric(6, 4) NULL,
	non_active varchar(1) NULL,
	na_date date NULL,
	active_date date NULL,
	product varchar(15) NULL,
	rank numeric(3, 0) NULL,
	brand varchar(35) NULL,
	sub_brand varchar(35) NULL,
	grup varchar(10) NULL,
	urut numeric(3, 0) NULL,
	selected varchar(1) NULL,
	udf1 varchar(50) NULL,
	udf2 varchar(30) NULL,
	udf3 varchar(30) NULL,
	udf4 varchar(30) NULL,
	udf5 varchar(20) NULL,
	udf6 varchar(20) NULL,
	udf7 varchar(20) NULL,
	ProdType varchar(10) NULL,
	ProdType1 varchar(10) NULL
    );
 
USE Sales
GO

/****** Object:  Table dbo.Branch    Script Date: 02/12/2025 03:35:55 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE Branch(
	branch_id char(15) NOT NULL,
	branch_name char(25) NULL,
	so_id char(5) NULL,
	dist_id char(5) NULL,
	region char(10) NOT NULL,
	area char(25) NULL,
	location_id char(5) NULL,
	branch_name_dist char(25) NULL,
	telp char(20) NULL,
	fax char(20) NULL,
	address_1 char(35) NULL,
	address_2 char(35) NULL,
	city char(30) NULL,
	postcode char(6) NULL,
	factory char(15) NULL,
	line_no char(1) NULL,
	own_pic char(25) NULL,
	bm char(25) NULL,
	sm char(25) NULL,
	lm char(25) NULL
);



--select *from sttwk
--select count(*) from customerdist_orc
--select *from product
--drop table sttwk
--16 seconds
--drop table sttwk
 select yr,wk,sum(net_qty) as net_qty from sttwk group by yr,wk order by yr,wk
 select * from sttwk where year=2023
 select *from product where "prod_id"='000000000000106853'
ALTER TABLE sttwk ENABLE ROW MOVEMENT; 
ALTER TABLE sttwk SHRINK SPACE CASCADE;
CREATE TABLE sttwk_2022a 
AS 
drop  table sttwk;
drop table discount_b
 
 --PURGE TABLE sttwk_2022a;
 
 SELECT 
    segment_name AS "Table Name",
    segment_type AS "Object Type",
    ROUND(SUM(bytes) / 1024 / 1024 / 1024, 9) AS "Size (GB)"
FROM 
    dba_segments
WHERE 
  owner = 'SYSTEM' and bytes>100000 and  segment_type = 'TABLE'
GROUP BY 
    segment_name, segment_type 
order by segment_name  ;


-- cek physical files
SELECT file_name AS "Physical File Location", 
       tablespace_name AS "Tablespace Name"
FROM dba_data_files
ORDER BY tablespace_name;

