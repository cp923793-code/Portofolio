USE [AdventureSales]
GO
/****** Object:  StoredProcedure [dbo].[sp_Create_Discount_Cek_CB_Mth_PSubId]    Script Date: 01/07/2025 10:43:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create PROCEDURE [dbo].[sp_Create_Discount_Cek_CB_Yr_PSubId]
-- drop procedure sp_Create_Discount_Cek_CB_PSubId   --- 2 minutes
-- select distinct PSubId,prodgrp from productgrpspc
AS
BEGIN
 	SET NOCOUNT ON;
	declare @week as smallint;
	declare @month as smallint;
    declare @yr_num as smallint;
	set @week=(select cwk from begmonth);
    set @month=(select mth from begmonth);
    set @yr_num =2023--(select yr_num from begmonth);
--select distinct year,week from adventuresales_lower2019.dbo.Discount_cek order by year,week
--select year,sum(discount_b) from Discount_cek_PSubId_withCB group by year
--select year,sum(disc_b_amt) from discount_b group by year
----select year,sum(net_qty) from adventuresales_lower2019.dbo.Discount_cek_PSubId_withCB group by year,week order by year,week
drop table  adventuresales_lower2019.dbo.Discount_cek_PSubId_withCB_Yr
--execute this first please check sttmttmp
 -- select *from product_svr55
--exec sp_CreateDiscountCheck_Mth_PSubId  -- exec sp_CreateDiscountCheck
--exec sp_Create_CustBuy_ALL_Fly_PSubId_Mth_Sls100 -- exec sp_Create_CustBuy_PSubId_ALL_Fly_Wk_Sls100
-- select *from discount_cek_PSubId where disc_pt <>0
 --delete from adventuresales_lower2019.dbo.Wk_Report_bySubChannel_CB_PSubId_All where isnull(psub_id,'')=''
 -- select distinct year,month from discount_cek_PSubId order by year,month
SELECT     a.region, a.branch_id, a.branch_name, a.year,   a.channel, a.sub_channel, prodline,
  prodgrp, a.CRM, a.sp_name,a.sp_id, sls_100,sls_200,psub_Id, depo,RetWhs,sls_type,
 sls_id, sum(grs_amt) as grs_amt, sum(net_qty) as net_qty, sum(net_amt) as net_amt,sum(rtn_amt) as rtn_amt,sum(grs_qty) as grs_qty,sum(rtn_qty) as rtn_qty,
 sum(disc_amt) as disc_amt, sum(Discount_B) as Discount_B, sum(Discount_PotTunai) as Discount_PotTunai,sum(CustBuy) as CustBuy  
  into  adventuresales_lower2019.dbo.Discount_cek_PSubId_withCB_Yr from
-- select *from discount_cek_PSubId 
(select  a.region, a.branch_id, a.branch_name, a.year, channel, a.sub_channel, prodline,
 a.prodgrp, Psub_id,a.CRM, a.sp_name,a.sp_id, sls_100,sls_200,  'STT' as Type,depo,RetWhs,sls_type,sls_id, sum(grs_amt) as grs_amt,
  sum(net_qty) as net_qty, sum(net_amt) as net_amt,sum(rtn_amt) as rtn_amt,sum(grs_qty) as grs_qty,sum(rtn_qty) as rtn_qty,
 sum(disc_amt) as disc_amt, sum(Disc_B) as Discount_B, sum(Disc_PT) as Discount_PotTunai,0 as CustBuy 
 FROM        adventuresales_lower2019.dbo.discount_cek_PSubId as a  --  Discount_cek_slsid a-- where a.year>=@yr_num
-- inner join (select distinct PSubId,prodgrp from productgrpspc) b on a.psub_id=b.prodgrp
 group by a.region, a.branch_id, a.branch_name, a.year,  a. channel, a.sub_channel, prodline,
  a.prodgrp,psub_id,a.CRM, a.sp_id,a.sp_name,sls_100,sls_200,depo,RetWhs,sls_type,sls_id
 -- select distinct year,month from Mth_Report_bySubChannel_CB_PSubId_All order by year,month
Union all -- exec sp_Create_CustBuy_ALL_Fly_Wk_Sls100_NoDrop first
SELECT        a.region, a.branch_id, a.branch_name, a.year,   a.channel, a.sub_channel, prodline,
  prodgrp, psub_id,a.CRM, a.sp_name,a.sp_id, sls_100,sls_200,  'CustBuy' as Type,Depo,RetWhs,sls_type,sls_id, 0 as grs_amt,
  0 as net_qty, 0 as net_amt, 0 as rtn_amt, 0 as grs_qty,0 as rtn_qty,0 as disc_amt, 0 as Discount_B, 0 as Discount_PotTunai,sum(CBSTT) as CustBuy 
  from adventuresales_lower2019.dbo.Yr_Report_bySubChannel_CB_PSubId_All a  
 group by a.region, a.branch_id, a.branch_name, a.year,  a.channel, a.sub_channel, prodline,
  prodgrp, psub_id, a.CRM, a.sp_name,a.sp_id, sls_100,sls_200,depo,RetWhs,sls_type,sls_id
  ) as a
  group by  a.region, a.branch_id, a.branch_name, a.year,  a.channel, a.sub_channel, prodline,
  prodgrp, psub_id, a.CRM, a.sp_name,a.sp_id, sls_100,sls_200, Depo,RetWhs,sls_type,sls_id
 
      update adventuresales_lower2019.dbo.Discount_cek_PsubId_withCB_Yr set prodgrp='Liquid'
	  where prodgrp in ('SCI','STC','UHT')
   
    update  adventuresales_lower2019.dbo.Discount_cek_PsubId_withCB_Yr set prodgrp='Powder'
	  where prodgrp='PWDR'

end
 --delete from adventuresales_lower2019.dbo.Wk_Report_bySubChannel_CB_PSubId_All where isnull(psub_id,'')=''
 --select *from product_svr55 where udf6='' and udf1<>'' order by text_id
 --update product_svr55 set udf6=
 --select year,sum(discount_b) from discount_cek where week<39 group by year
 --select *from discount_cek
 --select distinct psub_id,psub_id1  from Wk_Report_bySubChannel_CB_PSubId_All
 --select sum(discount_b) from discount_cek where isnull(psub_id,'')=''
 /*
 select *from product_svr55 where udf1='TS-500'

 update  Discount_cek set psub_id='TS-TALL CAN' where psub_id1='TS-500' and psub_id=''

 select a.sp_id from sls_slc a
  where exists
  (select 1 from sls_200 b where a.sp_id=


  select a.year,sum(discount_b) from 
  (SELECT        a.region, a.branch_id, a.branch_name, a.year,  a. a.channel, a.sub_channel, prodline,
  prodgrp,psub_id1, a.CRM, a.sp_name,a.sp_id, sls_100,sls_200,  sum(grs_amt) as grs_amt,psub_id,
  sum(net_qty) as net_qty, sum(net_amt) as net_amt,sum(rtn_amt) as rtn_amt,
 sum(disc_amt) as disc_amt, sum(Discount_B) as Discount_B, sum(Discount_PotTunai) as Discount_PotTunai 
 FROM            Discount_cek a
 group by a.region, a.branch_id, a.branch_name, a.year,  a. a.channel, a.sub_channel, prodline,
  prodgrp,a.psub_id1, a.CRM, a.sp_id,a.sp_name,sls_100,sls_200,a.psub_id
  ) as a 
  left outer join Wk_Report_bySubChannel_CB_PSubId_All b on a.branch_id=b.branch_id and a.year=b.year and a.month=b.month and a.psub_id=b.psub_id
 and a.week=b.week and a.crm=b.crm and a.sp_id=b.sp_id and   a.psub_id1=b.psub_id1 --and a.sls_100=b.sls_100 and a.sls_200=b.sls_200
 and a.channel=b.channel and a.sub_channel=b.sub_channel and a.region=b.region  
 where a.week<=39
  group by a.year

  select *from Wk_Report_bySubChannel_CB_PSubId_All

 */





--select count(*) from Discount_cek