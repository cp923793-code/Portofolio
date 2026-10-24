SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

-- drop procedure sp_CreateWeeklyReport_Dtl_StockPoint_DiscB_NoDrop
alter  PROCEDURE [dbo].[sp_InsertYearlyReport]  AS  -- 2 minutes
 

insert  into Yearly_Report_bySubChannel
select f.region,a.branch_id,f.branch_name,a.year,
  c.channel,sub_channel,prodLine,prodgrp,d.udf6 as psub_id,--g.depo,g.sp_name,g.sp_id,a.custd_id,custd_name,
 d.text_id,product,/*TypeOutlet,*/d.udf1 as psub_id1,
 convert(dec(17,5),sum(a.net_qty)) as net_qty,convert(dec(17,5),sum(a.net_amt)) as net_amt  --,
    from sttyr_18_yoy a  
 
 left outer join customerdist_1910a c on a.custd_id=c.kode_iap
 left outer join product_svr55 d on a.prod_id=d.prod_id
 left outer join prodcat e on d.psub_id=e.psub_id
 left outer join branch f on a.branch_id=f.branch_id
  
 group by f.region,a.branch_id,f.branch_name,a.year, -- g.depo,g.sp_name,g.sp_id,crm,chiller,
 --a.custd_id,custd_name,
 c.channel,sub_channel,prodLine,prodgrp,d.udf6,d.text_id,product,a.custd_id,d.udf1
 
-- select year,sum(net_qty) from Yearly_Report_bySubChannel group by year


GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

