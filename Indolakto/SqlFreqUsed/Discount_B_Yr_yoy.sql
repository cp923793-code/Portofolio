USE [AdventureSales]
GO

/****** Object:  View [dbo].[Discount_B_Yr_yoy]    Script Date: 6/17/2025 4:39:55 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO












ALTER VIEW [dbo].[Discount_B_Yr_yoy]
AS
SELECT     branch_id,sp_id,custd_id, prod_id,sls_id,year, sum(disc_b_amt) as disc_b_amt 
FROM         discount_b where week<= (select cwk from begmonth) group by branch_id,sp_id,custd_id, prod_id,sls_id, year










GO

