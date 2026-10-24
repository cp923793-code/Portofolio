USE [Repeat]
GO

/****** Object:  View [dbo].[v_Outlet_UHT180_STT_Qtr]    Script Date: 03/10/2024 13:31:56 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

alter VIEW [dbo].[v_Outlet_KidsProd_STT_FvMths]
AS  -- select sum(net_qty) from v_Outlet_KidsProd_STT_FvMths
select custd_Name, a.custd_ID, year,Qtr,sls_type,product as psub_id,
 sum(net_qty) as net_qty,sum(net_amt) as net_amt 
 from
 kids1.dbo.sttwk1a_kids AS a LEFT OUTER JOIN
    qtrtbl1 AS b ON a.month = b.mth LEFT OUTER JOIN
                      customerdist_1910a AS c ON a.custd_id = c.kode_iap LEFT OUTER JOIN
					  slsman AS d ON a.branch_id = d.branch_id and a.sp_id=d.sp_id and a.sls_id=d.sls_id LEFT OUTER JOIN
                       product_svr55 AS g ON a.prod_id = g.prod_id left outer join branch h on c.branch_id=h.branch_id
WHERE     year>=2024 and udf1 = 'KIDS' --and area in ('kalimantan','sulawesi')
GROUP BY custd_Name, a.custd_ID,year,Qtr,sls_type,product
/*
select *into repeat.dbo.QtrTbl1 from sales.dbo.qtrtbl
union all
SELECT     TOP 100 PERCENT region, a.branch_id,branch_name, Depo, sp_name, custd_Name, a.custd_ID, year,channel,sub_channel,crm,
                      SUM(a.net_qty) AS net_qty, SUM(a.net_amt) AS net_amt,  COUNT(DISTINCT a.week) 
                      AS Repeat,  text_id as Psub_id,'N' as S1, 'N' as S2
FROM         sttwk1a_Stc AS a LEFT OUTER JOIN
                      branch AS b ON a.branch_id = b.branch_id LEFT OUTER JOIN
                      customerdist_1910a AS c ON a.custd_id = c.kode_iap LEFT OUTER JOIN
					 stockpoint AS d ON a.sp_id = d.sp_id LEFT OUTER JOIN
                      productFlav AS g ON a.prod_id = g.prod_id
WHERE     net_qty>0 and year=2022 and psub_id like 'STC%'
GROUP BY region, a.branch_id,branch_name, Depo, a.sp_id,sp_name,custd_Name, a.custd_ID,year,channel,sub_channel,crm,crm,   
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

