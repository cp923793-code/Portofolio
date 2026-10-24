USE [AdventureSales]
GO

/****** Object:  View [dbo].[sttmt_yoy]    Script Date: 6/4/2025 3:06:08 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



ALTER VIEW [dbo].[sttmt_yoy]
 AS
SELECT     branch_id,sp_id,custd_id,prod_id,sls_id,year,month,net_qty,net_amt FROM         sttmt_skm_yoy  
union all
SELECT     branch_id,sp_id,custd_id,prod_id,sls_id,year,month,net_qty,net_amt FROM         sttmt_kids_yoy
union all
SELECT     branch_id,sp_id,custd_id,prod_id,sls_id,year,month,net_qty,net_amt FROM         sttmt_sci_yoy 
union all
SELECT     branch_id,sp_id,custd_id,prod_id,sls_id,year,month,net_qty,net_amt FROM         sttmt_uhtoth_yoy
union all
 SELECT   branch_id,sp_id,custd_id,prod_id,sls_id,year,month,net_qty,net_amt FROM         sttmt_mk_yoy  
union all
SELECT     branch_id,sp_id,custd_id,prod_id,sls_id,year,month,net_qty,net_amt FROM         sttmt_sbob_yoy
union all
SELECT     branch_id,sp_id,custd_id,prod_id,sls_id,year,month,net_qty,net_amt FROM         sttmt_stc_yoy 
union all
SELECT    branch_id,sp_id,custd_id,prod_id,sls_id,year,month,net_qty,net_amt FROM         sttmt_skm  
union all
SELECT    branch_id,sp_id,custd_id,prod_id,sls_id,year,month,net_qty,net_amt FROM         sttmt_kids
union all
SELECT    branch_id,sp_id,custd_id,prod_id,sls_id,year,month,net_qty,net_amt FROM         sttmt_sci 
union all
SELECT    branch_id,sp_id,custd_id,prod_id,sls_id,year,month,net_qty,net_amt FROM         sttmt_uhtoth
union all
 SELECT   branch_id,sp_id,custd_id,prod_id,sls_id,year,month,net_qty,net_amt FROM         sttmt_mk  
union all
SELECT    branch_id,sp_id,custd_id,prod_id,sls_id,year,month,net_qty,net_amt FROM         sttmt_sbob
union all
SELECT    branch_id,sp_id,custd_id,prod_id,sls_id,year,month,net_qty,net_amt FROM         sttmt_stc 


GO

