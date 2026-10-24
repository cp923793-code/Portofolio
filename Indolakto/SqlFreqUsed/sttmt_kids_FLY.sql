USE [AdventureSales]
GO

/****** Object:  View [dbo].[sttmt_kids_FLY]    Script Date: 14/01/2025 18:10:17 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO




ALTER VIEW [dbo].[sttmt_kids_FLY]
AS
SELECT    branch_id,sp_id,custd_id,prod_id,sls_id,year,month,net_qty,net_amt,grs_qty,grs_amt,rtn_qty,rtn_amt
FROM         sttmt_kids_2022
 union all
SELECT    branch_id,sp_id,custd_id,prod_id,sls_id,year,month,net_qty,net_amt,grs_qty,grs_amt,rtn_qty,rtn_amt
FROM         sttmt_kids_2023
 union all
SELECT    branch_id,sp_id,custd_id,prod_id,sls_id,year,month,net_qty,net_amt,grs_qty,grs_amt,rtn_qty,rtn_amt
FROM         sttmt_kids -- select distinct year,month from sttmt_kids order by year,month
-- union all
--SELECT    branch_id,sp_id,custd_id,prod_id,sls_id,year,month,net_qty,net_amt
-- FROM         adventuresales_lower2019.dbo.sttmt_kids_2021
--select year,sum(net_qty) from sttmt_kids_fly group by year
--select year,month,sum(net_qty) from sttmt_kids group by year,month
--delete from sttmt_kids where year<2023
--delete from sttmt_kids_2022 where year>2022




GO

