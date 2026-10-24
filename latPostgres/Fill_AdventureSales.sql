CREATE TABLE PODetail(
	POID varchar(10) NOT NULL,
	ItemId varchar(20) NOT NULL,
	Qty numeric(10, 2) NULL,
	Price numeric(10, 2) NULL,
	Amount numeric(12, 2) NULL)

	select *from podetail

	CREATE TABLE sttwk(
	branch_id char(15) NOT NULL,
	sp_id varchar(50) NOT NULL,
	custd_id varchar(50) NOT NULL,
	prod_id char(20) NOT NULL,
	sls_id char(15) NOT NULL,
	year char(4) NOT NULL,
	month char(2) NOT NULL,
	week char(2) NOT NULL,
	net_qty numeric(12, 4) NULL,
	net_amt numeric(18, 4) NULL,
	grs_qty numeric(12, 4) NULL,
	grs_amt numeric(18, 4) NULL,
	rtn_qty numeric(10, 2) NULL,
	rtn_amt numeric(15, 2) NULL
)  
--35 seconds, sql server 11 seconds, 
--partition creates problem here
select year,week,sum(net_qty) from sttwk group by year,week order by year,week
--21 seconds
select year,week,sum(net_qty) from sttwk_old group by year,week order by year,week
select count(*) from sttwk  --4 seconds, sql server 10 seconds, mysql 54 seconds
	

CREATE TABLE product(
	prod_id char(20) primary key,
	prod_name char(45) NULL,
	text_id char(15) NULL,
	uom_text char(10) NULL,
	uom numeric(6, 0) NULL,
	brand_id char(10) NULL,
	psub_id char(10) NULL,
	konversi numeric(6, 4) NULL,
	konversi_kg numeric(6, 4) NULL,
	non_active char(1) NULL,
	na_date date NULL,
	active_date date NULL,
	product char(15) NULL,
	rank numeric(3, 0) NULL,
	brand char(35) NULL,
	sub_brand char(35) NULL,
	grup char(10) NULL,
	urut numeric(3, 0) NULL,
	selected char(1) NULL,
	udf1 char(50) NULL,
	udf2 char(30) NULL,
	udf3 char(30) NULL,
	udf4 char(30) NULL,
	udf5 char(20) NULL,
	udf6 char(20) NULL,
	udf7 char(20) NULL,
	ProdType varchar(10) NULL,
	ProdType1 varchar(10) NULL
	) 

 -- select *into sttwk_old from sttwk
      --test query 20 sec 24-25(merge-kids mth<=5. partition key)
--SET shared_buffers TO '8GB';	  
--ALTER SYSTEM SET shared_buffers TO '16GB';
--alter system SET work_mem TO '4GB';
select prodgrp,year,week,strata,SUM(a.net_qty) AS net_qty,SUM(a.net_amt) AS net_amt
from (
select prodgrp,b.custd_id,  b.net_qty, b.year,b.week, b.net_amt,
                      CASE WHEN net_qty >= 1000 THEN '8) =>1000 ctn' WHEN net_qty >= 500 and net_qty <1000 THEN '7) 500 ctn - 999 ctn' WHEN net_qty >= 200 and net_qty<500 THEN '6) 200 ctn - 499 ctn' 
					WHEN net_qty >= 51 AND net_qty < 200 THEN '5) 51 ctn - 199 ctn' WHEN net_qty >= 11 AND 
                      net_qty < 51 THEN '4) 11 ctn - 50 ctn'  WHEN net_qty >= 6 AND net_qty < 11 THEN '3) 6 ctn - 10 ctn'
					WHEN net_qty >= 1 AND net_qty <= 2 THEN '2) 1 ctn - 2 ctn' WHEN net_qty > 2 AND net_qty < 6 THEN '3a) 3 ctn - 5 ctn'
					WHEN net_qty < 1  then '1) < 1 ctn' END AS Strata
 from
(SELECT   udf1 as prodgrp,year, week,custd_id,sum(net_qty) as net_qty,sum(net_amt) as net_amt
FROM            sttwk  left outer join product on sttwk.prod_id=product.prod_id
 where udf1 in ('KIDS','SCI','TS-500','IM-SCH','IM-CAN','CE-SCH','CE-370','UHT180') 
  and ((year_month between '202401' and '202401')
  or (year_month between '202501' and '202501')) and week<'5'
  group by udf1,year,week,custd_id) as b ) as a
   group by prodgrp,year,week,strata order by prodgrp,year,week,strata

      --test query 50 sec 24-25(merge-kids mth<=5. no partition)

select prodgrp,year,week,strata,SUM(a.net_qty) AS net_qty,SUM(a.net_amt) AS net_amt
from (
select prodgrp,b.custd_id,  b.net_qty, b.year,b.week, b.net_amt,
                      CASE WHEN net_qty >= 1000 THEN '8) =>1000 ctn' WHEN net_qty >= 500 and net_qty <1000 THEN '7) 500 ctn - 999 ctn' WHEN net_qty >= 200 and net_qty<500 THEN '6) 200 ctn - 499 ctn' 
					WHEN net_qty >= 51 AND net_qty < 200 THEN '5) 51 ctn - 199 ctn' WHEN net_qty >= 11 AND 
                      net_qty < 51 THEN '4) 11 ctn - 50 ctn'  WHEN net_qty >= 6 AND net_qty < 11 THEN '3) 6 ctn - 10 ctn'
					WHEN net_qty >= 1 AND net_qty <= 2 THEN '2) 1 ctn - 2 ctn' WHEN net_qty > 2 AND net_qty < 6 THEN '3a) 3 ctn - 5 ctn'
					WHEN net_qty < 1  then '1) < 1 ctn' END AS Strata
 from
(SELECT   udf1 as prodgrp,year, week,custd_id,sum(net_qty) as net_qty,sum(net_amt) as net_amt
FROM            sttwk_old as sttwk  left outer join product on sttwk.prod_id=product.prod_id
 where udf1 in ('KIDS','SCI','TS-500','IM-SCH','IM-CAN','CE-SCH','CE-370','UHT180') 
  and ((year_month between '202401' and '202401')
  or (year_month between '202501' and '202501')) and week<'5'
  group by udf1,year,week,custd_id) as b ) as a
   group by prodgrp,year,week,strata order by prodgrp,year,week,strata   
