USE [AdventureSales]
GO

/****** Object:  View [dbo].[v_RemainQty_AOP]    Script Date: 6/26/2025 1:07:24 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO






--select *from qtrtbl
-- select *from v_STT_Psub_Id1_AOP24
ALTER VIEW [dbo].[v_RemainQty_AOP]    
AS    
  
-- LE
select a.prodgrp,a.type,a.qty,b.net_qty,a.qty-b.net_qty as RmnQty from LE_Psub_id1 a
 inner join
-- YTD STT
(select a.PSub_id1,sum(net_qty) as net_qty
 from Complete_2years_Wk_Report_bySubChannel_All_Dtl_StockPoint a
  inner join ProdGrp_AOP b on a.psub_id1=b.psub_id1
  where year=(select yr_num from begmonth) and week<=39 and sub_channel in ('GT','IFS')
  group by a.psub_id1) as b on a.prodgrp=b.psub_id1
 -- order by prodgrp
 --select sum(net_qty) from v_YR24_AOP24
 -- select *from rrwk_aop24
 -- select *from prodgrp_aop













GO

