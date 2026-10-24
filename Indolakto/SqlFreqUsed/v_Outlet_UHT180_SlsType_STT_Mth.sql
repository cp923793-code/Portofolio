USE [AdventureSales]
GO

/****** Object:  View [dbo].[v_Outlet_UHT180_STT_Mth]    Script Date: 03/10/2024 13:31:56 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

create VIEW [dbo].[v_Outlet_UHT180_SlsType_STT_Mth]
AS
select custd_Name, a.custd_ID, year,month,week,sls_type,
 sum(net_qty) as net_qty,sum(net_amt) as net_amt 
 from
 sttmt_uhtoth AS a LEFT OUTER JOIN
  slsman AS b ON a.branch_id = b.branch_id and a.sp_id=b.sp_id and a.sls_id=b.sls_id LEFT OUTER JOIN
                      customerdist_1910a AS c ON a.custd_id = c.kode_iap LEFT OUTER JOIN
                       product_svr55 AS g ON a.prod_id = g.prod_id left outer join branch h on c.branch_id=h.branch_id
WHERE     year>=2024 and udf1 = 'UHT180' --and area in ('kalimantan','sulawesi')
GROUP BY custd_Name, a.custd_ID,year,month,week,sls_type
/*
union all
SELECT     TOP 100 PERCENT region, a.branch_id,branch_name,depo,depo,depo, Depo, sp_name, custd_Name, a.custd_ID, year,channel,sub_channel,crm,
                      SUM(a.net_qty) AS net_qty, SUM(a.net_amt) AS net_amt,  COUNT(DISTINCT a.week) 
                      AS Repeat,  text_id as Psub_id,'N' as S1, 'N' as S2
FROM         sttwk1a_Stc AS a LEFT OUTER JOIN
                      branch AS b ON a.branch_id = b.branch_id LEFT OUTER JOIN
                      customerdist_1910a AS c ON a.custd_id = c.kode_iap LEFT OUTER JOIN
					 stockpoint AS d ON a.sp_id = d.sp_id LEFT OUTER JOIN
                      productFlav AS g ON a.prod_id = g.prod_id
WHERE     net_qty>0 and year=2022 and psub_id like 'STC%'
GROUP BY region, a.branch_id,branch_name,depo,depo,depo, Depo, a.sp_id,sp_name,custd_Name, a.custd_ID,year,channel,sub_channel,crm,crm,   
                      text_id
*/
 


/*
drop table v_Outlet_STC_Uht180_Yr_tbl
select * into v_Outlet_STC_Uht180_Yr_tbl 
 from v_Outlet_STC_Uht180_Yr_1

*/

--select *from product where psub_id like 'UHT190%'

--select *from v_Outlet_STC_Uht180_Yr_tbl
GO

