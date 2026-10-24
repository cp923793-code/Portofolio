USE [AdventureSales]
GO

/****** Object:  View [dbo].[Discount_B_Yr]    Script Date: 17/02/2025 11:16:38 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO












ALTER VIEW [dbo].[Discount_B_Yr]
AS
SELECT     branch_id,sp_id,custd_id, prod_id,sls_id,year, sum(disc_b_amt) as disc_b_amt 
FROM         discount_b group by branch_id,sp_id,custd_id, prod_id, sls_id,year











GO

