USE [AdventureSales]
GO

/****** Object:  View [dbo].[v_Outlet_IMD_ytd]    Script Date: 5/13/2025 1:52:06 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



ALTER VIEW [dbo].[v_Outlet_IMD_ytd]
AS
select region, a.branch_id,branch_name,area, Depo, sp_name, a.custd_Name, a.custd_ID, '24-25' as year,channel,sub_channel,
 --net_qty,net_amt,Repeat, 
 Repeat,
 CASE WHEN Repeat <=10 then CAST(Repeat as varchar(2))  else '>10' end as RptGrp, 
 text_id as Psub_id,RetWhs
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
                      AS Repeat,   text_id  
FROM         sttwk1a_skm_FLY AS a LEFT OUTER JOIN
                      branch AS b ON a.branch_id = b.branch_id LEFT OUTER JOIN
                      customerdist_1910a AS c ON a.custd_id = c.kode_iap LEFT OUTER JOIN
					 stockpoint AS d ON a.sp_id = d.sp_id LEFT OUTER JOIN
                      product_svr55 AS g ON a.prod_id = g.prod_id
WHERE     net_qty>0 and ((year>=2024 and month>9) or (year=2025 and month<6)) and (text_id like 'IMD%') --and area in ('kalimantan','sulawesi')
GROUP BY region, a.branch_id,branch_name,area, Depo, a.sp_id,sp_name,custd_Name, a.custd_ID,text_id,channel,sub_channel,crm,retwhs
) as a

-- select *from product_svr55 where text_id like 'IMD%'
--select a.* from sttwk1a_skm_FLY a inner join product_svr55 b on a.prod_id=b.prod_id 
-- where text_id like 'IMD%'

--select distinct year,month from sttwk1a_skm
GO

