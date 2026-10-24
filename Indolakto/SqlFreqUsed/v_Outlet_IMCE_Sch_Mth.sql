USE [AdventureSales]
GO

/****** Object:  View [dbo].[v_Outlet_CEPouch_Mth]    Script Date: 13/03/2025 10:36:48 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

alter VIEW [dbo].[v_Outlet_IMCE_Sch_ytd]
AS
select region, a.branch_id,branch_name,area, Depo, sp_name, a.custd_Name, a.custd_ID, '24-25' as year,channel,sub_channel,
 --net_qty,net_amt,Repeat, 
 Repeat,
 CASE WHEN Repeat <=10 then CAST(Repeat as varchar(2))  else '>10' end as RptGrp, 
 Psub_id,RetWhs
 from
(
SELECT     TOP 100 PERCENT region, a.branch_id,branch_name,area, Depo, sp_name, custd_Name, a.custd_ID, 
					case when CRM='Y'
						then 'GT' else Channel 
						end as  Channel,sub_channel,
                      case when CRM='Y'
						then 'CRM' else RetWhs
						end as  RetWhs,
                      COUNT(DISTINCT a.week) 
                      AS Repeat,   Psub_id
FROM         sttwk1a_skm_FLY AS a LEFT OUTER JOIN
                      branch AS b ON a.branch_id = b.branch_id LEFT OUTER JOIN
                      customerdist_1910a AS c ON a.custd_id = c.kode_iap LEFT OUTER JOIN
					 stockpoint AS d ON a.sp_id = d.sp_id LEFT OUTER JOIN
                      productFlav AS g ON a.prod_id = g.prod_id
WHERE     net_qty>0 and ((year>=2024 and month>9) or (year=2025 and month<2)) and (psub_id like 'CE-SCH%' or psub_id like 'IM-SCH%') --and area in ('kalimantan','sulawesi')
GROUP BY region, a.branch_id,branch_name,area, Depo, a.sp_id,sp_name,custd_Name, a.custd_ID,psub_id,channel,sub_channel,crm,retwhs
) as a


--select distinct year,month from sttwk1a_skm
GO

