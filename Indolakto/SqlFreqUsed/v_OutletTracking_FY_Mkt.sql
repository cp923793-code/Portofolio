USE [AdventureSales]
GO

/****** Object:  View [dbo].[v_OutletTracking_FY_Mkt]    Script Date: 24/09/2024 10:26:56 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


ALTER VIEW [dbo].[v_OutletTracking_FY_Mkt]
AS
SELECT     a.sp_id, c.depo,c.sp_name, a.custd_id, f.custd_name, f.channel, i.sls_type, i.sls_name,a.sls_id,a.branch_id,
 /*e.ProdSubBr AS prodgroup,*/ udf6 as psub_id, udf7 as product, brand,d.text_id, prod_name,a.year, a.month, week,branch_name,f.address_1,RetWhs,
 sls_spv,type_outlet1,sub_channel,mkt_id,mkt_name,
 case when mkt='Y' then 'Y' else 'N' end as mkt,
 case when crm='Y' then 'Y' else 'N' end as crm,
 case when sls_type='Exclusive Indolakto' then 'Y' else 'N' end as Sls_200,
 case when chiller='Y' then 'Y' else 'N' end as Chiller,
 case when h.kode_iap<>'' then 'Y' else 'N' end as Chl_24,
 SUM(a.net_qty) AS net_qty, SUM(a.net_amt) AS net_amt
 --select year,week,sum(net_qty) from sttmttmp group by year,week order by year,week
--FROM        sttwk_2023 AS a LEFT OUTER JOIN -- sttwk_2023 AS a LEFT OUTER JOIN
 --FROM        sttwk_2023 AS a LEFT OUTER JOIN -- sttwk_2023 AS a LEFT OUTER JOIN
 --FROM        sttwk_2024a AS a LEFT OUTER JOIN -- sttwk_2023 AS a LEFT OUTER JOIN
 -- select distinct year,week from sttwk1b order by year,week
  FROM        sttwk1b AS a LEFT OUTER JOIN -- sttwk_2023 AS a LEFT OUTER JOIN
  -- FROM        sttwk_2024 AS a LEFT OUTER JOIN -- sttwk_2023 AS a LEFT OUTER JOIN
  -- FROM        sttmttmp AS a LEFT OUTER JOIN -- sttwk_2023 AS a LEFT OUTER JOIN
                      dbo.Branch AS b ON a.branch_id = b.branch_id LEFT OUTER JOIN
                      dbo.stockpoint AS c ON a.sp_id = c.sp_id LEFT OUTER JOIN
                      dbo.product_SVR55 AS d ON a.prod_id = d.prod_id LEFT OUTER JOIN
                     -- dbo.ILO_PrdAlias AS e ON d.text_id = e.Product LEFT OUTER JOIN
                      dbo.customerdist_1910a AS f ON a.custd_id = f.kode_iap
 left outer join slsman i on rtrim(a.branch_id)+'/'+rtrim(a.sp_id)+'/'+rtrim(a.sls_id)=i.Sls_id_Full
   left outer join custmkttmp g on a.custd_id=g.custd_id
      left outer join chiller_2024 h on a.custd_id=h.kode_iap
  --where week<27
  --where (month=(select mth from begmonth) and year=(select yr_num from begmonth)) or month between 10 and 12  
 --where year=(select yr_num from begmonth) --and month=(select mth-1 from begmonth)
GROUP BY  a.sp_id, c.depo,c.sp_name, a.custd_id, f.custd_name, f.channel, i.sls_type, i.sls_name,a.sls_id,
/*( e.ProdSubBr*/  udf6, udf7,brand,d.text_id, prod_name,a.year, a.month,week,branch_name,f.address_1,RetWhs,a.branch_id,
 sls_spv,type_outlet1,sub_channel,mkt_id,mkt_name,mkt,crm,chiller,h.kode_iap



 /*
 --  select distinct branch_name  from slsexc_chlprn6 a inner join branch b on '5200/'+ substring(sp_id_org,1,4)=b.branch_id
 -- select distinct udf6,udf7 from product_svr55
 -- select *from sttwk_2020 where branch_id like '5200/5203%'  --select *from branch where branch_name like '%baru%'
 drop table adventuresales_lower2019.dbo.v_OutletTracking_Mkt_jkt3_FY_tbl
 select *into adventuresales_lower2019.dbo.v_OutletTracking_FY_tbl 
  from v_OutletTracking_FY_Mkt where branch_name like 'jakarta 3%' and depo='madiun'

  select *from customerdist_1910a where kode_iap like '%980503%' or custd_name like '%raudhatul%' order by kode_iap


  drop table adventuresales_lower2019.dbo.v_SCMa_Strata_sum_tbl_mrg_bdg
 SELECT * into  adventuresales_lower2019.dbo.v_SCMa_Strata_sum_tbl_mrg_bdg
  FROM adventuresales_lower2019.dbo.v_SCMa_Strata_sum_tbl_mrg
   where branch_name='bandung'

     drop table adventuresales_lower2019.dbo.v_kidsa_Strata_sum_tbl_mrg_bdg
 SELECT * into  adventuresales_lower2019.dbo.v_kidsa_Strata_sum_tbl_mrg_bdg
  FROM adventuresales_lower2019.dbo.v_kidsa_Strata_sum_tbl_mrg
   where branch_name='bandung'

   ---v_U180a_Strata_sum_tbl_mrg

        drop table adventuresales_lower2019.dbo.v_u180a_Strata_sum_tbl_mrg_bdg
 SELECT * into  adventuresales_lower2019.dbo.v_u180a_Strata_sum_tbl_mrg_bdg
  FROM adventuresales_lower2019.dbo.v_u180a_Strata_sum_tbl_mrg
   where branch_name='mama'

   --Scia_Strata_sum_tbl_mrg

           drop table adventuresales_lower2019.dbo.Scia_Strata_sum_tbl_mrg_bdg
 SELECT * into  adventuresales_lower2019.dbo.Scia_Strata_sum_tbl_mrg_bdg
  FROM adventuresales_lower2019.dbo.Scia_Strata_sum_tbl_mrg
   where branch_name='bandung'


 */
































GO

