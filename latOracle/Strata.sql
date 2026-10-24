select yr,wk,strata,SUM(a.net_qty) AS net_qty,SUM(a.net_amt) AS net_amt
from (
select b.custd_id,  b.net_qty, b.yr,b.wk, b.net_amt,
                      CASE WHEN net_qty >= 1000 THEN '8) =>1000 ctn' WHEN net_qty >= 500 and net_qty <1000 THEN '7) 500 ctn - 999 ctn' WHEN net_qty >= 200 and net_qty<500 THEN '6) 200 ctn - 499 ctn' 
					WHEN net_qty >= 51 AND net_qty < 200 THEN '5) 51 ctn - 199 ctn' WHEN net_qty >= 11 AND 
                      net_qty < 51 THEN '4) 11 ctn - 50 ctn'  WHEN net_qty >= 6 AND net_qty < 11 THEN '3) 6 ctn - 10 ctn'
					WHEN net_qty >= 1 AND net_qty <= 2 THEN '2) 1 ctn - 2 ctn' WHEN net_qty > 2 AND net_qty < 6 THEN '3a) 3 ctn - 5 ctn'
					WHEN net_qty < 1  then '1) < 1 ctn' END AS Strata
 from
(SELECT   yr, wk,custd_id,sum(net_qty) as net_qty,sum(net_amt) as net_amt
FROM            sttwk  group by yr,wk,custd_id) b ) a
   group by yr,wk,strata order by yr,wk,strata