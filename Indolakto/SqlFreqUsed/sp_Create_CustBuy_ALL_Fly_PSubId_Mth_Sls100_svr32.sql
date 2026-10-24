USE [AdventureSales]
GO
/****** Object:  StoredProcedure [dbo].[sp_Create_CustBuy_ALL_Fly_PSubId_Mth_Sls100]    Script Date: 01/07/2025 10:12:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create PROCEDURE [dbo].[sp_Create_CustBuy_ALL_Fly_PSubId_Mth_Sls100]
-- drop procedure sp_Create_CustBuy_ALL_Fly_Wk_Sls100_NoDrop  --- 7 minutes
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	declare @week as smallint;
	declare @month as smallint;
    declare @yr_num as smallint;
	set @week=3--(select cwk from begmonth);
    set @month=(select mth from begmonth);
    set @yr_num =(select yr_num-1 from begmonth);

---weekly report by category ...remember using sttwk1 (current) or sttwk2 (9-12 2020) for faster access
-- select distinct week from Wk_Report_bySubChannel_CB_Skm_C1
-- select sum(net_amt) from sttwk_2022a where week between 1 and 10
-- select distinct year,week from sttwk1a1_skm order by year,week
-- select *from prodcat
-- select distinct year,week from Discount_Cek.dbo.Wk_Report_bySubChannel_CB_PSubId_All order by year,week
-- select week,sum(net_qty) from sttmttmp group by week
-- select *from Mth_Report_bySubChannel_CB_PSubId_All
drop table adventuresales_lower2019.dbo.Mth_Report_bySubChannel_CB_PSubId_All --where year>=@yr_num+1 and week>=@week
    -- drop table Discount_Cek.dbo.Wk_Report_bySubChannel_CB_PSubId_All
select f.region,b.branch_id,f.branch_name,b.year,b.month,channel,sub_channel,e.sp_name,Udf6 as psub_id,prodline,prodgrp,
 'CustBuy' as Type, count(distinct b.custd_id) as CBSTT,e.sp_id,
  case when c.CRM='Y' then 'Y' else 'N' end as CRM,
  case when (r.sls_id <>'') and r.no<=100 then 'Y' else 'N' end as Sls_100,
  case when (r.sls_id <>'')  then 'Y' else 'N' end as Sls_200,depo,RetWhs,i.sls_type,b.sls_id 
-- case when L.sls_id <>'' then 'Y' else 'N' end as Sls_412,
 --case when m.sp_id <>'' then 'Y' else 'N' end as Sls_200
  into adventuresales_lower2019.dbo.Mth_Report_bySubChannel_CB_PSubId_All
   from sttmt_2023 as b  
 left outer join customerdist_1910a c on b.custd_id=c.kode_iap
 left outer join product_svr55 d on b.prod_id=d.prod_id
 left outer join stockpoint e on b.branch_id=e.branch_id and b.sp_id=e.sp_id
 left outer join branch f on b.branch_id=f.branch_id
   left outer join prodcat g on d.psub_id=g.psub_id
  -- left outer join sls_chlprn h on b.branch_id=h.br_chl and b.sp_id=h.sp_chl 
  -- and b.sls_id=h.sls_id_chl and b.year=h.year and b.month=h.week
   left outer join slsman i on b.branch_id=i.branch_id and b.sp_id=i.sp_id and b.sls_id=i.sls_id 
   --left outer join slsmanexc y on h.br_chl=y.branch_id and h.sp_chl=y.sp_id 
   --and h.sls_id_prn=y.sls_id 
 --LEFT OUTER JOIN  dbo.slsman AS h ON b.branch_id = h.branch_id AND b.sp_id = h.sp_id and b.sls_id=h.sls_id
 --  left outer join urbRural L on b.sp_id=L.sp_id
  left outer join slsmanexc r on b.branch_id=r.branch_id and b.sp_id=r.sp_id and b.sls_id=r.sls_id
 -- left outer join slsmanexc_200 m on b.sp_id=m.sp_id
 --where  (d.psub_id like 'CE%' or d.psub_id like 'IM-%' or d.psub_id like 'kre%' or d.psub_id like 'ts-%') and net_qty>0
 where  net_qty>0   --and b.year>=@yr_num+1 and b.week>=@week
  --and b.branch_id='5200/5202'
 group by f.region,b.branch_id,f.branch_name,b.year,month,channel,crm,sub_channel,e.sp_name,e.sp_id,--) as a
  udf6,prodgrp,r.sls_id,prodline,r.no,depo,RetWhs,i.sls_type, b.sls_id
-- select distinct year,week from sttwk1a1_skm order by year,week
-- select distinct year,month from sttmt_skm order by year,month
-- monthly


END

--exec sp_CreateSTT_CustBuy_SKM_FY

--select  year,sum(net_qty) as qty from sttwk1a1_21_22_skm group by year

--select distinct year,week from sttwk1a1_21_22_skm order by year,week
/*

select distinct sp_id from Wk_Report_bySubChannel_CB_PSubId_All where sls_200='Y'

update product set d.brand='UHT950'
 where d.brand like 'u%lt' 

update product set brand=psub_id
 where brand not like 'u%' or isnull(brand,'')=''

update product set brand='KIDS'
 where psub_id like 'KID%'

update product set brand='SCI'
 where text_id like 'SCI%'

update product set brand='SBI'
 where text_id like 'SBI%'

select * from product
 where psub_id like 'UHT250%CE%'

update product set brand='GTG'
 where psub_id like 'UHT250%CE%'

update product set brand='SBI30'
 where text_id like 'SBI30%'

update product set brand='TS-370'
 where psub_id='TS-CAN' and text_id in ('TSC370','TSP370','TSCN','TSPN')

update product set brand='TS-500'
 where psub_id='TS-CAN' and text_id in ('TSP490','TSPN500','TSPN500FS')

select distinct text_id,psub_id,brand
 from product  order by text_id, brand

update product set brand='SBC'
 where text_id like 'SBC%'

update product set brand='SBC37'
 where text_id like 'SBC37%'

update product set brand='SBB'
 where text_id like 'SBB%'

update product set brand='SBB27'
 where text_id like 'SBB27%'

update product set psub_id='SCI1LT'
 where text_id like 'SCI%LT'

delete from Wk_Report_bySubChannel_CB_Skm_C1 where Type='Amount'

select text_id,psub_id,brand   from product order by text_id,psub_id,brand  

update Wk_Report_bySubChannel_CB_Skm_C1 set Type='Qty' where Type='STT'
-- select *into Wk_Report_bySubChannel_CB_Skm_C1
  from Wk_Report_bySubChannel_CB_Skm where year=2027

drop table Wk_Report_bySubChannel_CB_Skm_East

truncate table Wk_Report_bySubChannel_CB_Skm_All
select *from urbRural

*/