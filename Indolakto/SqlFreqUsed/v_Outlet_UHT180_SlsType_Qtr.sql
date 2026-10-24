USE [AdventureSales]
GO

/****** Object:  View [dbo].[v_Outlet_UHT180_Qtr]    Script Date: 04/10/2024 22:59:13 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


create VIEW [dbo].[v_Outlet_UHT180_SlsType_Qtr]  -- select *from v_Outlet_UHT180_Qtr_tbl
AS
select region, a.branch_id,branch_name,area, Depo, sp_name, a.custd_Name, a.custd_ID, a.year,qtr,channel,sub_channel,
 --net_qty,net_amt,Repeat, 
 -- select * from qtrtbl
 Repeat,
 CASE WHEN Repeat <=10 then CAST(Repeat as varchar(2))  else '>10' end as RptGrp, 
 Psub_id,RetWhs,sls_type
 from
(
SELECT     TOP 100 PERCENT region, a.branch_id,branch_name,area, Depo, d.sp_name, custd_Name, a.custd_ID,  year,Qtr,
					case when CRM='Y'
						then 'GT' else Channel 
						end as  Channel,sub_channel,
                      case when CRM='Y'
						then 'CRM' else RetWhs
						end as  RetWhs,
                      COUNT(DISTINCT a.week) 
                      AS Repeat,  g.udf1 as  Psub_id,sls_type
FROM         sttwk1a_uhtoth AS a LEFT OUTER JOIN
                      branch AS b ON a.branch_id = b.branch_id LEFT OUTER JOIN
                      customerdist_1910a AS c ON a.custd_id = c.kode_iap LEFT OUTER JOIN
					 stockpoint AS d ON a.sp_id = d.sp_id LEFT OUTER JOIN
					  qtrTbl as e on a.month=e.mth left outer join
                    slsman AS f ON a.branch_id=f.branch_id and a.sp_id = f.sp_id and a.sls_id=f.sls_id LEFT OUTER JOIN
                      product_svr55 AS g ON a.prod_id = g.prod_id -- select *from product_svr55 where udf1='UHT180' order by text_id
WHERE     net_qty>0 /*and year,month=2022*/ and g.udf1 = 'UHT180' --and area in ('kalimantan','sulawesi')
GROUP BY region, a.branch_id,branch_name,area, Depo, a.sp_id,d.sp_name,custd_Name, a.custd_ID,year,qtr,g.udf1,channel,sub_channel,crm,retwhs,sls_type
) as a


--select distinct year,month from sttwk1a_skm

GO

