USE [AdventureSales]
GO

/****** Object:  View [dbo].[v_sttwk1b_yr]    Script Date: 6/12/2025 10:45:03 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


alter VIEW [dbo].[v_sttwk1b_mt]
AS
 
SELECT     branch_id,sp_id,custd_id,prod_id,sls_id,year,month,sum(net_qty) as net_qty,
 sum(net_amt) as net_amt
FROM         sttwk1b --where week <=22--(select cwk from begmonth)
 group by branch_id,sp_id,custd_id,prod_id,sls_id,year,month
GO

