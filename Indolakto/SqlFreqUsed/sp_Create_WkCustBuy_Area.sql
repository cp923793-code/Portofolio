USE [AdventureSales]
GO
/****** Object:  StoredProcedure [dbo].[sp_Create_WkCustBuy_Area_NoDrop]    Script Date: 09/18/2024 16:00:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create PROCEDURE [dbo].[sp_Create_WkCustBuy_Area] -- alert : GT Only
	-- Add the parameters for the stored procedure here


AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
--select *from begmonth
	SET NOCOUNT ON;
declare @year as smallint; 
--for faster results, only select KIDS and SCI this time
set @year=(select yr_num from begmonth);
    declare @month as smallint; 
--for faster results, only select KIDS and SCI this time
set @month=(select mth from begmonth);
    declare @week as smallint; 
--for faster results, only select KIDS and SCI this time
set @week=(select cwk from begmonth);

--STT weekly

drop table  adventuresales_lower2019.dbo.Wk_Report_stt_Area --where week>=@week and year>=@year-- 15 minutes
---insert into Wk_Report_stt_Area
select a.*, cweek  
 into adventuresales_lower2019.dbo.Wk_Report_stt_Area
 from (
select f.region,b.branch_id,f.branch_name,b.year,b.month,b.week,'SCI-Reg' as psub_id, product, sls_typgrp, sum(net_qty) as net_qty
  from sttwk1a_sci_fly b  
  left outer join product d on b.prod_id=d.prod_id
 inner join customerdist_1910a e on b.custd_id=e.kode_iap
 left outer join branch f on b.branch_id=f.branch_id
 left outer join slsman g on b.branch_id=g.branch_id and b.sp_id=g.sp_id and b.sls_id=g.sls_id
 left outer join slstypgrp h on g.sls_type=h.sls_type
 where  week>=@week and year>=@year and channel='GT' and psub_id like 'sci%' and d.text_id not like '%Mie'
 group by f.region,b.branch_id,f.branch_name,year,month,week, product, sls_typgrp
union all
select f.region,b.branch_id,f.branch_name,b.year,b.month,b.week,'SCI-Mie' as psub_id, product, sls_typgrp, sum(net_qty) as net_qty
  from sttwk1a_sci_fly b  
  left outer join product d on b.prod_id=d.prod_id
 inner join customerdist_1910a e on b.custd_id=e.kode_iap
 left outer join branch f on b.branch_id=f.branch_id
 left outer join slsman g on b.branch_id=g.branch_id and b.sp_id=g.sp_id and b.sls_id=g.sls_id
 left outer join slstypgrp h on g.sls_type=h.sls_type
 where  week>=@week and year>=@year and channel='GT' and psub_id like 'sci%' and d.text_id like '%Mie'
 group by f.region,b.branch_id,f.branch_name,year,month,week, product, sls_typgrp
union all
select f.region,b.branch_id,f.branch_name,b.year,b.month,b.week,'KIDS' as psub_id,product,sls_typgrp,sum(net_qty) as net_qty
   from sttwk1a_kids_fly b
  left outer join product d on b.prod_id=d.prod_id
 inner join customerdist_1910a e on b.custd_id=e.kode_iap
 left outer join branch f on b.branch_id=f.branch_id
  left outer join slsman g on b.branch_id=g.branch_id and b.sp_id=g.sp_id and b.sls_id=g.sls_id
 left outer join slstypgrp h on g.sls_type=h.sls_type
 where  channel='GT' and week>=@week and year>=@year and psub_id like 'KID%'  
 group by f.region,b.branch_id,f.branch_name,year,month,week,product,sls_typgrp
union all
select f.region,b.branch_id,f.branch_name,b.year,b.month,b.week,'KIDCLS' as psub_id,product,sls_typgrp,sum(net_qty) as net_qty
   from sttwk1a_kids_fly b
  left outer join product d on b.prod_id=d.prod_id
 inner join customerdist_1910a e on b.custd_id=e.kode_iap
 left outer join branch f on b.branch_id=f.branch_id
  left outer join slsman g on b.branch_id=g.branch_id and b.sp_id=g.sp_id and b.sls_id=g.sls_id
 left outer join slstypgrp h on g.sls_type=h.sls_type
 where  channel='GT' and week>=@week and year>=@year and text_id like 'KID%CLS'  
 group by f.region,b.branch_id,f.branch_name,year,month,week,product,sls_typgrp
 union all
select f.region,b.branch_id,f.branch_name,b.year,b.month,b.week,'STC' as psub_id,product,sls_typgrp,sum(net_qty) as net_qty
   from sttwk1a_stc_fly b
  left outer join product d on b.prod_id=d.prod_id
 inner join customerdist_1910a e on b.custd_id=e.kode_iap
 left outer join branch f on b.branch_id=f.branch_id
  left outer join slsman g on b.branch_id=g.branch_id and b.sp_id=g.sp_id and b.sls_id=g.sls_id
 left outer join slstypgrp h on g.sls_type=h.sls_type
 where  channel='GT' and week>=@week and year>=@year and text_id like 'STC%'  
 group by f.region,b.branch_id,f.branch_name,year,month,week,product,sls_typgrp
 union all
select f.region,b.branch_id,f.branch_name,b.year,b.month,b.week,'UHT1LT' as psub_id,product,sls_typgrp,sum(net_qty) as net_qty
   from sttwk1a_uhtoth_fly b
  left outer join product d on b.prod_id=d.prod_id
 inner join customerdist_1910a e on b.custd_id=e.kode_iap
 left outer join branch f on b.branch_id=f.branch_id
  left outer join slsman g on b.branch_id=g.branch_id and b.sp_id=g.sp_id and b.sls_id=g.sls_id
 left outer join slstypgrp h on g.sls_type=h.sls_type
 where  channel='GT' and psub_id like 'UHT1LT%'  and week>=@week and year>=@year
 group by f.region,b.branch_id,f.branch_name,year,month,week,product,sls_typgrp
 union all
select f.region,b.branch_id,f.branch_name,b.year,b.month,b.week,'UHT180' as psub_id,product,sls_typgrp,sum(net_qty) as net_qty
   from sttwk1a_uhtoth_fly b
  left outer join product d on b.prod_id=d.prod_id
 inner join customerdist_1910a e on b.custd_id=e.kode_iap
 left outer join branch f on b.branch_id=f.branch_id
  left outer join slsman g on b.branch_id=g.branch_id and b.sp_id=g.sp_id and b.sls_id=g.sls_id
 left outer join slstypgrp h on g.sls_type=h.sls_type
 where  channel='GT' and udf1 like 'UHT180%'  and week>=@week and year>=@year
 group by f.region,b.branch_id,f.branch_name,year,month,week,product,sls_typgrp

) as a
 left outer join cwk b on a.year=b.yrwk and a.week=b.wk_num

 
 

--custbuy
-----
delete from Wk_Report_CustBuy_Area where week>=@week and year>=@year  -- 15 minutes
 insert  into Wk_Report_CustBuy_Area
select a.*, cweek from (
select f.region,b.branch_id,f.branch_name,b.year,b.month,b.week,'SCI' as psub_id,count(distinct(b.custd_id)) as CustBuy
  from sttwk1a_sci_fly b  
  left outer join product d on b.prod_id=d.prod_id
 inner join customerdist_1910a e on b.custd_id=e.kode_iap
 left outer join branch f on b.branch_id=f.branch_id
 where  channel='GT' and week>=@week and year>=@year and psub_id like 'sci%' and net_qty>0
 group by f.region,b.branch_id,f.branch_name,year,month,week
 union all
select f.region,b.branch_id,f.branch_name,b.year,b.month,b.week,'SCI-Reg' as psub_id,count(distinct(b.custd_id)) as CustBuy
  from sttwk1a_sci_fly b  
  left outer join product d on b.prod_id=d.prod_id
 inner join customerdist_1910a e on b.custd_id=e.kode_iap
 left outer join branch f on b.branch_id=f.branch_id
 where  channel='GT' and week>=@week and year>=@year and psub_id like 'sci%' and d.text_id not like '%Mie' and net_qty>0
 group by f.region,b.branch_id,f.branch_name,year,month,week
 union all
select f.region,b.branch_id,f.branch_name,b.year,b.month,b.week,'SCI-Mie' as psub_id,count(distinct(b.custd_id)) as CustBuy
  from sttwk1a_sci_fly b  
  left outer join product d on b.prod_id=d.prod_id
 inner join customerdist_1910a e on b.custd_id=e.kode_iap
 left outer join branch f on b.branch_id=f.branch_id
 where  channel='GT' and week>=@week and year>=@year and psub_id like 'sci%' and d.text_id like '%Mie' and net_qty>0
 group by f.region,b.branch_id,f.branch_name,year,month,week
union all
select f.region,b.branch_id,f.branch_name,b.year,b.month,b.week,'KIDS' as psub_id,count(distinct(b.custd_id)) as CustBuy
   from sttwk1a_kids_fly b
  left outer join product d on b.prod_id=d.prod_id
 inner join customerdist_1910a e on b.custd_id=e.kode_iap
 left outer join branch f on b.branch_id=f.branch_id
 where  channel='GT' and week>=@week and year>=@year and psub_id like 'KID%' and net_qty>0
 group by f.region,b.branch_id,f.branch_name,year,month,week
union all
select f.region,b.branch_id,f.branch_name,b.year,b.month,b.week,'KIDCLS' as psub_id,count(distinct(b.custd_id)) as CustBuy
   from sttwk1a_kids_fly b
  left outer join product d on b.prod_id=d.prod_id
 inner join customerdist_1910a e on b.custd_id=e.kode_iap
 left outer join branch f on b.branch_id=f.branch_id
 where  channel='GT' and week>=@week and year>=@year and text_id like 'KID%CLS' and net_qty>0
 group by f.region,b.branch_id,f.branch_name,year,month,week
union all
select f.region,b.branch_id,f.branch_name,b.year,b.month,b.week,'STC' as psub_id,count(distinct(b.custd_id)) as CustBuy
   from sttwk1a_stc_fly b
  left outer join product d on b.prod_id=d.prod_id
 inner join customerdist_1910a e on b.custd_id=e.kode_iap
 left outer join branch f on b.branch_id=f.branch_id
 where  channel='GT' and week>=@week and year>=@year and text_id like 'STC%' and net_qty>0
 group by f.region,b.branch_id,f.branch_name,year,month,week
 union all
select f.region,b.branch_id,f.branch_name,b.year,b.month,b.week,'UHT1LT' as psub_id,count(distinct(b.custd_id)) as CustBuy
   from sttwk1a_uhtoth_fly b
  left outer join product d on b.prod_id=d.prod_id
 inner join customerdist_1910a e on b.custd_id=e.kode_iap
 left outer join branch f on b.branch_id=f.branch_id
 where  channel='GT' and psub_id like 'UHT1LT%' and net_qty>0 and week>=@week and year>=@year
 group by f.region,b.branch_id,f.branch_name,year,month,week
 union all
 select f.region,b.branch_id,f.branch_name,b.year,b.month,b.week,'UHT180' as psub_id,count(distinct(b.custd_id)) as CustBuy
   from sttwk1a_uhtoth_fly b
  left outer join product d on b.prod_id=d.prod_id
 inner join customerdist_1910a e on b.custd_id=e.kode_iap
 left outer join branch f on b.branch_id=f.branch_id
 where  channel='GT' and udf1 like 'UHT180%' and net_qty>0 and week>=@week and year>=@year
 group by f.region,b.branch_id,f.branch_name,year,month,week

) as a
left outer join cwk b on a.year=b.yrwk and a.week=b.wk_num
 
	--- mth
	delete from Mth_Report_CustBuy_Area where month>=@month and year>=@year -- 15 minutes
  insert into Mth_Report_CustBuy_Area
	select *  from (
	select f.region,b.branch_id,f.branch_name,b.year,b.month,'SCI' as psub_id,count(distinct(b.custd_id)) as CustBuy
	  from sttmt_sci_fly b  
	  left outer join product d on b.prod_id=d.prod_id
	 inner join customerdist_1910a e on b.custd_id=e.kode_iap
	 left outer join branch f on b.branch_id=f.branch_id
	 where  channel='GT' and month>=@month and year>=@year and psub_id like 'sci%' and net_qty>0
	 group by f.region,b.branch_id,f.branch_name,year,month
     union all
 	select f.region,b.branch_id,f.branch_name,b.year,b.month,'SCI-Reg' as psub_id,count(distinct(b.custd_id)) as CustBuy
	  from sttmt_sci_fly b  
	  left outer join product d on b.prod_id=d.prod_id
	 inner join customerdist_1910a e on b.custd_id=e.kode_iap
	 left outer join branch f on b.branch_id=f.branch_id
	 where  channel='GT' and month>=@month and year>=@year and psub_id like 'sci%' and text_id not like '%Mie' and net_qty>0
	 group by f.region,b.branch_id,f.branch_name,year,month
      union all
 	select f.region,b.branch_id,f.branch_name,b.year,b.month,'SCI-Mie' as psub_id,count(distinct(b.custd_id)) as CustBuy
	  from sttmt_sci_fly b  
	  left outer join product d on b.prod_id=d.prod_id
	 inner join customerdist_1910a e on b.custd_id=e.kode_iap
	 left outer join branch f on b.branch_id=f.branch_id
	 where  channel='GT' and month>=@month and year>=@year and psub_id like 'sci%' and text_id like '%Mie' and net_qty>0
	 group by f.region,b.branch_id,f.branch_name,year,month
	union all
	select f.region,b.branch_id,f.branch_name,b.year,b.month,'KIDS' as psub_id,count(distinct(b.custd_id)) as CustBuy
	   from sttmt_kids_fly b
	  left outer join product d on b.prod_id=d.prod_id
	 inner join customerdist_1910a e on b.custd_id=e.kode_iap
	 left outer join branch f on b.branch_id=f.branch_id
	 where  channel='GT' and month>=@month and year>=@year and psub_id like 'KID%' and net_qty>0
	 group by f.region,b.branch_id,f.branch_name,year,month
	 union all
	select f.region,b.branch_id,f.branch_name,b.year,b.month,'KIDCLS' as psub_id,count(distinct(b.custd_id)) as CustBuy
	   from sttmt_kids_fly b
	  left outer join product d on b.prod_id=d.prod_id
	 inner join customerdist_1910a e on b.custd_id=e.kode_iap
	 left outer join branch f on b.branch_id=f.branch_id
	 where  channel='GT' and month>=@month and year>=@year and text_id like 'KID%CLS' and net_qty>0
	 group by f.region,b.branch_id,f.branch_name,year,month
 	 union all
	select f.region,b.branch_id,f.branch_name,b.year,b.month,'STC' as psub_id,count(distinct(b.custd_id)) as CustBuy
	   from sttmt_stc_fly b
	  left outer join product d on b.prod_id=d.prod_id
	 inner join customerdist_1910a e on b.custd_id=e.kode_iap
	 left outer join branch f on b.branch_id=f.branch_id
	 where  channel='GT' and month>=@month and year>=@year and text_id like 'STC%' and net_qty>0
	 group by f.region,b.branch_id,f.branch_name,year,month
  	 union all
	select f.region,b.branch_id,f.branch_name,b.year,b.month,'UHT1LT' as psub_id,count(distinct(b.custd_id)) as CustBuy
	   from sttmt_uhtoth_fly b
	  left outer join product d on b.prod_id=d.prod_id
	 inner join customerdist_1910a e on b.custd_id=e.kode_iap
	 left outer join branch f on b.branch_id=f.branch_id
	 where  channel='GT' and month>=@month and year>=@year and psub_id like 'UHT1LT%' and net_qty>0
	 group by f.region,b.branch_id,f.branch_name,year,month
   union all
  	select f.region,b.branch_id,f.branch_name,b.year,b.month,'UHT180' as psub_id,count(distinct(b.custd_id)) as CustBuy
	   from sttmt_uhtoth_fly b
	  left outer join product d on b.prod_id=d.prod_id
	 inner join customerdist_1910a e on b.custd_id=e.kode_iap
	 left outer join branch f on b.branch_id=f.branch_id
	 where  channel='GT' and month>=@month and year>=@year and udf1 like 'UHT180%' and net_qty>0
	 group by f.region,b.branch_id,f.branch_name,year,month
		) as a
--- result
delete from Yr_Report_CustBuy_Area where year>=@year -- 15 minutes
 insert into Yr_Report_CustBuy_Area
select *  from (
select f.region,b.branch_id,f.branch_name,b.year,'SCI' as psub_id,count(distinct(b.custd_id)) as CustBuy
  from sttyr_sci_fly b  
  left outer join product d on b.prod_id=d.prod_id
 inner join customerdist_1910a e on b.custd_id=e.kode_iap
 left outer join branch f on b.branch_id=f.branch_id
 where  channel='GT'   and year>=@year and psub_id like 'sci%' and net_qty>0
 group by f.region,b.branch_id,f.branch_name,year
 union all
 select f.region,b.branch_id,f.branch_name,b.year,'SCI-Reg' as psub_id,count(distinct(b.custd_id)) as CustBuy
  from sttyr_sci_fly b  
  left outer join product d on b.prod_id=d.prod_id
 inner join customerdist_1910a e on b.custd_id=e.kode_iap
 left outer join branch f on b.branch_id=f.branch_id
 where  channel='GT'  and year>=@year and psub_id like 'sci%' and text_id not like '%Mie' and net_qty>0
 group by f.region,b.branch_id,f.branch_name,year
 union all
 select f.region,b.branch_id,f.branch_name,b.year,'SCI-Mie' as psub_id,count(distinct(b.custd_id)) as CustBuy
  from sttyr_sci_fly b  
  left outer join product d on b.prod_id=d.prod_id
 inner join customerdist_1910a e on b.custd_id=e.kode_iap
 left outer join branch f on b.branch_id=f.branch_id
 where  channel='GT'  and year>=@year and psub_id like 'sci%' and text_id like '%Mie' and net_qty>0
 group by f.region,b.branch_id,f.branch_name,year
union all
select f.region,b.branch_id,f.branch_name,b.year,'KIDS' as psub_id,count(distinct(b.custd_id)) as CustBuy
   from sttyr_kids_fly b
  left outer join product d on b.prod_id=d.prod_id
 inner join customerdist_1910a e on b.custd_id=e.kode_iap
 left outer join branch f on b.branch_id=f.branch_id
 where  channel='GT'   and year>=@year and psub_id like 'KID%' and net_qty>0
 group by f.region,b.branch_id,f.branch_name,year
 union all
select f.region,b.branch_id,f.branch_name,b.year,'KIDCLS' as psub_id,count(distinct(b.custd_id)) as CustBuy
   from sttyr_kids_fly b
  left outer join product d on b.prod_id=d.prod_id
 inner join customerdist_1910a e on b.custd_id=e.kode_iap
 left outer join branch f on b.branch_id=f.branch_id
 where  channel='GT'   and year>=@year and text_id like 'KID%CLS' and net_qty>0
 group by f.region,b.branch_id,f.branch_name,year
  union all
select f.region,b.branch_id,f.branch_name,b.year,'STC' as psub_id,count(distinct(b.custd_id)) as CustBuy
   from sttyr_stc_fly b
  left outer join product d on b.prod_id=d.prod_id
 inner join customerdist_1910a e on b.custd_id=e.kode_iap
 left outer join branch f on b.branch_id=f.branch_id
 where  channel='GT'   and year>=@year and text_id like 'STC%' and net_qty>0
 group by f.region,b.branch_id,f.branch_name,year
   union all
select f.region,b.branch_id,f.branch_name,b.year,'UHT1LT' as psub_id,count(distinct(b.custd_id)) as CustBuy
   from sttyr_uhtoth_fly b
  left outer join product d on b.prod_id=d.prod_id
 inner join customerdist_1910a e on b.custd_id=e.kode_iap
 left outer join branch f on b.branch_id=f.branch_id
 where  channel='GT'   and year>=@year and psub_id like 'UHT1LT%' and net_qty>0
 group by f.region,b.branch_id,f.branch_name,year
 union all
 select f.region,b.branch_id,f.branch_name,b.year,'UHT180' as psub_id,count(distinct(b.custd_id)) as CustBuy
   from sttyr_uhtoth_fly b
  left outer join product d on b.prod_id=d.prod_id
 inner join customerdist_1910a e on b.custd_id=e.kode_iap
 left outer join branch f on b.branch_id=f.branch_id
 where  channel='GT'   and year>=@year and udf1 like 'UHT180%' and net_qty>0
 group by f.region,b.branch_id,f.branch_name,year
) as a

END


--exec sp_Create_WkCustBuy_Area_NoDrop