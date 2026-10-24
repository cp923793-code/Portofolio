USE [AdventureSales]
GO

/****** Object:  View [dbo].[Discount_pottunai_Yr]    Script Date: 17/02/2025 11:17:15 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO











ALTER VIEW [dbo].[Discount_pottunai_Yr]
AS
SELECT     branch_id,sp_id,custd_id, prod_id, sls_id,year, sum(disc_pottunai) as disc_pottunai 
FROM         discount_pottunai group by branch_id,sp_id,custd_id, prod_id, sls_id,year










GO

