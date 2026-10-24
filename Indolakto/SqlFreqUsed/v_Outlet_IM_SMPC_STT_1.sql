USE [AdventureSales]
GO

/****** Object:  View [dbo].[v_Outlet_IM_SMPC_STT_1]    Script Date: 4/29/2025 12:56:19 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



ALTER VIEW [dbo].[v_Outlet_IM_SMPC_STT_1]
AS
select custd_Name, a.custd_ID,product,
 sum(net_qty) as net_qty,sum(net_amt) as net_amt 
 from
 sttyr_skm AS a LEFT OUTER JOIN
                      customerdist_1910a AS c ON a.custd_id = c.kode_iap --LEFT OUTER JOIN
						left outer join product_svr55 as d on a.prod_id=d.prod_id
                      --productFlav AS g ON a.prod_id = g.prod_id
WHERE     year>=2024 and text_id like '%260%'
GROUP BY custd_Name, a.custd_ID,product




GO

