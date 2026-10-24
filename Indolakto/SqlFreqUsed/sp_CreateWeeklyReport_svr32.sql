USE [AdventureSales]
GO
/****** Object:  StoredProcedure [dbo].[sp_CreateWeeklyReport]    Script Date: 09/18/2024 14:27:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

alter PROCEDURE [dbo].[sp_CreateWeeklyReport]  AS  -- 37 minutes

declare @week as smallint;
set @week=(select cwk from begmonth);
-- select distinct year,week from Wk_Report_bySubChannel_All order by year,week
drop table adventuresales_lower2019.dbo.Wk_Report_bySubChannel_All -- 15 minutes
--select a.*,prodgrp,prodline into Wk_Report_bySubChannel_All from 
--(
--q1  please check the weeks for the last week
--select distinct year,week from sttwk1a order by year,week
--insert into Wk_Report_bySubChannel_All
select f.region,b.branch_id,f.branch_name,b.year,b.month,b.week,sub_channel,prodLine,prodgrp,d.psub_id,sum(net_qty) as net_qty,sum(net_amt) as net_amt
   into adventuresales_lower2019.dbo.Wk_Report_bySubChannel_All
    from sttwk1a b  
 left outer join customerdist_1910a c on b.custd_id=c.kode_iap
 left outer join product_svr55 d on b.prod_id=d.prod_id
 left outer join prodcat e on d.psub_id=e.psub_id
 left outer join branch f on b.branch_id=f.branch_id
  where week<=@week
 group by f.region,b.branch_id,f.branch_name,year,month,week,sub_channel,prodLine,prodgrp,d.psub_id --) as a
--q2  please check the weeks for the last week
/*
insert into Wk_Report_bySubChannel_All
select f.region,b.branch_id,f.branch_name,b.year,b.month,b.week,sub_channel,prodLine,prodgrp,d.psub_id,sum(net_qty) as net_qty,sum(net_amt) as net_amt
   from sttwk1a2 b  
 left outer join customerdist_1910a c on b.custd_id=c.kode_iap
 left outer join product d on b.prod_id=d.prod_id
 left outer join prodcat e on d.psub_id=e.psub_id
 left outer join branch f on b.branch_id=f.branch_id
 group by f.region,b.branch_id,f.branch_name,year,month,week,sub_channel,prodLine,prodgrp,d.psub_id --) as a
--q3  please check the weeks for the last week
insert into Wk_Report_bySubChannel_All
select f.region,b.branch_id,f.branch_name,b.year,b.month,b.week,sub_channel,prodLine,prodgrp,d.psub_id,sum(net_qty) as net_qty,sum(net_amt) as net_amt
   from sttwk1a3 b  
 left outer join customerdist_1910a c on b.custd_id=c.kode_iap
 left outer join product d on b.prod_id=d.prod_id
 left outer join prodcat e on d.psub_id=e.psub_id
 left outer join branch f on b.branch_id=f.branch_id
 group by f.region,b.branch_id,f.branch_name,year,month,week,sub_channel,prodLine,prodgrp,d.psub_id --) as a
--q4 -- please check the weeks for the last week
insert into Wk_Report_bySubChannel_All
select f.region,b.branch_id,f.branch_name,b.year,b.month,b.week,sub_channel,prodLine,prodgrp,d.psub_id,sum(net_qty) as net_qty,sum(net_amt) as net_amt
   from sttwk1a4 b  
 left outer join customerdist_1910a c on b.custd_id=c.kode_iap
 left outer join product d on b.prod_id=d.prod_id
 left outer join prodcat e on d.psub_id=e.psub_id
 left outer join branch f on b.branch_id=f.branch_id
 where week<=@week
 group by f.region,b.branch_id,f.branch_name,year,month,week,sub_channel,prodLine,prodgrp,d.psub_id --) as a
*/
--summary All
delete from adventuresales_lower2019.dbo.Wk_Report_bySubChannel_All where sub_channel='ALL'
insert into adventuresales_lower2019.dbo.Wk_Report_bySubChannel_All
select region,branch_id,branch_name,year,month,week,'ALL' as sub_channel,prodLine,prodgrp,psub_id,sum(net_qty) as net_qty,sum(net_amt) as net_amt
 from adventuresales_lower2019.dbo.Wk_Report_bySubChannel_All
 group by region,branch_id,branch_name,year,month,week,prodLine,ProdGrp,psub_id

---- special product creation
drop table adventuresales_lower2019.dbo.Wk_Report_bySubChannel_Spc -- 15 minutes
--q1
--insert into Wk_Report_bySubChannel_Spc
select f.region,b.branch_id,f.branch_name,b.year,b.month,b.week,sub_channel,text_id,psub_id,sum(net_qty) as net_qty,sum(net_amt) as net_amt
   into adventuresales_lower2019.dbo.Wk_Report_bySubChannel_Spc
   from sttwk1a b  
 left outer join customerdist_1910a c on b.custd_id=c.kode_iap
 inner join product_spc d on b.prod_id=d.prod_id
 --left outer join prodcat e on d.psub_id=e.psub_id
 left outer join branch f on b.branch_id=f.branch_id
 where week<=@week
 group by f.region,b.branch_id,f.branch_name,year,month,week,sub_channel,text_id,d.psub_id --) as a
 --left outer join prodcat e on a.psub_id=e.psub_id
--q2
/*
insert into Wk_Report_bySubChannel_Spc
select f.region,b.branch_id,f.branch_name,b.year,b.month,b.week,sub_channel,text_id,psub_id,sum(net_qty) as net_qty,sum(net_amt) as net_amt
   from sttwk1a2 b  
 left outer join customerdist_1910a c on b.custd_id=c.kode_iap
 inner join product_spc d on b.prod_id=d.prod_id
 --left outer join prodcat e on d.psub_id=e.psub_id
 left outer join branch f on b.branch_id=f.branch_id
 group by f.region,b.branch_id,f.branch_name,year,month,week,sub_channel,text_id,d.psub_id --) as a
 --left outer join prodcat e on a.psub_id=e.psub_id
--q3
insert into Wk_Report_bySubChannel_Spc
select f.region,b.branch_id,f.branch_name,b.year,b.month,b.week,sub_channel,text_id,psub_id,sum(net_qty) as net_qty,sum(net_amt) as net_amt
   from sttwk1a3 b  
 left outer join customerdist_1910a c on b.custd_id=c.kode_iap
 inner join product_spc d on b.prod_id=d.prod_id
 --left outer join prodcat e on d.psub_id=e.psub_id
 left outer join branch f on b.branch_id=f.branch_id
 group by f.region,b.branch_id,f.branch_name,year,month,week,sub_channel,text_id,d.psub_id --) as a
 --left outer join prodcat e on a.psub_id=e.psub_id
--q4
insert into Wk_Report_bySubChannel_Spc
select f.region,b.branch_id,f.branch_name,b.year,b.month,b.week,sub_channel,text_id,psub_id,sum(net_qty) as net_qty,sum(net_amt) as net_amt
   from sttwk1a4 b   
 left outer join customerdist_1910a c on b.custd_id=c.kode_iap
 inner join product_spc d on b.prod_id=d.prod_id
 --left outer join prodcat e on d.psub_id=e.psub_id
 left outer join branch f on b.branch_id=f.branch_id
 where week<=@week
 group by f.region,b.branch_id,f.branch_name,year,month,week,sub_channel,text_id,d.psub_id --) as a
 --left outer join prodcat e on a.psub_id=e.psub_id
*/
delete from adventuresales_lower2019.dbo.Wk_Report_bySubChannel_Spc where sub_channel='ALL'
insert into adventuresales_lower2019.dbo.Wk_Report_bySubChannel_spc
select region,branch_id,branch_name,year,month,week,'ALL' as sub_channel,text_id,psub_id,sum(net_qty) as net_qty,sum(net_amt) as net_amt
 from adventuresales_lower2019.dbo.Wk_Report_bySubChannel_spc
 group by region,branch_id,branch_name,year,month,week,text_id,psub_id
  

 --exec sp_CreateWeeklyReport  -- NoDrop Please dont
 --exec sp_shrinkSalesLog
---- custbuy
---- special product creation
 --exec sp_shrinkalllog

--select * into sttwk_tmp.dbo.sttwktmp04
-- from sttwk_tmp.dbo.sttwktmp
--select distinct year,week from sttwk1a order by year,week

