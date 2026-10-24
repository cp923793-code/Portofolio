USE [AdventureSales]
GO

/****** Object:  View [dbo].[sttyr_fly]    Script Date: 30/01/2025 15:14:13 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO





ALTER VIEW [dbo].[sttyr_fly]
 AS
SELECT    branch_id,sp_id,custd_id,prod_id,sls_id,year,net_qty,net_amt FROM         sttyr_skm_fly  
union all
SELECT    branch_id,sp_id,custd_id,prod_id,sls_id,year,net_qty,net_amt FROM         sttyr_kids_fly  
union all
SELECT    branch_id,sp_id,custd_id,prod_id,sls_id,year,net_qty,net_amt FROM         sttyr_sci_fly   
union all
SELECT    branch_id,sp_id,custd_id,prod_id,sls_id,year,net_qty,net_amt FROM         sttyr_uhtoth_fly  
union all
 SELECT   branch_id,sp_id,custd_id,prod_id,sls_id,year,net_qty,net_amt FROM         sttyr_mk_fly    
union all
SELECT    branch_id,sp_id,custd_id,prod_id,sls_id,year,net_qty,net_amt FROM         sttyr_sbob_fly  
union all
SELECT    branch_id,sp_id,custd_id,prod_id,sls_id,year,net_qty,net_amt FROM         sttyr_stc_fly   

-- select   year,sum(net_qty) from sttyr_fly where year>2022 group by year order by year



GO

