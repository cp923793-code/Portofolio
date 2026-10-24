USE [AdventureSales]
GO

/****** Object:  View [dbo].[v_Outlet_KIDGrp_SlsType_STT_1]    Script Date: 03/10/2024 12:37:19 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO





create VIEW [dbo].[v_Outlet_KIDGrp_SlsType_STT_1]
AS
select custd_Name, a.custd_ID,udf1,sls_type,
 sum(net_qty) as net_qty,sum(net_amt) as net_amt 
 from
 sttyr_kids AS a LEFT OUTER JOIN
   slsman AS b ON a.branch_id = b.branch_id and a.sp_id=b.sp_id and a.sls_id=b.sls_id LEFT OUTER JOIN
                      customerdist_1910a AS c ON a.custd_id = c.kode_iap --LEFT OUTER JOIN
						left outer join product_svr55 as d on a.prod_id=d.prod_id
                      --productFlav AS g ON a.prod_id = g.prod_id
WHERE     year>=2024 and udf8 = 'KID'
GROUP BY custd_Name, a.custd_ID,udf1,sls_type







GO

