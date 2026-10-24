USE [AdventureSales]
GO

/****** Object:  View [dbo].[v_SP_STT25_AOP25]    Script Date: 6/26/2025 1:39:20 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO











--select *from qtrPct_AOP


ALTER VIEW [dbo].[v_SP_STT25_AOP25]    
AS    
  -- select *from SP_Pct_AOP25
  -- select *from SP_Pct_AOP25 where psub_id1='KIDS' and pct> 0 order by pct desc
  -- select *from qtrPct_AOP
  --select *from v_yr25_aop25
  -- insert into qtrpct_aop select 'UHT950',qtr,pct from qtrpct_aop where prodgrp='im-sch'
  -- insert into qtrpct_aop select 'STC189',qtr,pct from qtrpct_aop where prodgrp='im-sch'
  -- insert into qtrpct_aop select 'TS-SCH',qtr,pct from qtrpct_aop where prodgrp='im-sch'
  -- insert into qtrpct_aop select 'TS-EVAP',qtr,pct from qtrpct_aop where prodgrp='im-sch'
  -- insert into qtrpct_aop select 'CE-POUCH',qtr,pct from qtrpct_aop where prodgrp='im-sch'
  -- insert into qtrpct_aop select 'IM-POUCH',qtr,pct from qtrpct_aop where prodgrp='im-sch'
  -- insert into qtrpct_aop select 'IM-SM-POUCH',qtr,pct from qtrpct_aop where prodgrp='im-sch'
  -- insert into qtrpct_aop select 'CE-SM-POUCH',qtr,pct from qtrpct_aop where prodgrp='im-sch'
/*
-- select *from sp_pct_aop25 
 insert into sp_pct_aop25 
 select 'CE-SM-POUCH',region,branch_id,branch_name,sp_id,sp_name,sls_type2,net_qty,pct,sum_qty
   from sp_pct_aop25 where psub_id1='CE-POUCH'

  select *from aop_pct
  select * from  SP_Pct_AOP25_WholeYr
 */
 -- Target
 select ProdGrp,region,branch_id,branch_name,sp_id,sp_name,depo, year, month, week, 
 sum(Tgt_Qty) as Tgt_qty, sum(Act_QTy) as Act_Qty,sum(LY_qty) as LY_qty from
 (
select psub_id1 as ProdGrp,region,a.branch_id,branch_name,a.sp_id,a.sp_name,depo,/*sls_type2,*/2025 as year, b.mth as month, week, 
 b.net_qty*a.pct*c.pct as Tgt_Qty,0 as Act_QTy,0 as LY_qty
 from SP_Pct_AOP25_WholeYr a 
  inner join AOP_2025_GT b on a.Psub_id1=b.psub_id 
  inner join aop_pct c on b.year=c.year and b.mth=c.mth
 --inner join qtr_wk_aop c on b.qtr=c.qtr 
 --inner join v_yr25_aop25 d on a.Psub_id1=d.prodgrp
 left outer join stockpoint e on a.sp_id=e.sp_id
 -- where d.type='Total'
 --- Actual STT
 union all
select a.psub_id1 as ProdGrp,region,a.branch_id,branch_name,a.sp_id,a.sp_name,depo,/*sls_type2*/year,month,/*qtr,*/week, 0 as Tgt_qty,sum(net_qty) as Act_qty,0 as LY_Qty
 from Complete_2years_Wk_Report_bySubChannel_All_Dtl_StockPoint a --left outer join qtrtbl b on a.month=b.mth
  inner join prodgrp_aop b on a.psub_id1=b.psub_id1
  where year=(select yr_num from begmonth) and sub_channel='GT'
  group by a.psub_id1,region,a.branch_id,branch_name,a.sp_id,a.sp_name,depo,year,month,week
 union all
select a.psub_id1 as ProdGrp,region,a.branch_id,branch_name,a.sp_id,a.sp_name,depo,/*sls_type2*/2025 as year,month,/*qtr,*/week, 0 as Tgt_qty,0 as Act_Qty,sum(net_qty) as LY_qty
 from Complete_2years_Wk_Report_bySubChannel_All_Dtl_StockPoint a --left outer join qtrtbl b on a.month=b.mth
  inner join prodgrp_aop b on a.psub_id1=b.psub_id1
  where year=(select yr_num-1 from begmonth) and sub_channel='GT'
  group by a.psub_id1,region,a.branch_id,branch_name,a.sp_id,a.sp_name,depo,month,week
  ) as a
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

