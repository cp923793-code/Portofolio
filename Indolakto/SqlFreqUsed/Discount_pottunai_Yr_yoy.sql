USE [AdventureSales]
GO

/****** Object:  View [dbo].[Discount_pottunai_Yr_yoy]    Script Date: 6/17/2025 4:39:12 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO













ALTER VIEW [dbo].[Discount_pottunai_Yr_yoy]
AS
SELECT     branch_id,sp_id,custd_id, prod_id, sls_id, year, sum(disc_pottunai) as disc_pottunai 
FROM         discount_pottunai where week <=(select cwk from begmonth) group by branch_id,sp_id,custd_id, prod_id, sls_id,year










GO

