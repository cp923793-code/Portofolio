USE [AdventureSales]
GO

/****** Object:  View [dbo].[sttmt_stc_FLY]    Script Date: 15/01/2025 13:38:39 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


-- select distinct udf8,udf6 from product_svr55 where prodtype='Liquid' order by udf8,udf6
ALTER VIEW [dbo].[sttmt_stc_FLY]
AS       --- select distinct year from sttmt_stc
SELECT    * --branch_id,sp_id,custd_id,prod_id,sls_id,year,month, net_qty,net_amt
FROM         sttmt_stc --where year>=(select yr_num from begmonth)
 union all
select * from sttmt_stc_2023
 union all
select * from sttmt_stc_2022
--select year,sum(net_qty) from sttmt_stc_fly group by year
--select year,month,sum(net_qty) from sttmt_sci group by year,month
--select * into sttmt_sci from sttmt_sci
--select distinct year,month from sttmt_sci
--delete from sttmt_stc_2022 where year>2022
 



GO

