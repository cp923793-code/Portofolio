
	drop table adventuresales_lower2019.dbo.ByChannel_Jkt_1_3_GT_IFS
select branch_id,branch_name,psub_id,year,sum(net_qty) as net_qty
 into adventuresales_lower2019.dbo.ByChannel_Jkt_1_3_GT_IFS
  from Complete_2years_Wk_Report_bySubChannel_All_Dtl_StockPoint
   where year=2024 and branch_name in ('jakarta 1','jakarta 3') and sub_channel in ('GT','IFS')
  group by branch_id,branch_name,psub_id,year
  -------
  drop table adventuresales_lower2019.dbo.AdHoc_Jkt_1_3_GT_IFS
  select branch_name,psub_id,year,sum([net ctn]) as net_qty
 into adventuresales_lower2019.dbo.AdHoc_Jkt_1_3_GT_IFS
  from  AdventureSales_lower2019.dbo.ADHOC_STTCUSTBUY_Y
  where year=2024 and branch_name in ('jakarta 1','jakarta 3') and sub_channel in ('GT','IFS')
  group by branch_name,psub_id,year

  select a.* ,b.net_qty  as netCtn from adventuresales_lower2019.dbo.ByChannel_Jkt_1_3_GT_IFS a
   left outer join adventuresales_lower2019.dbo.AdHoc_Jkt_1_3_GT_IFS b
   on a.branch_name=b.branch_name and a.psub_id=b.psub_id
   order by branch_name,psub_id

     select a.* ,b.net_qty  as netQty from adventuresales_lower2019.dbo.AdHoc_Jkt_1_3_GT_IFS a
   left outer join adventuresales_lower2019.dbo.ByChannel_Jkt_1_3_GT_IFS b
   on a.branch_name=b.branch_name and a.psub_id=b.psub_id
   order by branch_name,psub_id

   select sub_channel,count(distinct custd_id) as cb from
   (select sub_channel,a.custd_id,a.prod_id,sum(net_qty) as net_qty from sttwk1a_skm a
    left outer join product_svr55 b on a.prod_id=b.prod_id
	 left outer join customerdist_1910a c on a.custd_id=c.kode_iap
	 where udf6 like 'CE%' and a.branch_id='5200/5214' group by sub_channel,a.custd_id,a.prod_id) as a
	  where net_qty>0
	 group by sub_channel

	    select sub_channel,count(distinct custd_id) as cb from
   (select sub_channel,a.custd_id,b.prod_id,sum(net_qty) as net_qty from sttyr_skm a
    left outer join product_svr55 b on a.prod_id=b.prod_id
	 left outer join customerdist_1910a c on a.custd_id=c.kode_iap
	 where udf6 like 'CE%' and a.branch_id='5200/5214' group by sub_channel,a.custd_id,b.prod_id) as a
	  where net_qty>0
	 group by sub_channel

	 -- select product,count(*) as cnt from packtype group by product having count(*)>1
	 -- select *from packtype where brand='cap enaak'
	 -- select psub_id,count(*) as cnt from prodcat group by psub_id having count(*) >1
	 -- select sum(net_qty) from sttwk1a_skm

 
 select sub_channel,count (distinct custd_id) as CustBuy from 
 (
select f.region,b.branch_id,f.branch_name,b.year,channel,sub_channel,prodLine,prodgrp,a.brand,RetWhs,b.custd_id,sum(net_qty) as net_qty
   from sttyr_skm b  
 left outer join customerdist_1910a c on b.custd_id=c.kode_iap
  left outer join product_svr55 d on b.prod_id=d.prod_id --left outer join packtype g on d.product=g.product
 left outer join prodcat e on d.psub_id=e.psub_id
 left outer join branch f on b.branch_id=f.branch_id
   left outer join packtype a on a.product=d.product
-- where  (udf6 as psub_id like 'CE%' or udf6 as psub_id like 'IM-%' or udf6 as psub_id like 'kre%' or udf6 as psub_id like 'ts-%') and net_qty>0
 where year>=@year  
 group by f.region,b.branch_id,f.branch_name,year,channel,sub_channel,prodLine,prodgrp,a.brand,RetWhs,b.custd_id
 ) as a
  where net_qty>0
  and branch_id='5200/5214' and brand='Cap Enaak'
   group by sub_channel