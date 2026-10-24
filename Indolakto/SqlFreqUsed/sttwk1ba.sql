USE [AdventureSales]
GO

/****** Object:  View [dbo].[sttwk1b]    Script Date: 08/12/2025 16:52:24 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



CREATE VIEW [dbo].[sttwk1b]
AS

select branch_id,sp_id,custd_id,prod_id,sls_id,CAST(year AS numeric(4, 0)) AS year,
 month,CAST(week AS numeric(2, 0)) AS week,net_qty,net_amt,grs_qty,grs_amt,rtn_qty,rtn_amt,CAST(year AS numeric(4, 0)) * 100 + CAST(week AS numeric(2, 0)) AS year_week_int
 from sttwk_2022a.dbo.sttwk
 /*
  union all
 select branch_id,sp_id,custd_id,prod_id,sls_id,CAST(year AS numeric(4, 0)) AS year,
 month,CAST(week AS numeric(2, 0)) AS week,net_qty,net_amt,grs_qty,grs_amt,rtn_qty,rtn_amt,CAST(year AS numeric(4, 0)) * 100 + CAST(week AS numeric(2, 0)) AS year_week_int
 from sttwk_2022b.dbo.sttwk
  union all
 select branch_id,sp_id,custd_id,prod_id,sls_id,CAST(year AS numeric(4, 0)) AS year,
 month,CAST(week AS numeric(2, 0)) AS week,net_qty,net_amt,grs_qty,grs_amt,rtn_qty,rtn_amt,CAST(year AS numeric(4, 0)) * 100 + CAST(week AS numeric(2, 0)) AS year_week_int
 from sttwk_2022c.dbo.sttwk
   union all
 select branch_id,sp_id,custd_id,prod_id,sls_id,CAST(year AS numeric(4, 0)) AS year,
 month,CAST(week AS numeric(2, 0)) AS week,net_qty,net_amt,grs_qty,grs_amt,rtn_qty,rtn_amt,CAST(year AS numeric(4, 0)) * 100 + CAST(week AS numeric(2, 0)) AS year_week_int
 from sttwk_2022d.dbo.sttwk

 union all
 select branch_id,sp_id,custd_id,prod_id,sls_id,CAST(year AS numeric(4, 0)) AS year,
 month,CAST(week AS numeric(2, 0)) AS week,net_qty,net_amt,grs_qty,grs_amt,rtn_qty,rtn_amt,CAST(year AS numeric(4, 0)) * 100 + CAST(week AS numeric(2, 0)) AS year_week_int
 from sttwk_2023a.dbo.sttwk
  union all
 select branch_id,sp_id,custd_id,prod_id,sls_id,CAST(year AS numeric(4, 0)) AS year,
 month,CAST(week AS numeric(2, 0)) AS week,net_qty,net_amt,grs_qty,grs_amt,rtn_qty,rtn_amt,CAST(year AS numeric(4, 0)) * 100 + CAST(week AS numeric(2, 0)) AS year_week_int
 from sttwk_2023b.dbo.sttwk
  union all
 select branch_id,sp_id,custd_id,prod_id,sls_id,CAST(year AS numeric(4, 0)) AS year,
 month,CAST(week AS numeric(2, 0)) AS week,net_qty,net_amt,grs_qty,grs_amt,rtn_qty,rtn_amt,CAST(year AS numeric(4, 0)) * 100 + CAST(week AS numeric(2, 0)) AS year_week_int
 from sttwk_2023c.dbo.sttwk
   union all
 select branch_id,sp_id,custd_id,prod_id,sls_id,CAST(year AS numeric(4, 0)) AS year,
 month,CAST(week AS numeric(2, 0)) AS week,net_qty,net_amt,grs_qty,grs_amt,rtn_qty,rtn_amt,CAST(year AS numeric(4, 0)) * 100 + CAST(week AS numeric(2, 0)) AS year_week_int
 from sttwk_2023d.dbo.sttwk
 
  union all
  select branch_id,sp_id,custd_id,prod_id,sls_id,CAST(year AS numeric(4, 0)) AS year,
 month,CAST(week AS numeric(2, 0)) AS week,net_qty,net_amt,grs_qty,grs_amt,rtn_qty,rtn_amt,CAST(year AS numeric(4, 0)) * 100 + CAST(week AS numeric(2, 0)) AS year_week_int
 from sttwk_2024a.dbo.sttwk
  union all
 select branch_id,sp_id,custd_id,prod_id,sls_id,CAST(year AS numeric(4, 0)) AS year,
 month,CAST(week AS numeric(2, 0)) AS week,net_qty,net_amt,grs_qty,grs_amt,rtn_qty,rtn_amt,CAST(year AS numeric(4, 0)) * 100 + CAST(week AS numeric(2, 0)) AS year_week_int
 from sttwk_2024b.dbo.sttwk
  union all
 select branch_id,sp_id,custd_id,prod_id,sls_id,CAST(year AS numeric(4, 0)) AS year,
 month,CAST(week AS numeric(2, 0)) AS week,net_qty,net_amt,grs_qty,grs_amt,rtn_qty,rtn_amt,CAST(year AS numeric(4, 0)) * 100 + CAST(week AS numeric(2, 0)) AS year_week_int
 from sttwk_2024c.dbo.sttwk
   union all
 select branch_id,sp_id,custd_id,prod_id,sls_id,CAST(year AS numeric(4, 0)) AS year,
 month,CAST(week AS numeric(2, 0)) AS week,net_qty,net_amt,grs_qty,grs_amt,rtn_qty,rtn_amt,CAST(year AS numeric(4, 0)) * 100 + CAST(week AS numeric(2, 0)) AS year_week_int
 from sttwk_2024d.dbo.sttwk
 
  union all
 select branch_id,sp_id,custd_id,prod_id,sls_id,CAST(year AS numeric(4, 0)) AS year,
 month,CAST(week AS numeric(2, 0)) AS week,net_qty,net_amt,grs_qty,grs_amt,rtn_qty,rtn_amt,CAST(year AS numeric(4, 0)) * 100 + CAST(week AS numeric(2, 0)) AS year_week_int
 from sttwk_2025a.dbo.sttwk
  union all
 select branch_id,sp_id,custd_id,prod_id,sls_id,CAST(year AS numeric(4, 0)) AS year,
 month,CAST(week AS numeric(2, 0)) AS week,net_qty,net_amt,grs_qty,grs_amt,rtn_qty,rtn_amt,CAST(year AS numeric(4, 0)) * 100 + CAST(week AS numeric(2, 0)) AS year_week_int
 from sttwk_2025b.dbo.sttwk
 
 */
 
GO

