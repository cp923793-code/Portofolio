USE [AdventureSales]
GO
/****** Object:  StoredProcedure [dbo].[sp_CreateLiquidSubChannel_NoDrop]    Script Date: 09/18/2024 16:56:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
alter PROCEDURE [dbo].[sp_CreateLiquidSubChannel]
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
declare @year as smallint;
set @year=(select yr_num from begmonth);
declare @month as smallint;
set @month=(select mth from begmonth);
declare @week as smallint;
set @week=(select cwk from begmonth);
--assuming sttwk1a consists of latest weeks

drop table  adventuresales_lower2019.dbo.Wk_Report_bySubChannel_Liquid ---- where year>=@year and week>=@week
--insert into Wk_Report_bySubChannel_Liquid
select b.year,b.month,b.week,sub_channel,product,'KIDS    ' as ProdSub,psub_id1, sum(net_qty) as net_qty, sum(net_amt) as net_amt
   into adventuresales_lower2019.dbo.Wk_Report_bySubChannel_Liquid
   from sttwk1a_kids_fly b  
 left outer join customerdist_1910a c on b.custd_id=c.kode_iap
 left outer join product_svr55 d on b.prod_id=d.prod_id
 left outer join prodcat e on d.psub_id=e.psub_id
 -- where year>=@year and week>=@week  and d.psub_id like 'KIDS%'   --- MP must still be included...please unthick single prouduct in MP sheet pivot for corrct result 
 group by year,month,week,sub_channel,product,psub_id1
 
--union all separated to avoid lack of memory
-- SCI
insert  into  adventuresales_lower2019.dbo.Wk_Report_bySubChannel_Liquid
select b.year,b.month,b.week,sub_channel,product,'SCI' as ProdSub,psub_id1, sum(net_qty) as net_qty, sum(net_amt) as net_amt
  from  sttwk1a_sci_fly b  
 left outer join customerdist_1910a c on b.custd_id=c.kode_iap
 left outer join product_svr55 d on b.prod_id=d.prod_id
 left outer join prodcat e on d.psub_id=e.psub_id
 -- where year>=@year and week>=@week  and d.psub_id like 'SCI%'   -- avoid double sci 
 group by year,month,week,sub_channel,product,psub_id1
--union all
-- SCIMie
insert  into  adventuresales_lower2019.dbo.Wk_Report_bySubChannel_Liquid
select b.year,b.month,b.week,sub_channel,product,'SCI-Mie' as ProdSub,psub_id1, sum(net_qty) as net_qty, sum(net_amt) as net_amt
  from sttwk1a_sci_fly b  
 left outer join customerdist_1910a c on b.custd_id=c.kode_iap
 left outer join product_svr55 d on b.prod_id=d.prod_id
 left outer join prodcat e on d.psub_id=e.psub_id
 -- where year>=@year and week>=@week  and d.text_id like 'SCI%Mie' 
 group by year,month,week,sub_channel,product,psub_id1
--union all
-- SCIReg
insert  into  adventuresales_lower2019.dbo.Wk_Report_bySubChannel_Liquid
select b.year,b.month,b.week,sub_channel,product,'SCI-Reg' as ProdSub,psub_id1, sum(net_qty) as net_qty, sum(net_amt) as net_amt
  from sttwk1a_sci_fly b  
 left outer join customerdist_1910a c on b.custd_id=c.kode_iap
 left outer join product_svr55 d on b.prod_id=d.prod_id
 left outer join prodcat e on d.psub_id=e.psub_id
 -- where year>=@year and week>=@week  and d.psub_id like 'SCI%' and d.text_id not like '%Mie' 
 group by year,month,week,sub_channel,product,psub_id1

--union all
--UHT
--drop table Wk_Report_bySubChannel_UHT
insert  into  adventuresales_lower2019.dbo.Wk_Report_bySubChannel_Liquid
select b.year,b.month,b.week,sub_channel,product,'UHT' as ProdSub,psub_id1, sum(net_qty) as net_qty, sum(net_amt) as net_amt
  from sttwk1a1_uhtoth b  
 left outer join customerdist_1910a c on b.custd_id=c.kode_iap
 left outer join product_svr55 d on b.prod_id=d.prod_id
 left outer join prodcat e on d.psub_id=e.psub_id
 -- where year>=@year and week>=@week  and d.psub_id like 'UHT%' 
 group by year,month,week,sub_channel,product,psub_id1 
--union all
insert  into  adventuresales_lower2019.dbo.Wk_Report_bySubChannel_Liquid
select b.year,b.month,b.week,sub_channel,product,'UHT180' as ProdSub,psub_id1, sum(net_qty) as net_qty, sum(net_amt) as net_amt
  from sttwk1a1_uhtoth b  
 left outer join customerdist_1910a c on b.custd_id=c.kode_iap
 left outer join product_svr55 d on b.prod_id=d.prod_id
 left outer join prodcat e on d.psub_id=e.psub_id
 -- where year>=@year and week>=@week  and d.text_id like 'UHT180%' 
 group by year,month,week,sub_channel,product,psub_id1 
-- KIDS-MP
insert  into  adventuresales_lower2019.dbo.Wk_Report_bySubChannel_Liquid
select b.year,b.month,b.week,sub_channel,product,'KIDS-MP' as ProdSub,psub_id1, sum(net_qty) as net_qty, sum(net_amt) as net_amt
  from sttwk1a_kids_fly b  
 left outer join customerdist_1910a c on b.custd_id=c.kode_iap
 left outer join product_svr55 d on b.prod_id=d.prod_id
 left outer join prodcat e on d.psub_id=e.psub_id
 -- where year>=@year and week>=@week  and d.psub_id like 'KIDS-MP%' 
 group by year,month,week,sub_channel,product,psub_id1
-- KIDCLS
insert  into  adventuresales_lower2019.dbo.Wk_Report_bySubChannel_Liquid
select b.year,b.month,b.week,sub_channel,product,'KIDCLS' as ProdSub,psub_id1, sum(net_qty) as net_qty, sum(net_amt) as net_amt
  from sttwk1a_kids_fly b  
 left outer join customerdist_1910a c on b.custd_id=c.kode_iap
 left outer join product_svr55 d on b.prod_id=d.prod_id
 left outer join prodcat e on d.psub_id=e.psub_id
 -- where year>=@year and week>=@week  and d.text_id like 'KID%LS' 
 group by year,month,week,sub_channel,product,psub_id1
--union all
-- LAB70
insert  into  adventuresales_lower2019.dbo.Wk_Report_bySubChannel_Liquid
select b.year,b.month,b.week,sub_channel,product,'LAB70' as ProdSub,psub_id1, sum(net_qty) as net_qty, sum(net_amt) as net_amt
  from sttwk1a1_mk b  
 left outer join customerdist_1910a c on b.custd_id=c.kode_iap
 left outer join product_svr55 d on b.prod_id=d.prod_id
 left outer join prodcat e on d.psub_id=e.psub_id
 -- where year>=@year and week>=@week  and d.psub_id like 'LAB70%' 
 group by year,month,week,sub_channel,product,psub_id1
--union all
-- LAB130
insert  into  adventuresales_lower2019.dbo.Wk_Report_bySubChannel_Liquid
select b.year,b.month,b.week,sub_channel,product,'LAB130' as ProdSub,psub_id1, sum(net_qty) as net_qty, sum(net_amt) as net_amt
  from sttwk1a1_mk b  
 left outer join customerdist_1910a c on b.custd_id=c.kode_iap
 left outer join product_svr55 d on b.prod_id=d.prod_id
 left outer join prodcat e on d.psub_id=e.psub_id
 -- where year>=@year and week>=@week  and d.psub_id like 'LAB130%' 
 group by year,month,week,sub_channel,product,psub_id1
-- LAB180
insert  into  adventuresales_lower2019.dbo.Wk_Report_bySubChannel_Liquid
select b.year,b.month,b.week,sub_channel,product,'LAB180' as ProdSub,psub_id1, sum(net_qty) as net_qty, sum(net_amt) as net_amt
  from sttwk1a1_mk b   
 left outer join customerdist_1910a c on b.custd_id=c.kode_iap
 left outer join product_svr55 d on b.prod_id=d.prod_id
 left outer join prodcat e on d.psub_id=e.psub_id
 -- where year>=@year and week>=@week  and d.psub_id like 'LAB180%' 
 group by year,month,week,sub_channel,product,psub_id1
--union all
-- pouch
insert  into  adventuresales_lower2019.dbo.Wk_Report_bySubChannel_Liquid
select b.year,b.month,b.week,sub_channel,product,'POUCH' as ProdSub,psub_id1, sum(net_qty) as net_qty, sum(net_amt) as net_amt
  from sttwk1a1_mk b  
 left outer join customerdist_1910a c on b.custd_id=c.kode_iap
 left outer join product_svr55 d on b.prod_id=d.prod_id
 left outer join prodcat e on d.psub_id=e.psub_id
 -- where year>=@year and week>=@week  and d.psub_id like 'pouch%' 
 group by year,month,week,sub_channel,product,psub_id1
--union all
-- tetra
insert  into  adventuresales_lower2019.dbo.Wk_Report_bySubChannel_Liquid
select b.year,b.month,b.week,sub_channel,product,'TETRA' as ProdSub,psub_id1, sum(net_qty) as net_qty, sum(net_amt) as net_amt
  from sttwk1a1_mk b  
 left outer join customerdist_1910a c on b.custd_id=c.kode_iap
 left outer join product_svr55 d on b.prod_id=d.prod_id
 left outer join prodcat e on d.psub_id=e.psub_id
 -- where year>=@year and week>=@week  and d.psub_id like 'tetra%' 
 group by year,month,week,sub_channel,product,psub_id1
-- POWDER
--UNION ALL
-- test select *from Wk_Report_bySubChannel_Liquid where year=2023 and week=9 and prodsub like 'SB%'

insert  into  adventuresales_lower2019.dbo.Wk_Report_bySubChannel_Liquid
select b.year,b.month,b.week,sub_channel,product,psub_id1 as ProdSub,psub_id1, sum(net_qty) as net_qty, sum(net_amt) as net_amt
  from sttwk1a1_sbob b  
 left outer join customerdist_1910a c on b.custd_id=c.kode_iap
 left outer join product_svr55 d on b.prod_id=d.prod_id
 left outer join prodcat e on d.psub_id=e.psub_id
--  left outer join prodcat e on d.text_id=e.psub_id
 -- where year>=@year and week>=@week  and d.psub_id like 'SB%' 
 group by year,month,week,sub_channel,product,psub_id1
--select *from prodcat order by psub_id where isnull(psub_id1,'')=''
/* 
select *from product a where text_id like 'SB%'
  and not exists
 (select 1 from prodcat b where a.text_id=b.psub_id) 
 and exists
 (select 1 from sttwktmp1 c where a.prod_id=c.prod_id and net_qty>0)
 order by text_id
*/
   --text_id using to connect to prodcat because grouping will be used is different
  --with existing psub_id, eg : SBB27 and SBI30 will be SB-SCH instead of SBB27 and SBI30
  --SBC400 and SBI400 will be SB-400 instead of SBC and SBI
-- stc
--UNION ALL
insert  into  adventuresales_lower2019.dbo.Wk_Report_bySubChannel_Liquid
select b.year,b.month,b.week,sub_channel,product,psub_id1 as ProdSub,psub_id1, sum(net_qty) as net_qty, sum(net_amt) as net_amt
  from sttwk1a1_stc b  
 left outer join customerdist_1910a c on b.custd_id=c.kode_iap
 left outer join product_svr55 d on b.prod_id=d.prod_id
 left outer join prodcat e on d.psub_id=e.psub_id
 -- where year>=@year and week>=@week  and d.psub_id like 'STC%' 
 group by year,month,week,sub_channel,product,psub_id1
--) as a


update Wk_Report_bySubChannel_Liquid set sub_channel='GT' where sub_channel='IFS'
update Wk_Report_bySubChannel_Liquid set sub_channel='MTI' where sub_channel='ECM'
update Wk_Report_bySubChannel_Liquid set sub_channel='GT' where sub_channel='DW_FS_ILO'
update Wk_Report_bySubChannel_Liquid set product=rtrim(product)



END

--exec sp_CreateLiquidSubChannel_NoDrop