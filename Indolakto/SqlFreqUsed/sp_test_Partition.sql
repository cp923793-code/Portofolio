 --use sttwk_2025a_par
alter PROCEDURE [dbo].[sp_test_Partition]
  as
  begin
/*
select *from sales.dbo.product where udf1='KIDS'
select distinct week from sttwk
select distinct week from sttwk_2022
*/
--test query 11 seconds 22-25(merge), no limit cpu and ram
--oracle 21c express 16 seconds, 2 cpu core and 2gb ram limit
--use sttwk_2025a_par
select year,week,sum(net_qty) from sttwk group by year,week order by year,week
-- no partition, will be a little faster than above (has partition) -- 9 seconds
select year,week,sum(net_qty) from sttwk where year=2021 group by year,week order by year,week

--test query 22 seconds 22-25(merge)
select year,week,strata,SUM(a.net_qty) AS net_qty,SUM(a.net_amt) AS net_amt
from (
select b.custd_id,  b.net_qty, b.year,b.week, b.net_amt,
                      CASE WHEN net_qty >= 1000 THEN '8) =>1000 ctn' WHEN net_qty >= 500 and net_qty <1000 THEN '7) 500 ctn - 999 ctn' WHEN net_qty >= 200 and net_qty<500 THEN '6) 200 ctn - 499 ctn' 
					WHEN net_qty >= 51 AND net_qty < 200 THEN '5) 51 ctn - 199 ctn' WHEN net_qty >= 11 AND 
                      net_qty < 51 THEN '4) 11 ctn - 50 ctn'  WHEN net_qty >= 6 AND net_qty < 11 THEN '3) 6 ctn - 10 ctn'
					WHEN net_qty >= 1 AND net_qty <= 2 THEN '2) 1 ctn - 2 ctn' WHEN net_qty > 2 AND net_qty < 6 THEN '3a) 3 ctn - 5 ctn'
					WHEN net_qty < 1  then '1) < 1 ctn' END AS Strata
 from
(SELECT   year, week,custd_id,sum(net_qty) as net_qty,sum(net_amt) as net_amt
FROM            sttwk  group by year,week,custd_id) as b ) as a
   group by year,week,strata order by year,week,strata

   --test query 15 seconds 22-25(merge-kids)
select year,week,strata,SUM(a.net_qty) AS net_qty,SUM(a.net_amt) AS net_amt
from (
select b.custd_id,  b.net_qty, b.year,b.week, b.net_amt,
                      CASE WHEN net_qty >= 1000 THEN '8) =>1000 ctn' WHEN net_qty >= 500 and net_qty <1000 THEN '7) 500 ctn - 999 ctn' WHEN net_qty >= 200 and net_qty<500 THEN '6) 200 ctn - 499 ctn' 
					WHEN net_qty >= 51 AND net_qty < 200 THEN '5) 51 ctn - 199 ctn' WHEN net_qty >= 11 AND 
                      net_qty < 51 THEN '4) 11 ctn - 50 ctn'  WHEN net_qty >= 6 AND net_qty < 11 THEN '3) 6 ctn - 10 ctn'
					WHEN net_qty >= 1 AND net_qty <= 2 THEN '2) 1 ctn - 2 ctn' WHEN net_qty > 2 AND net_qty < 6 THEN '3a) 3 ctn - 5 ctn'
					WHEN net_qty < 1  then '1) < 1 ctn' END AS Strata
 from
(SELECT   year, week,custd_id,sum(net_qty) as net_qty,sum(net_amt) as net_amt
FROM            sttwk  left outer join sales.dbo.product on sttwk.prod_id=product.prod_id
 where udf1='KIDS'
  group by year,week,custd_id) as b ) as a
   group by year,week,strata order by year,week,strata

      --test query 1 seconds 24-25(merge-kids mth<=5. partition key)
select year,week,strata,SUM(a.net_qty) AS net_qty,SUM(a.net_amt) AS net_amt
from (
select b.custd_id,  b.net_qty, b.year,b.week, b.net_amt,
                      CASE WHEN net_qty >= 1000 THEN '8) =>1000 ctn' WHEN net_qty >= 500 and net_qty <1000 THEN '7) 500 ctn - 999 ctn' WHEN net_qty >= 200 and net_qty<500 THEN '6) 200 ctn - 499 ctn' 
					WHEN net_qty >= 51 AND net_qty < 200 THEN '5) 51 ctn - 199 ctn' WHEN net_qty >= 11 AND 
                      net_qty < 51 THEN '4) 11 ctn - 50 ctn'  WHEN net_qty >= 6 AND net_qty < 11 THEN '3) 6 ctn - 10 ctn'
					WHEN net_qty >= 1 AND net_qty <= 2 THEN '2) 1 ctn - 2 ctn' WHEN net_qty > 2 AND net_qty < 6 THEN '3a) 3 ctn - 5 ctn'
					WHEN net_qty < 1  then '1) < 1 ctn' END AS Strata
 from
(SELECT   year, week,custd_id,sum(net_qty) as net_qty,sum(net_amt) as net_amt
FROM            sttwk  left outer join sales.dbo.product on sttwk.prod_id=product.prod_id
 where udf1='KIDS' and ((yearmonth between '202401' and '202405')
  or (yearmonth between '202501' and '202505')) and week<22
  group by year,week,custd_id) as b ) as a
   group by year,week,strata order by year,week,strata


         --test query 7 seconds 24-25(merge-kids mth<=5, view)
select year,week,strata,SUM(a.net_qty) AS net_qty,SUM(a.net_amt) AS net_amt
from (
select b.custd_id,  b.net_qty, b.year,b.week, b.net_amt,
                      CASE WHEN net_qty >= 1000 THEN '8) =>1000 ctn' WHEN net_qty >= 500 and net_qty <1000 THEN '7) 500 ctn - 999 ctn' WHEN net_qty >= 200 and net_qty<500 THEN '6) 200 ctn - 499 ctn' 
					WHEN net_qty >= 51 AND net_qty < 200 THEN '5) 51 ctn - 199 ctn' WHEN net_qty >= 11 AND 
                      net_qty < 51 THEN '4) 11 ctn - 50 ctn'  WHEN net_qty >= 6 AND net_qty < 11 THEN '3) 6 ctn - 10 ctn'
					WHEN net_qty >= 1 AND net_qty <= 2 THEN '2) 1 ctn - 2 ctn' WHEN net_qty > 2 AND net_qty < 6 THEN '3a) 3 ctn - 5 ctn'
					WHEN net_qty < 1  then '1) < 1 ctn' END AS Strata
 from
(SELECT   year, week,custd_id,sum(net_qty) as net_qty,sum(net_amt) as net_amt
FROM            sttwk  left outer join sales.dbo.product on sttwk.prod_id=product.prod_id
 where udf1='KIDS' and year>=2024 and month<=5 and week<22
  group by year,week,custd_id) as b ) as a
   group by year,week,strata order by year,week,strata

------ lower records

      --test query 930 ms 24-25(merge-kids mth<=5. partition key)
--use sttwk_2025a_par
set statistics time on;
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
FROM            sttwk  left outer join sales.dbo.product on sttwk.prod_id=product.prod_id
 where udf1 in ('KIDS','SCI','TS-500','IM-SCH','IM-CAN','CE-SCH','CE-370','UHT180') 
  and ((yearmonth between '202401' and '202401')
  or (yearmonth between '202501' and '202501')) and week<5
  group by udf1,year,week,custd_id) as b ) as a
   group by prodgrp,year,week,strata order by prodgrp,year,week,strata

set statistics time off;

         --test query 7 seconds 24-25(merge-kids mth<=5, view)
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
FROM            sttwk  left outer join sales.dbo.product on sttwk.prod_id=product.prod_id
 where udf1 in ('KIDS','SCI','TS-500','IM-SCH','IM-CAN','CE-SCH','CE-370','UHT180') 
  and year>=2024 and week<5
  group by udf1,year,week,custd_id) as b ) as a
   group by prodgrp,year,week,strata order by prodgrp,year,week,strata

end
   	  

