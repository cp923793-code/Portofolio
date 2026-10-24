USE [AdventureSales]
GO

/****** Object:  View [dbo].[v_Outlet_UHT180_SlsType_Mth]    Script Date: 03/10/2024 13:26:19 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

create VIEW [dbo].[v_Outlet_UHT180_SlsType_Mth]
AS
select region, a.branch_id,branch_name,depo,depo,depo,area, Depo, sp_name, a.custd_Name, a.custd_ID, a.year,month,week,channel,sub_channel,
 --net_qty,net_amt,Repeat, 
 Repeat,
 CASE WHEN Repeat <=5 then CAST(Repeat as varchar(2))  else '>5' end as RptGrp, 
 Psub_id,RetWhs,sls_type
 from
(
SELECT     TOP 100 PERCENT region, a.branch_id,branch_name,depo,depo,depo,area, Depo, d.sp_name, custd_Name, a.custd_ID,  year,month,week,
					case when CRM='Y'
						then 'GT' else Channel 
						end as  Channel,sub_channel,
                      case when CRM='Y'
						then 'CRM' else RetWhs
						end as  RetWhs,
                      COUNT(DISTINCT a.week) 
                      AS Repeat,   Psub_id,sls_type
FROM         sttwk1a_uhtoth AS a LEFT OUTER JOIN
                      branch AS b ON a.branch_id = b.branch_id LEFT OUTER JOIN
                      customerdist_1910a AS c ON a.custd_id = c.kode_iap LEFT OUTER JOIN
					 stockpoint AS d ON a.sp_id = d.sp_id LEFT OUTER JOIN
					 slsman AS e ON a.branch_id=e.branch_id and a.sp_id = e.sp_id and a.sls_id=e.sls_id LEFT OUTER JOIN
                      product_svr55 AS g ON a.prod_id = g.prod_id
WHERE     net_qty>0 /*and year,month,week=2022*/ and g.udf1 = 'UHT180' --and area in ('kalimantan','sulawesi')
GROUP BY region, a.branch_id,branch_name,depo,depo,depo,area, Depo, a.sp_id,d.sp_name,custd_Name, a.custd_ID,year,month,week,psub_id,channel,sub_channel,crm,retwhs,sls_type
) as a


--select distinct year,month,week from sttwk1a_skm
GO

