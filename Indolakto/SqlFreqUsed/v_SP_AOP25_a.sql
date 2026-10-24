create VIEW [dbo].[v_SP_AOP25]    
AS    
  
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
  /*

  select * from v_SP_AOP25
 */








GO

