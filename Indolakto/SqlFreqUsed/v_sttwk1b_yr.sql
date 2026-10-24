USE [AdventureSales]
GO

/****** Object:  View [dbo].[v_sttwk1b_yr]    Script Date: 6/20/2025 8:08:51 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO





ALTER VIEW [dbo].[v_sttwk1b_yr]
AS
 
SELECT     branch_id,sp_id,custd_id,prod_id,sls_id,year,sum(net_qty) as net_qty,
 sum(net_amt) as net_amt,sum(grs_amt) as grs_amt,sum(rtn_amt) as rtn_amt
FROM         sttwk1b where week <=(select cwk from begmonth)  --22 hardcode here
 group by branch_id,sp_id,custd_id,prod_id,sls_id,year
GO

