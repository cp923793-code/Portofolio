USE [AdventureSales]
GO

/****** Object:  View [dbo].[sttmt_skm_FLY]    Script Date: 4/24/2025 11:45:07 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO






create VIEW [dbo].[sttyr_skm_yoy_Mar]
AS
/*
SELECT     branch_id,sp_id,custd_id,prod_id,sls_id,year,month,net_qty,net_amt
FROM         sttmt_skm where year=(select yr_num from begmonth)
 union all 
SELECT     branch_id,sp_id,custd_id,prod_id,sls_id,year,month,net_qty,net_amt,grs_qty, grs_amt,rtn_qty, rtn_amt
FROM         sttmt_skm_2022
union all */
SELECT     branch_id,sp_id,custd_id,prod_id,sls_id,year,
 sum(net_qty) as net_qty--,net_amt,grs_qty, grs_amt,rtn_qty, rtn_amt
FROM         sttmt_skm_fly
 where month<=3
 group by branch_id,sp_id,custd_id,prod_id,sls_id,year
 
GO

