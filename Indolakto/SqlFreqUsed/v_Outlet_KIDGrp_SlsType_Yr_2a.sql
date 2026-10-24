USE [AdventureSales]
GO

/****** Object:  View [dbo].[v_Outlet_KIDGrp_SlsType_Yr_2a]    Script Date: 02/10/2024 19:59:43 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

create VIEW [dbo].[v_Outlet_KIDGrp_SlsType_Yr_2a]
AS
select region, a.branch_id,branch_name, Depo, sp_name, a.custd_Name, a.custd_ID, a.year,channel,sub_channel, 
 --net_qty,net_amt,Repeat, 
 Repeat,
 CASE WHEN Repeat <=10 then CAST(Repeat as varchar(2))  else '>10' end as RptGrp, 
 Psub_id,RetWhs,sls_type
 from
(

SELECT     TOP 100 PERCENT region, a.branch_id,branch_name, Depo, d.sp_name, custd_Name, a.custd_ID, '2024' as year,
					case when CRM='Y'
						then 'GT' else Channel 
						end as Channel,sub_channel,
                      case when CRM='Y'
						then 'CRM' else RetWhs
						end as  RetWhs,sls_type,
                      COUNT(DISTINCT a.week) 
                      AS Repeat,  g.udf1  as Psub_id
FROM         sttwk1a_kids AS a LEFT OUTER JOIN  -- select distinct year,week from sttwk1a_skm order by  year,week
                      branch AS b ON a.branch_id = b.branch_id LEFT OUTER JOIN
                      customerdist_1910a AS c ON a.custd_id = c.kode_iap LEFT OUTER JOIN
					 stockpoint AS d ON a.sp_id = d.sp_id LEFT OUTER JOIN
					 slsman AS e ON a.branch_id=e.branch_id and a.sp_id = e.sp_id and a.sls_id=e.sls_id LEFT OUTER JOIN
                      product_svr55 AS g ON a.prod_id = g.prod_id
WHERE     net_qty>0 /*and year=2022*/ and udf8  = 'KID'
GROUP BY region, a.branch_id,branch_name, Depo, a.sp_id,d.sp_name,custd_Name, a.custd_ID,/*year,*/ channel,sub_channel,crm,g.udf1,retwhs,sls_type
) as a

-- select *from productflav
-- select *from v_Outlet_KIDGrp_SlsType_Yr_2a






GO










GO

