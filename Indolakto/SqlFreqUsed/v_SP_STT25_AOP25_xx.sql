USE [AdventureSales]
GO

/****** Object:  View [dbo].[v_SP_STT25_AOP25]    Script Date: 6/3/2025 5:10:51 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[v_SP_STT25_AOP25_xx]    
AS    
  --  select *from adventuresales_lower2019.dbo.Discount_cek_PSubId_withCB_weekly
  -- select *from product_svr55 where psub_id='CE-CAN'
  -- select *from prodcat
 -- Target
 select ProdGrp,region,branch_id,branch_name,sp_id,sp_name,depo, year, month, week, 
 sum(Tgt_Qty) as Tgt_qty, sum(Act_QTy) as Act_Qty,sum(LY_qty) as LY_qty from
 (
select region, branch_id, a.branch_name, 2025 as year, mth as month, week, 'GT' as channel, 'GT' as sub_channel, prodline,
  prodgrp, /*a.CRM,*/ sp_name,sp_id, /*sls_100,sls_200,*/ psub_id1,depo,/*RetWhs,sls_type,*/
  0 as grs_amt, 0 as net_qty, 0 as net_amt,0 as rtn_amt,0 as grs_qty,0 as rtn_qty,
 0 as disc_amt, 0 as Discount_B, 0 as  Discount_PotTunai,0 as CustBuy,
 b.net_qty*a.pct*c.pct as Tgt_Qty 
 from SP_Pct_AOP25_WholeYr_xx a -- select *from SP_Pct_AOP25_WholeYr_xx
  inner join AOP_2025_GT_xx b on a.Psub_id1=b.psub_id 
  inner join aop_pct c on b.year=c.year and b.mth=c.mth -- select *from SP_Pct_AOP25_WholeYr_xx
 --inner join qtr_wk_aop c on b.qtr=c.qtr 
 --inner join v_yr25_aop25 d on a.Psub_id1=d.prodgrp
 left outer join stockpoint e on a.sp_id=e.sp_id
  left outer join prodcatxx f on a.psub=f.psub_id1  -- select *from prodcatxx
 -- where d.type='Total'
 --- Actual STT
 union all
select region, branch_id, branch_name, year, month, week, channel, sub_channel, prodline,
  prodgrp, /*a.CRM,*/ sp_name,sp_id, /*sls_100,sls_200,*/ psub_id,depo,/*RetWhs,sls_type,*/
   sum(grs_amt) as grs_amt,  sum(net_qty) as net_qty, sum(net_amt) as net_amt,sum(rtn_amt) as rtn_amt,sum(grs_qty) as grs_qty,sum(rtn_qty) as rtn_qty,
 sum(disc_amt) as disc_amt, sum(Discount_B) as Discount_B, sum(Discount_PotTunai) as  Discount_PotTunai,sum(CustBuy) as CustBuy,0 as Tgt_qty
 from adventuresales_lower2019.dbo.Discount_cek_PSubId_withCB_weekly
  where sub_channel='GT'
  group by region, branch_id, branch_name, year, month, week, channel, sub_channel, prodline,
  prodgrp, sp_name,sp_id,psub_id,depo) as a
  group by prodgrp,region,branch_id,branch_name,sp_id,sp_name,depo,year,month,week
 --left outer join stockpoint c on a.sp_id=c.sp_id
 /*
  select *into customerdist_1910a_250304 from customerdist_1910a
  select *into slsman_250304 from slsman
  select *into product_svr55_250304 from product_svr55

  select *from qtr_wk_aop
  select * from qtrPct_AOP
  select * from SP_Pct_AOP25

  update qtrPct_AOP set pct=25
  select distinct prodgrp from qtrPct_AOP

  insert into qtrPct_AOP select 'IM-POUCH' as prodgrp,qtr,pct where prodgrp='KIDS'
  insert into qtrPct_AOP select 'CE-POUCH' as prodgrp,qtr,pct where prodgrp='KIDS'
  insert into qtrPct_AOP select 'IM-SM-POUCH' as prodgrp,qtr,pct where prodgrp='KIDS'
  insert into qtrPct_AOP select 'CE-SM-POUCH' as prodgrp,qtr,pct where prodgrp='KIDS'
  insert into qtrPct_AOP select 'TS-EVAP' as prodgrp,qtr,pct where prodgrp='KIDS'
  insert into qtrPct_AOP select 'STC189' as prodgrp,qtr,pct where prodgrp='KIDS'
  insert into qtrPct_AOP select 'UHT950' as prodgrp,qtr,pct where prodgrp='KIDS'
  insert into qtrPct_AOP select 'TS-SCH' as prodgrp,qtr,pct where prodgrp='KIDS'

  select type from v_SP_STT25_AOP25
 */








GO

