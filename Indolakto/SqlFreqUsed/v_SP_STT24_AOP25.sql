USE [AdventureSales]
GO

/****** Object:  View [dbo].[v_SP_STT24_AOP25]    Script Date: 26/02/2025 18:19:23 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO










--select *from qtrPct_AOP


ALTER VIEW [dbo].[v_SP_STT24_AOP25]    
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
 */

select psub_id1 as ProdGrp,'Total' as Type,region,a.branch_id,branch_name,a.sp_id,a.sp_name,depo,sls_type2,2025 as year,c.mthwk as month,b.qtr,wk_num as week, 
 d.net_qty*b.pct/100/13*a.pct as Net_Qty
 from SP_Pct_AOP25 a 
 inner join qtrPct_AOP b on a.Psub_id1=b.Prodgrp 
 inner join qtr_wk_aop c on b.qtr=c.qtr 
 inner join v_yr25_aop25 d on a.Psub_id1=d.prodgrp
 left outer join stockpoint e on a.sp_id=e.sp_id
  where d.type='Total'
 
 union all
select psub_id1 as ProdGrp,'Total' as Type,region,a.branch_id,branch_name,a.sp_id,a.sp_name,depo,sls_type2,year,month,qtr,week, net_qty
 from adventuresales_lower2019.dbo.STT24_AOP25 a left outer join qtrtbl b on a.month=b.mth
 left outer join stockpoint c on a.sp_id=c.sp_id
 /*
  select *from qtr_wk_aop
  select * from qtrPct_AOP
  select * from SP_Pct_AOP25
  select distinct psub_id1 from SP_Pct_AOP25 order by psub_id1
    select distinct psub_id1 from SP_Pct_AOP25_wholeyr order by psub_id1

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


 */








GO

