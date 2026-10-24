USE [sttwk_2022a]
GO

/****** Object:  View [dbo].[v_sttwk_2022]    Script Date: 01/12/2025 12:09:15 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


-- select *from sales.dbo.product where prod_id='000000000000106853'


create VIEW [dbo].[v_sttwk_2022a]
AS
SELECT branch_id,sp_id,custd_id,prod_id,sls_id,year as yr,
month as mth,week as wk,net_qty,net_amt,grs_qty,grs_amt
,rtn_qty,rtn_amt FROM   sttwk_2022a.dbo.sttwk

-- select yr,wk, sum(net_amt) as net_amt from v_sttwk_2022a group by yr,wk order by yr,wk


