USE [AdventureSales]
GO

/****** Object:  View [dbo].[v_Outlet_UHT180_Qtr]    Script Date: 03/10/2024 13:26:19 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

alter VIEW [dbo].[v_Outlet_UHT180_Qtr]
AS
select region, a.branch_id,branch_name,area, Depo, sp_name, a.custd_Name, a.custd_ID, a.year,channel,sub_channel,
 --net_qty,net_amt,Repeat, 
 -- select * from qtrtbl
 Repeat,
 CASE WHEN Repeat <=10 then CAST(Repeat as varchar(2))  else '>10' end as RptGrp, 
 CASE WHEN month between 1 and 3 then 1  
   WHEN month between 4 and 6 then 2 else 3 end as Qtr,
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
                      AS Repeat,  g.udf1 as  Psub_id
FROM         sttwk1a_uhtoth AS a LEFT OUTER JOIN
                      branch AS b ON a.branch_id = b.branch_id LEFT OUTER JOIN
                      customerdist_1910a AS c ON a.custd_id = c.kode_iap LEFT OUTER JOIN
					 stockpoint AS d ON a.sp_id = d.sp_id LEFT OUTER JOIN
                      product_svr55 AS g ON a.prod_id = g.prod_id -- select *from product_svr55 where udf1='UHT180' order by text_id
WHERE     net_qty>0 /*and year,month=2022*/ and g.udf1 = 'UHT180' --and area in ('kalimantan','sulawesi')
GROUP BY region, a.branch_id,branch_name,area, Depo, a.sp_id,sp_name,custd_Name, a.custd_ID,year,month,g.udf1,channel,sub_channel,crm,retwhs
) as a


--select distinct year,month from sttwk1a_skm
GO

