USE [adventuresales]
GO
/****** Object:  StoredProcedure [dbo].[sp_CreateWeeklyReport_NoDrop]    Script Date: 11/08/2024 08:43:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create PROCEDURE [dbo].[sp_CreateWeeklyReport_NoDrop]  AS

declare @week as smallint;
set @week=(select cwk from begmonth);
declare @year as smallint;
set @year=(select yr_num from begmonth);
--select year,week,sum(net_qty) from sttwktmp group by year,week
--select year,week,sum(net_qty) from Wk_Report_bySubChannel_All where sub_channel='ALL' group by year,week order by year,week
delete from Wk_Report_bySubChannel_All where  week>=@week -- 15 minutes
--select a.*,prodgrp,prodline into Wk_Report_bySubChannel_All from 
--(
--q1  please check the weeks for the last week
insert into Wk_Report_bySubChannel_All
select f.region,b.branch_id,f.branch_name,b.year,b.month,b.week,sub_channel,prodLine,prodgrp,d.psub_id,sum(net_qty) as net_qty,sum(net_amt) as net_amt
   from sttwktmp b  
 left outer join customerdist_1910a c on b.custd_id=c.kode_iap
 left outer join product d on b.prod_id=d.prod_id
 left outer join prodcat e on d.psub_id=e.psub_id
 left outer join branch f on b.branch_id=f.branch_id
  where  week>=@week
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
 where  week>=@week
 group by f.region,b.branch_id,f.branch_name,year,month,week,sub_channel,prodLine,prodgrp,d.psub_id --) as a
*/
--summary All
delete from Wk_Report_bySubChannel_All where sub_channel='ALL'
insert into Wk_Report_bySubChannel_All
select region,branch_id,branch_name,year,month,week,'ALL' as sub_channel,prodLine,prodgrp,psub_id,sum(net_qty) as net_qty,sum(net_amt) as net_amt
 from Wk_Report_bySubChannel_All
 group by region,branch_id,branch_name,year,month,week,prodLine,ProdGrp,psub_id

---- special product creation
delete from Wk_Report_bySubChannel_Spc where  week>=@week -- 15 minutes
--q1
insert into Wk_Report_bySubChannel_Spc
select f.region,b.branch_id,f.branch_name,b.year,b.month,b.week,sub_channel,text_id,psub_id,sum(net_qty) as net_qty,sum(net_amt) as net_amt
   from sttwktmp b  
 left outer join customerdist_1910a c on b.custd_id=c.kode_iap
 inner join product_spc d on b.prod_id=d.prod_id
 --left outer join prodcat e on d.psub_id=e.psub_id
 left outer join branch f on b.branch_id=f.branch_id
 where  week>=@week
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
 where  week>=@week
 group by f.region,b.branch_id,f.branch_name,year,month,week,sub_channel,text_id,d.psub_id --) as a
 --left outer join prodcat e on a.psub_id=e.psub_id
*/
delete from Wk_Report_bySubChannel_Spc where sub_channel='ALL'
insert into Wk_Report_bySubChannel_spc
select region,branch_id,branch_name,year,month,week,'ALL' as sub_channel,text_id,psub_id,sum(net_qty) as net_qty,sum(net_amt) as net_amt
 from Wk_Report_bySubChannel_spc
 group by region,branch_id,branch_name,year,month,week,text_id,psub_id
  

 --exec sp_CreateWeeklyReport_NoDrop
 --exec sp_shrinkSalesLog
---- custbuy
---- special product creation
 --exec sp_shrinkalllog

--exec sp_CreateWeeklyReport_NoDrop
--select distinct year,week from sttwktmp1

--select distinct year,week from sttwktmp

 
---insert into sttwk_tmp.dbo.sttwktmp
--select year,week,sum(net_qty) from sttwktmp group by year,week

--select *from cwk where yrwk=2021