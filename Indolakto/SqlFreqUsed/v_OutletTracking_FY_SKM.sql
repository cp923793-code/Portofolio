USE [AdventureSales]
GO

/****** Object:  View [dbo].[v_OutletTracking_FY1]    Script Date: 18/02/2025 12:23:19 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

alter VIEW [dbo].[v_OutletTracking_FY_SKM]
AS -- select distinct prodtype from product_svr55
SELECT     c.depo,a.custd_id, f.custd_name, f.channel,a.branch_id,
  d.prodtype,udf7 as product, a.year, a.month,week, branch_name,RetWhs,region,
 sub_channel, SUM(a.net_qty) AS net_qty
 --select year,week,sum(net_qty) from sttmttmp group by year,week order by year,week
--FROM        sttwk_2023 AS a LEFT OUTER JOIN -- sttwk_2023 AS a LEFT OUTER JOIN
 --FROM        sttwk_2023 AS a LEFT OUTER JOIN -- sttwk_2023 AS a LEFT OUTER JOIN
 --FROM        sttwk_2024a AS a LEFT OUTER JOIN -- sttwk_2023 AS a LEFT OUTER JOIN
 -- select distinct year,week from sttwk1b order by year,week
  FROM        sttwk1b AS a LEFT OUTER JOIN -- sttwk_2023 AS a LEFT OUTER JOIN
  -- FROM        sttwk_2024 AS a LEFT OUTER JOIN -- sttwk_2023 AS a LEFT OUTER JOIN
   --FROM        sttmttmp AS a LEFT OUTER JOIN -- sttwk_2023 AS a LEFT OUTER JOIN
                      dbo.Branch AS b ON a.branch_id = b.branch_id LEFT OUTER JOIN
                      dbo.stockpoint AS c ON a.sp_id = c.sp_id LEFT OUTER JOIN
                      dbo.product_SVR55 AS d ON a.prod_id = d.prod_id LEFT OUTER JOIN
                      dbo.customerdist_1910a AS f ON a.custd_id = f.kode_iap
 --left outer join slsman i on rtrim(a.branch_id)+'/'+rtrim(a.sp_id)+'/'+rtrim(a.sls_id)=i.Sls_id_Full
  where week<=(select cwk from begmonth) and prodtype='SKM' and (region like '%east%' or a.branch_id in ('5200/5219',
  '5200/5217','5200/5218')) and channel='GT'
  --where (month=(select mth from begmonth) and year=(select yr_num from begmonth)) or month between 10 and 12  
 --where year=(select yr_num from begmonth) --and month=(select mth-1 from begmonth)
GROUP BY  c.depo,a.custd_id, f.custd_name, f.channel,a.sls_id,
  d.prodtype,udf7,a.year, a.month,week,branch_name,RetWhs,a.branch_id,region,
 sub_channel



 /*
 --  select distinct branch_name  from slsexc_chlprn6 a inner join branch b on '5200/'+ substring(sp_id_org,1,4)=b.branch_id
 -- select *from sttmttmp
 -- select *from sttwk_2020 where branch_id like '5200/5203%'  --select *from branch where branch_name like '%baru%'
 drop table adventuresales_lower2019.dbo.v_OutletTracking_FY_SKM_tbl
 select *into adventuresales_lower2019.dbo.v_OutletTracking_FY_SKM_tbl
  from v_OutletTracking_FY_SKM---- where branch_name like 'surabaya%' and depo='madiun'


 */


















































GO

