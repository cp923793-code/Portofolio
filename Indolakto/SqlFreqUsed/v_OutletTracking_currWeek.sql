USE [AdventureSales]
GO

/****** Object:  View [dbo].[v_OutletTracking]    Script Date: 27/02/2025 14:37:37 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


create VIEW [dbo].[v_OutletTracking_currWeek]
AS
SELECT     a.sp_id, c.depo,c.sp_name, a.custd_id, f.custd_name, f.channel, i.sls_type, i.sls_name,sls_spv,
 e.ProdSubBr AS prodgroup, d.psub_id, brand,d.text_id, prod_name,a.year, a.month, week,branch_name,f.address_1,RetWhs,
 sub_channel,type_outlet1, case when crm='Y' then 'Y' else 'N' end as CRM,a.sls_id,
 SUM(a.net_qty) AS net_qty,
 SUM(a.net_amt) AS net_amt
FROM         sttwktmp1a AS a LEFT OUTER JOIN
                      dbo.Branch AS b ON a.branch_id = b.branch_id LEFT OUTER JOIN
                      dbo.stockpoint AS c ON a.sp_id = c.sp_id LEFT OUTER JOIN
                      dbo.product_svr55 AS d ON a.prod_id = d.prod_id LEFT OUTER JOIN
                      dbo.ILO_PrdAlias AS e ON d.text_id = e.Product LEFT OUTER JOIN
                      dbo.customerdist_1910a AS f ON a.custd_id = f.kode_iap
 left outer join slsman i on rtrim(a.branch_id)+'/'+rtrim(a.sp_id)+'/'+rtrim(a.sls_id)=i.Sls_id_Full
      
 where year=(select yr_num from begmonth)
GROUP BY  a.sp_id, c.depo,c.sp_name, a.custd_id, f.custd_name, f.channel, i.sls_type, i.sls_name,sls_spv,
 e.ProdSubBr , d.psub_id, brand,d.text_id, prod_name,a.year, a.month,week,branch_name,f.address_1,RetWhs,
 sub_channel,type_outlet1,crm,a.sls_id


--drop table sales2.dbo.v_OutletTracking_Plb_tbl
--select * into sales2.dbo.v_OutletTracking_Plb_tbl from v_OutletTracking_Plb

--select distinct year,week from sttwk1a1_22 order by year,week
--select *from branch where branch_name like 'palemb%'


GO

