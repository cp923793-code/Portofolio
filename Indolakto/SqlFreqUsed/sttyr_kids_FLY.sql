USE [AdventureSales]
GO

/****** Object:  View [dbo].[sttyr_kids_FLY]    Script Date: 15/01/2025 10:57:59 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



ALTER VIEW [dbo].[sttyr_kids_FLY]
AS /*
SELECT    branch_id,sp_id,custd_id,prod_id,sls_id,year,net_qty,net_amt
FROM         mthkids.dbo.sttyr_kids where year=(select yr_num from begmonth)
 union all */
SELECT   * FROM
sttyr_kids --backup_2022a.dbo.sttyr_kids_2022  -- select distinct year from sttyr_kids
union all  
SELECT   * FROM       
sttyr_kids_2023 --backup_2022a.dbo.sttyr_kids_2022
union all
select *from sttyr_kids_2022
--union all
--select *from adventuresales_lower2019.dbo.sttyr_kids_2021

/*
select sum(net_qty) from sttwk_2024
select sum(net_qty) from sttyr_2021

*/

GO

