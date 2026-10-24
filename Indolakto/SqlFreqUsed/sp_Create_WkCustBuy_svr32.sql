USE [AdventureSales]
GO
/****** Object:  StoredProcedure [dbo].[sp_Create_WkCustBuy_NoDrop]    Script Date: 09/18/2024 14:54:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
alter PROCEDURE [dbo].[sp_Create_WkCustBuy]
	-- Add the parameters for the stored procedure here


AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
-- select distinct year,week from sttwk1a_uhtoth  order by year,week
	SET NOCOUNT ON;
--select *from sttwktmp1

    declare @week as smallint; 
set @week=1--(select cwk from begmonth);
    declare @month as smallint; 
set @month=1--(select mth from begmonth);
    declare @year as smallint; 
set @year=(select yr_num from begmonth);

 --select distinct year,week from sttwk1a1_22 order by year,week
-- delete from sttwk_2022b.dbo.sttwk where year=2022 and week=20
--insert into sttwk_2022b.dbo.sttwk
--select *from sttwktmp1
 --select sum(net_qty) from sttwk1a1_22 where year=2022 and week=20
 -- select distinct year,week from sttwk1a_sci order by year,week
drop table   adventuresales_lower2019.dbo.Wk_Report_CustBuy -- where year>=@year and week>=@week -- 15 minutes
--insert into Wk_Report_CustBuy
select a.*, cweek  
 into adventuresales_lower2019.dbo.Wk_Report_CustBuy
 from (
select b.year,b.month,b.week,'SCI' as psub_id,count(distinct(custd_id)) as CustBuy
  --from sttwk1a_sci_22 b  --- create like this, temporary, used sttwk1a1_22
    from sttwk1a_sci_fly b  --- create like this, temporary, used sttwk1a1_22
  left outer join product d on b.prod_id=d.prod_id
 --left outer join prodcat e on d.psub_id=e.psub_id
 left outer join branch f on b.branch_id=f.branch_id
 where year>=@year and week>=@week and psub_id like 'sci%' and net_qty>0
 group by f.region,b.branch_id,f.branch_name,year,month,week
union all
select b.year,b.month,b.week,'LAB130' as psub_id,count(distinct(custd_id)) as CustBuy
   from sttwk1a1_mk b
  left outer join product d on b.prod_id=d.prod_id
 --left outer join prodcat e on d.psub_id=e.psub_id
 left outer join branch f on b.branch_id=f.branch_id
 where year>=@year and week>=@week and psub_id like '%130%' and net_qty>0
 group by f.region,b.branch_id,f.branch_name,year,month,week
union all
select b.year,b.month,b.week,'LAB180' as psub_id,count(distinct(custd_id)) as CustBuy
   from sttwk1a1_mk b
  left outer join product d on b.prod_id=d.prod_id
 --left outer join prodcat e on d.psub_id=e.psub_id
 left outer join branch f on b.branch_id=f.branch_id
 where year>=@year and week>=@week and psub_id like 'LAB180%' and net_qty>0
 group by f.region,b.branch_id,f.branch_name,year,month,week
union all
select b.year,b.month,b.week,'KIDS' as psub_id,count(distinct(custd_id)) as CustBuy
   from sttwk1a_kids_fly b
  left outer join product d on b.prod_id=d.prod_id
 --left outer join prodcat e on d.psub_id=e.psub_id
 left outer join branch f on b.branch_id=f.branch_id
 where year>=@year and week>=@week and psub_id like 'KID%' and net_qty>0
 group by f.region,b.branch_id,f.branch_name,year,month,week
union all
select b.year,b.month,b.week,'U190 Reg' as psub_id,count(distinct(custd_id)) as CustBuy
   from sttwk1a1_uhtoth b
  left outer join product d on b.prod_id=d.prod_id
 --left outer join prodcat e on d.psub_id=e.psub_id
 left outer join branch f on b.branch_id=f.branch_id
 where year>=@year and week>=@week and psub_id like 'UHT190%' and net_qty>0 and d.text_id not in('UHT190B','UHT190JC')
 group by f.region,b.branch_id,f.branch_name,year,month,week
union all
select b.year,b.month,b.week,'UHT180' as psub_id,count(distinct(custd_id)) as CustBuy
   from sttwk1a1_uhtoth b
  left outer join product d on b.prod_id=d.prod_id
 --left outer join prodcat e on d.psub_id=e.psub_id
 left outer join branch f on b.branch_id=f.branch_id
 where year>=@year and week>=@week and text_id like 'UHT180%' and net_qty>0 
 group by f.region,b.branch_id,f.branch_name,year,month,week
union all
select b.year,b.month,b.week,'UHT250' as psub_id,count(distinct(custd_id)) as CustBuy
   from sttwk1a1_uhtoth b
  left outer join product d on b.prod_id=d.prod_id
 --left outer join prodcat e on d.psub_id=e.psub_id
 left outer join branch f on b.branch_id=f.branch_id
 where year>=@year and week>=@week and psub_id like 'UHT250%' and net_qty>0
 group by f.region,b.branch_id,f.branch_name,year,month,week
union all
select b.year,b.month,b.week,'UHT1LT' as psub_id,count(distinct(custd_id)) as CustBuy
   from sttwk1a1_uhtoth b
  left outer join product d on b.prod_id=d.prod_id
 --left outer join prodcat e on d.psub_id=e.psub_id
 left outer join branch f on b.branch_id=f.branch_id
 where year>=@year and week>=@week and psub_id like 'UHT1L%' and net_qty>0
 group by f.region,b.branch_id,f.branch_name,year,month,week
union all
select b.year,b.month,b.week,'SCIVM' as psub_id,count(distinct(custd_id)) as CustBuy
   from sttwk1a_sci_fly b
  left outer join product d on b.prod_id=d.prod_id
 --left outer join prodcat e on d.psub_id=e.psub_id
 left outer join branch f on b.branch_id=f.branch_id
 where year>=@year and week>=@week and d.text_id like 'SCIVM%' and net_qty>0
 group by f.region,b.branch_id,f.branch_name,year,month,week
union all
select b.year,b.month,b.week,'SCI-Mie' as psub_id,count(distinct(custd_id)) as CustBuy
   from sttwk1a_sci_fly b
  left outer join product d on b.prod_id=d.prod_id
 --left outer join prodcat e on d.psub_id=e.psub_id
 left outer join branch f on b.branch_id=f.branch_id
 where year>=@year and week>=@week and d.text_id like '%Mie' and net_qty>0
 group by f.region,b.branch_id,f.branch_name,year,month,week
union all
select b.year,b.month,b.week,'SCI-Reg' as psub_id,count(distinct(custd_id)) as CustBuy
   from sttwk1a_sci_fly b
  left outer join product d on b.prod_id=d.prod_id
 --left outer join prodcat e on d.psub_id=e.psub_id
 left outer join branch f on b.branch_id=f.branch_id
 where year>=@year and week>=@week and d.text_id not like '%Mie' and psub_id like 'sci%' and net_qty>0
 group by f.region,b.branch_id,f.branch_name,year,month,week
union all
select b.year,b.month,b.week,'KIDS-MP' as psub_id,count(distinct(custd_id)) as CustBuy
   from sttwk1a_kids_fly b
  left outer join product d on b.prod_id=d.prod_id
 --left outer join prodcat e on d.psub_id=e.psub_id
 left outer join branch f on b.branch_id=f.branch_id
 where year>=@year and week>=@week and psub_id like 'KIDS-MP%' and net_qty>0
 group by f.region,b.branch_id,f.branch_name,year,month,week
union all
select b.year,b.month,b.week,'KIDCLS' as psub_id,count(distinct(custd_id)) as CustBuy
   from sttwk1a_kids_fly b
  left outer join product d on b.prod_id=d.prod_id
 --left outer join prodcat e on d.psub_id=e.psub_id
 left outer join branch f on b.branch_id=f.branch_id
 where year>=@year and week>=@week and text_id like 'KID%CLS' and net_qty>0
 group by f.region,b.branch_id,f.branch_name,year,month,week
union all
select b.year,b.month,b.week,'LAB70' as psub_id,count(distinct(custd_id)) as CustBuy
   from sttwk1a1_mk b
  left outer join product d on b.prod_id=d.prod_id
 --left outer join prodcat e on d.psub_id=e.psub_id
 left outer join branch f on b.branch_id=f.branch_id
 where year>=@year and week>=@week and psub_id like 'LAB70%' and net_qty>0
 group by f.region,b.branch_id,f.branch_name,year,month,week
union all
select b.year,b.month,b.week,'POUCH' as psub_id,count(distinct(custd_id)) as CustBuy
   from sttwk1a1_mk b
  left outer join product d on b.prod_id=d.prod_id
 --left outer join prodcat e on d.psub_id=e.psub_id
 left outer join branch f on b.branch_id=f.branch_id
 where year>=@year and week>=@week and psub_id like 'POUC%' and net_qty>0
 group by f.region,b.branch_id,f.branch_name,year,month,week
union all
select b.year,b.month,b.week,'TETRA' as psub_id,count(distinct(custd_id)) as CustBuy
   from sttwk1a1_mk b
  left outer join product d on b.prod_id=d.prod_id
 --left outer join prodcat e on d.psub_id=e.psub_id
 left outer join branch f on b.branch_id=f.branch_id
 where year>=@year and week>=@week and psub_id like 'TETRA%' and net_qty>0
 group by f.region,b.branch_id,f.branch_name,year,month,week
union all
select b.year,b.month,b.week,psub_id1 as psub_id,count(distinct(custd_id)) as CustBuy
   from sttwk1a1_sbob b
  left outer join product d on b.prod_id=d.prod_id
  left outer join prodcat e on d.text_id=e.psub_id
 left outer join branch f on b.branch_id=f.branch_id
 where year>=@year and week>=@week and d.psub_id like 'sb%' and net_qty>0
 group by f.region,b.branch_id,f.branch_name,year,month,week,psub_id1
union all
select b.year,b.month,b.week,psub_id1 as psub_id,count(distinct(custd_id)) as CustBuy
   from sttwk1a1_stc b
  left outer join product d on b.prod_id=d.prod_id
  left outer join prodcat e on d.psub_id=e.psub_id
 left outer join branch f on b.branch_id=f.branch_id
 where year>=@year and week>=@week and d.psub_id like 'STC%' and net_qty>0
 group by f.region,b.branch_id,f.branch_name,year,month,week,psub_id1
) as a
left outer join cwk b on a.year=b.yrwk and a.week=b.wk_num
-- select *from cwk
--select *from cwk where wk_num between 1 and 9 and yrwk in (2023,2024) order by yrwk
--insert into cwk 
--select week,cweek,2024 as yrwk,wk_num,week1,mthwk,wkmth from cwk where yrwk=2023

/*
insert into cwk 
select week,cweek,2023 as yrwk,wk_num,week1,mthwk,wkmth
 from cwk where yrwk=2022

select *
 from cwk where year=2022
*/
 
--- mth
delete from Mth_Report_CustBuy  where year>=@year and month>=@month-- 15 minutes
 insert into Mth_Report_CustBuy
select *  from (
select b.year,b.month,'SCI' as psub_id,count(distinct(custd_id)) as CustBuy
  from sttmt_sci_fly b  
  left outer join product d on b.prod_id=d.prod_id
 --left outer join prodcat e on d.psub_id=e.psub_id
 left outer join branch f on b.branch_id=f.branch_id
 where year>=@year  and month>=@month and psub_id like 'sci%' and net_qty>0
 group by f.region,b.branch_id,f.branch_name,year,month
union all
select b.year,b.month,'LAB130' as psub_id,count(distinct(custd_id)) as CustBuy
   from sttmt_mk_fly b
  left outer join product d on b.prod_id=d.prod_id
 --left outer join prodcat e on d.psub_id=e.psub_id
 left outer join branch f on b.branch_id=f.branch_id
 where year>=@year  and month>=@month and psub_id like '%130%' and net_qty>0
 group by f.region,b.branch_id,f.branch_name,year,month
union all
select b.year,b.month,'KIDS' as psub_id,count(distinct(custd_id)) as CustBuy
   from sttmt_kids_fly b
  left outer join product d on b.prod_id=d.prod_id
 --left outer join prodcat e on d.psub_id=e.psub_id
 left outer join branch f on b.branch_id=f.branch_id
 where year>=@year  and month>=@month and psub_id like 'KID%' and net_qty>0
 group by f.region,b.branch_id,f.branch_name,year,month
union all
select b.year,b.month,'U190 Reg' as psub_id,count(distinct(custd_id)) as CustBuy
   from sttmt_uhtoth_fly b
  left outer join product d on b.prod_id=d.prod_id
 --left outer join prodcat e on d.psub_id=e.psub_id
 left outer join branch f on b.branch_id=f.branch_id
 where year>=@year  and month>=@month and (psub_id = 'UHT190' or psub_id ='UHT190-MP') and net_qty>0
 group by f.region,b.branch_id,f.branch_name,year,month
union all
select b.year,b.month,'UHT180' as psub_id,count(distinct(custd_id)) as CustBuy
   from sttmt_uhtoth_fly b
  left outer join product d on b.prod_id=d.prod_id
 --left outer join prodcat e on d.psub_id=e.psub_id
 left outer join branch f on b.branch_id=f.branch_id
 where year>=@year  and month>=@month and text_id like 'UHT180%' and net_qty>0
 group by f.region,b.branch_id,f.branch_name,year,month
union all
select b.year,b.month,'UHT250' as psub_id,count(distinct(custd_id)) as CustBuy
   from sttmt_uhtoth_fly b
  left outer join product d on b.prod_id=d.prod_id
 --left outer join prodcat e on d.psub_id=e.psub_id
 left outer join branch f on b.branch_id=f.branch_id
 where year>=@year and month>=@month  and psub_id like 'UHT250%' and net_qty>0
 group by f.region,b.branch_id,f.branch_name,year,month
union all
select b.year,b.month,'UHT1LT' as psub_id,count(distinct(custd_id)) as CustBuy
   from sttmt_uhtoth_fly b
  left outer join product d on b.prod_id=d.prod_id
 --left outer join prodcat e on d.psub_id=e.psub_id
 left outer join branch f on b.branch_id=f.branch_id
 where year>=@year  and month>=@month and psub_id like 'UHT1L%' and net_qty>0
 group by f.region,b.branch_id,f.branch_name,year,month
union all
select b.year,b.month,'SCIVM' as psub_id,count(distinct(custd_id)) as CustBuy
   from sttmt_sci_fly b
  left outer join product d on b.prod_id=d.prod_id
 --left outer join prodcat e on d.psub_id=e.psub_id
 left outer join branch f on b.branch_id=f.branch_id
 where year>=@year  and month>=@month and text_id like 'scivm%' and net_qty>0
 group by f.region,b.branch_id,f.branch_name,year,month
union all
select b.year,b.month,'SCI-Mie' as psub_id,count(distinct(custd_id)) as CustBuy
   from sttmt_sci_fly b
  left outer join product d on b.prod_id=d.prod_id
 --left outer join prodcat e on d.psub_id=e.psub_id
 left outer join branch f on b.branch_id=f.branch_id
 where year>=@year  and month>=@month and text_id like '%Mie' and net_qty>0
 group by f.region,b.branch_id,f.branch_name,year,month
union all
select b.year,b.month,'SCI-Reg' as psub_id,count(distinct(custd_id)) as CustBuy
   from sttmt_sci_fly b
  left outer join product d on b.prod_id=d.prod_id
 --left outer join prodcat e on d.psub_id=e.psub_id
 left outer join branch f on b.branch_id=f.branch_id
 where year>=@year and month>=@month  and text_id not like '%Mie' and psub_id like 'sci%' and net_qty>0
 group by f.region,b.branch_id,f.branch_name,year,month
union all
select b.year,b.month,'KIDS-MP' as psub_id,count(distinct(custd_id)) as CustBuy
   from sttmt_kids_fly b
  left outer join product d on b.prod_id=d.prod_id
 --left outer join prodcat e on d.psub_id=e.psub_id
 left outer join branch f on b.branch_id=f.branch_id
 where year>=@year  and month>=@month and psub_id like 'KIDS-MP%' and net_qty>0
 group by f.region,b.branch_id,f.branch_name,year,month
union all
select b.year,b.month,'KIDCLS' as psub_id,count(distinct(custd_id)) as CustBuy
   from sttmt_kids_fly b
  left outer join product d on b.prod_id=d.prod_id
 --left outer join prodcat e on d.psub_id=e.psub_id
 left outer join branch f on b.branch_id=f.branch_id
 where year>=@year  and month>=@month and text_id like 'KID%CLS' and net_qty>0
 group by f.region,b.branch_id,f.branch_name,year,month
union all
select b.year,b.month,'LAB70' as psub_id,count(distinct(custd_id)) as CustBuy
   from sttmt_mk_fly b
  left outer join product d on b.prod_id=d.prod_id
 --left outer join prodcat e on d.psub_id=e.psub_id
 left outer join branch f on b.branch_id=f.branch_id
 where year>=@year  and month>=@month and psub_id like 'LAB70%' and net_qty>0
 group by f.region,b.branch_id,f.branch_name,year,month
union all
select b.year,b.month,'LAB180' as psub_id,count(distinct(custd_id)) as CustBuy
   from sttmt_mk_fly b
  left outer join product d on b.prod_id=d.prod_id
 --left outer join prodcat e on d.psub_id=e.psub_id
 left outer join branch f on b.branch_id=f.branch_id
 where year>=@year  and month>=@month and psub_id like 'LAB180%' and net_qty>0
 group by f.region,b.branch_id,f.branch_name,year,month
union all
select b.year,b.month,'POUCH' as psub_id,count(distinct(custd_id)) as CustBuy
   from sttmt_mk_fly b
  left outer join product d on b.prod_id=d.prod_id
 --left outer join prodcat e on d.psub_id=e.psub_id
 left outer join branch f on b.branch_id=f.branch_id
 where year>=@year and month>=@month and psub_id like 'POUCH%' and net_qty>0
 group by f.region,b.branch_id,f.branch_name,year,month
union all
select b.year,b.month,'TETRA' as psub_id,count(distinct(custd_id)) as CustBuy
   from sttmt_mk_fly b
  left outer join product d on b.prod_id=d.prod_id
 --left outer join prodcat e on d.psub_id=e.psub_id
 left outer join branch f on b.branch_id=f.branch_id
 where year>=@year  and month>=@month and psub_id like 'TETRA%' and net_qty>0
 group by f.region,b.branch_id,f.branch_name,year,month
union all
select b.year,b.month,psub_id1 as psub_id,count(distinct(custd_id)) as CustBuy
   from sttmt_sbob_fly b
  left outer join product d on b.prod_id=d.prod_id
 left outer join prodcat e on d.text_id=e.psub_id
 left outer join branch f on b.branch_id=f.branch_id
 where year>=@year  and month>=@month and d.psub_id like 'sb%' and net_qty>0
 group by f.region,b.branch_id,f.branch_name,year,month,psub_id1
union all
select b.year,b.month,psub_id1 as psub_id,count(distinct(custd_id)) as CustBuy
   from sttmt_stc_fly b
  left outer join product d on b.prod_id=d.prod_id
 left outer join prodcat e on d.psub_id=e.psub_id
 left outer join branch f on b.branch_id=f.branch_id
 where year>=@year  and month>=@month and d.psub_id like 'STC%' and net_qty>0
 group by f.region,b.branch_id,f.branch_name,year,month,psub_id1
) as a


--- result

--- result
delete from  Rst_Report_CustBuy where year=@year -- 15 minutes
 insert into Rst_Report_CustBuy
select *  from (
select b.year,'SCI' as psub_id,count(distinct(custd_id)) as CustBuy
  from sttyr_sci_fly b  
  left outer join product d on b.prod_id=d.prod_id
 --left outer join prodcat e on d.psub_id=e.psub_id
 left outer join branch f on b.branch_id=f.branch_id
 where year>=@year   and psub_id like 'sci%' and net_qty>0
 group by f.region,b.branch_id,f.branch_name,year
union all
select b.year,'LAB130' as psub_id,count(distinct(custd_id)) as CustBuy
   from sttyr_mk_fly b
  left outer join product d on b.prod_id=d.prod_id
 --left outer join prodcat e on d.psub_id=e.psub_id
 left outer join branch f on b.branch_id=f.branch_id
 where year>=@year   and psub_id like '%130%' and net_qty>0
 group by f.region,b.branch_id,f.branch_name,year
union all
select b.year,'LAB180' as psub_id,count(distinct(custd_id)) as CustBuy
   from sttyr_mk_fly b
  left outer join product d on b.prod_id=d.prod_id
 --left outer join prodcat e on d.psub_id=e.psub_id
 left outer join branch f on b.branch_id=f.branch_id
 where year>=@year   and psub_id like 'LAB180%' and net_qty>0
 group by f.region,b.branch_id,f.branch_name,year
union all
select b.year,'KIDS' as psub_id,count(distinct(custd_id)) as CustBuy
   from sttyr_kids_fly b
  left outer join product d on b.prod_id=d.prod_id
 --left outer join prodcat e on d.psub_id=e.psub_id
 left outer join branch f on b.branch_id=f.branch_id
 where year>=@year   and psub_id like 'KID%' and net_qty>0
 group by f.region,b.branch_id,f.branch_name,year
union all
select b.year,'U190 Reg' as psub_id,count(distinct(custd_id)) as CustBuy
   from sttyr_uhtoth_fly b
  left outer join product d on b.prod_id=d.prod_id
 --left outer join prodcat e on d.psub_id=e.psub_id
 left outer join branch f on b.branch_id=f.branch_id
 where year>=@year   and (psub_id = 'UHT190' or psub_id ='UHT190-MP') and net_qty>0
 group by f.region,b.branch_id,f.branch_name,year
union all
select b.year,'UHT180' as psub_id,count(distinct(custd_id)) as CustBuy
   from sttyr_uhtoth_fly b
  left outer join product d on b.prod_id=d.prod_id
 --left outer join prodcat e on d.psub_id=e.psub_id
 left outer join branch f on b.branch_id=f.branch_id
 where year>=@year   and text_id like 'UHT180%'  and net_qty>0
 group by f.region,b.branch_id,f.branch_name,year
union all
select b.year,'UHT250' as psub_id,count(distinct(custd_id)) as CustBuy
   from sttyr_uhtoth_fly b
  left outer join product d on b.prod_id=d.prod_id
 --left outer join prodcat e on d.psub_id=e.psub_id
 left outer join branch f on b.branch_id=f.branch_id
 where year>=@year   and psub_id like 'UHT250%' and net_qty>0
 group by f.region,b.branch_id,f.branch_name,year
union all
select b.year,'UHT1LT' as psub_id,count(distinct(custd_id)) as CustBuy
   from sttyr_uhtoth_fly b
  left outer join product d on b.prod_id=d.prod_id
 --left outer join prodcat e on d.psub_id=e.psub_id
 left outer join branch f on b.branch_id=f.branch_id
 where year>=@year   and psub_id like 'UHT1L%' and net_qty>0
 group by f.region,b.branch_id,f.branch_name,year
union all
select b.year,'SCIVM' as psub_id,count(distinct(custd_id)) as CustBuy
   from sttyr_sci_fly b
  left outer join product d on b.prod_id=d.prod_id
 --left outer join prodcat e on d.psub_id=e.psub_id
 left outer join branch f on b.branch_id=f.branch_id
 where year>=@year   and text_id like 'SCIVM%' and net_qty>0
 group by f.region,b.branch_id,f.branch_name,year
union all
select b.year,'SCI-Mie' as psub_id,count(distinct(custd_id)) as CustBuy
   from sttyr_sci_fly b
  left outer join product d on b.prod_id=d.prod_id
 --left outer join prodcat e on d.psub_id=e.psub_id
 left outer join branch f on b.branch_id=f.branch_id
 where year>=@year   and text_id like '%Mie' and net_qty>0
 group by f.region,b.branch_id,f.branch_name,year
union all
select b.year,'SCI-Reg' as psub_id,count(distinct(custd_id)) as CustBuy
   from sttyr_sci_fly b
  left outer join product d on b.prod_id=d.prod_id
 --left outer join prodcat e on d.psub_id=e.psub_id
 left outer join branch f on b.branch_id=f.branch_id
 where year>=@year   and text_id not like '%Mie' and psub_id like 'sci%' and net_qty>0
 group by f.region,b.branch_id,f.branch_name,year
union all
select b.year,'KIDS-MP' as psub_id,count(distinct(custd_id)) as CustBuy
   from sttyr_kids_fly b
  left outer join product d on b.prod_id=d.prod_id
 --left outer join prodcat e on d.psub_id=e.psub_id
 left outer join branch f on b.branch_id=f.branch_id
 where year>=@year   and psub_id like 'KIDS-MP%' and net_qty>0
 group by f.region,b.branch_id,f.branch_name,year
union all
select b.year,'KIDCLS' as psub_id,count(distinct(custd_id)) as CustBuy
   from sttyr_kids_fly b
  left outer join product d on b.prod_id=d.prod_id
 --left outer join prodcat e on d.psub_id=e.psub_id
 left outer join branch f on b.branch_id=f.branch_id
 where year>=@year   and text_id like 'KID%CLS' and net_qty>0
 group by f.region,b.branch_id,f.branch_name,year
union all
select b.year,'LAB70' as psub_id,count(distinct(custd_id)) as CustBuy
   from sttyr_mk_fly b
  left outer join product d on b.prod_id=d.prod_id
 --left outer join prodcat e on d.psub_id=e.psub_id
 left outer join branch f on b.branch_id=f.branch_id
 where year>=@year   and psub_id like 'LAB70%' and net_qty>0
 group by f.region,b.branch_id,f.branch_name,year
union all
select b.year,'POUCH' as psub_id,count(distinct(custd_id)) as CustBuy
   from sttyr_mk_fly b
  left outer join product d on b.prod_id=d.prod_id
 --left outer join prodcat e on d.psub_id=e.psub_id
 left outer join branch f on b.branch_id=f.branch_id
 where year>=@year   and psub_id like 'POUCH%' and net_qty>0
 group by f.region,b.branch_id,f.branch_name,year
union all
select b.year,'TETRA' as psub_id,count(distinct(custd_id)) as CustBuy
   from sttyr_mk_fly b
  left outer join product d on b.prod_id=d.prod_id
 --left outer join prodcat e on d.psub_id=e.psub_id
 left outer join branch f on b.branch_id=f.branch_id
 where year>=@year   and psub_id like 'TETRA%' and net_qty>0
 group by f.region,b.branch_id,f.branch_name,year
union all
select b.year,psub_id1 as psub_id,count(distinct(custd_id)) as CustBuy
   from sttyr_sbob_fly b
  left outer join product d on b.prod_id=d.prod_id
 left outer join prodcat e on d.text_id=e.psub_id
 left outer join branch f on b.branch_id=f.branch_id
 where year>=@year   and d.psub_id like 'sb%' and net_qty>0
 group by f.region,b.branch_id,f.branch_name,year,psub_id1
union all
select b.year,psub_id1 as psub_id,count(distinct(custd_id)) as CustBuy
   from sttyr_stc_fly b
  left outer join product d on b.prod_id=d.prod_id
 left outer join prodcat e on d.psub_id=e.psub_id
 left outer join branch f on b.branch_id=f.branch_id
 where year>=@year   and d.psub_id like 'STC%' and net_qty>0
 group by f.region,b.branch_id,f.branch_name,year,psub_id1) as a

END

--exec sp_Create_WkCustBuy_NoDrop

--select year,week,sum(net_qty) from sttwk1a1_22 where week>14 group by year,week

--select year,week,sum(net_qty) as qty  from sttmttmp group by year,week

--select *from Wk_Report_CustBuy where month=8 and year=2022
--select *from Wk_Report_CustBuy where week=30 and year=2022 order by psub_id