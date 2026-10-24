USE [AdventureSales]
GO

/****** Object:  View [dbo].[v_Outlet_UHT180_Mth]    Script Date: 03/10/2024 13:26:19 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

create VIEW [dbo].[v_Outlet_UHT180_Mth]
AS
select region, a.branch_id,branch_name,area, Depo, sp_name, a.custd_Name, a.custd_ID, a.year,month,channel,sub_channel,
 --net_qty,net_amt,Repeat, 
 Repeat,
 CASE WHEN Repeat <=5 then CAST(Repeat as varchar(2))  else '>5' end as RptGrp, 
 Psub_id,RetWhs
 from
(
SELECT     TOP 100 PERCENT region, a.branch_id,branch_name,area, Depo, sp_name, custd_Name, a.custd_ID,  year,month,
					case when CRM='Y'
						then 'GT' else Channel 
						end as  Channel,sub_channel,
                      case when CRM='Y'
						then 'CRM' else RetWhs
						end as  RetWhs,
                      COUNT(DISTINCT a.week) 
                      AS Repeat,   Psub_id
FROM         sttwk1a_uhtoth AS a LEFT OUTER JOIN
                      branch AS b ON a.branch_id = b.branch_id LEFT OUTER JOIN
                      customerdist_1910a AS c ON a.custd_id = c.kode_iap LEFT OUTER JOIN
					 stockpoint AS d ON a.sp_id = d.sp_id LEFT OUTER JOIN
                      productFlav AS g ON a.prod_id = g.prod_id
WHERE     net_qty>0 /*and year,month=2022*/ and udf1 = 'UHT180' --and area in ('kalimantan','sulawesi')
GROUP BY region, a.branch_id,branch_name,area, Depo, a.sp_id,sp_name,custd_Name, a.custd_ID,year,month,psub_id,channel,sub_channel,crm,retwhs
) as a


--select distinct year,month from sttwk1a_skm
GO

