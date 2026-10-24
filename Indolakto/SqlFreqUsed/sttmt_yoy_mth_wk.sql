USE [AdventureSales]
GO

/****** Object:  View [dbo].[sttmt_yoy_wk]    Script Date: 19/11/2024 15:26:10 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



-- select year,sum(net_qty) from sttmt_yoy group by year

alter VIEW [dbo].[sttmt_yoy_mth_wk]
 AS
 
SELECT    branch_id,sp_id,custd_id,prod_id,sls_id,year,month,sum(net_qty) as net_qty--,net_amt 
  FROM         sttwk1b where month=(select mth from begmonth) and week<=(select cwk from begmonth)
   group by branch_id,sp_id,custd_id,prod_id,sls_id,year,month

   -- select year,month,sum(net_qty) from sttmt_yoy_mth_wk group by year,month
 




GO

