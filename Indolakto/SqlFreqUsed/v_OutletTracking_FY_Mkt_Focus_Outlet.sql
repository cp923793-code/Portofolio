USE [AdventureSales]
GO

/****** Object:  View [dbo].[v_OutletTracking_FY_Mkt_Focus_Outlet]    Script Date: 6/19/2025 3:41:11 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO




-- select *from mkt_focus  -- delete from mkt_focus
--select *from custmkttmp
--select *from custmkt
-- alter table mkt_focus add MdNo varchar(10)
-- alter table mkt_focus add No smallint -- alter table mkt_focus drop column no
-- alter table mkt_focus add SlsName varchar(40)
-- alter table mkt_focus add SlsType varchar(40)

ALTER VIEW [dbo].[v_OutletTracking_FY_Mkt_Focus_Outlet]
AS
SELECT     region,a.sp_id, c.depo,c.sp_name, a.custd_id, f.custd_name, f.channel, i.sls_type, i.sls_name,a.sls_id,a.branch_id,
 /*e.ProdSubBr AS prodgroup,*/ udf6 as psub_id, udf7 as product, brand,/*d.text_id, prod_name,*/a.year, a.month, A.week,branch_name,f.address_1,RetWhs,
 sls_spv,type_outlet1,sub_channel,j.mkt_id,h.mktname,j.mktname as mktexcel,j.no,j.slstype as TypExc,j.slsname as slsexc,mdNo,MdName,
 case when mkt='Y' then 'Y' else 'N' end as mkt,
 case when crm='Y' then 'Y' else 'N' end as crm,
 case when sls_type='Exclusive Indolakto' then 'Y' else 'N' end as Sls_200,
 --case when chiller='Y' then 'Y' else 'N' end as Chiller,
 --case when h.kode_iap<>'' then 'Y' else 'N' end as Chl_24,
 SUM(a.net_qty) AS net_qty, SUM(a.net_amt) AS net_amt,
  convert(dec(17,5),sum(a.grs_amt-a.net_amt-a.rtn_amt)) as disc_amt
 ,convert(dec(17,5),sum(K.disc_b_amt)) as Disc_B, convert(dec(17,5),sum(L.disc_PotTunai)) as Disc_PT 
 --select year,week,sum(net_qty) from sttmttmp group by year,week order by year,week
--FROM        sttwk_2023 AS a LEFT OUTER JOIN -- sttwk_2023 AS a LEFT OUTER JOIN
 --FROM        sttwk_2023 AS a LEFT OUTER JOIN -- sttwk_2023 AS a LEFT OUTER JOIN
 --FROM        sttwk_2024a AS a LEFT OUTER JOIN -- sttwk_2023 AS a LEFT OUTER JOIN
 -- select distinct year,week from sttwk1b order by year,week
  FROM        sttwk1b AS a --LEFT OUTER JOIN -- sttwk_2023 AS a LEFT OUTER JOIN
  -- FROM        sttwk_2024 AS a LEFT OUTER JOIN -- sttwk_2023 AS a LEFT OUTER JOIN
  -- FROM        sttmttmp AS a LEFT OUTER JOIN -- sttwk_2023 AS a LEFT OUTER JOIN
  -- select *from mkt_focus_outlet
     inner join mkt_focus_outlet j on a.custd_id=j.custd_id left outer join
                      dbo.Branch AS b ON a.branch_id = b.branch_id LEFT OUTER JOIN
                      dbo.stockpoint AS c ON a.sp_id = c.sp_id LEFT OUTER JOIN
                      dbo.product_SVR55 AS d ON a.prod_id = d.prod_id left outer JOIN
                     -- dbo.ILO_PrdAlias AS e ON d.text_id = e.Product LEFT OUTER JOIN   
					  dbo.customerdist_1910a AS f ON a.custd_id = f.kode_iap                   
		left outer join slsman i on rtrim(a.branch_id)+'/'+rtrim(a.sp_id)+'/'+rtrim(a.sls_id)=i.Sls_id_Full
		left outer join discount_b k on a.custd_id=k.custd_id and a.prod_id=k.prod_id and a.year=k.year and a.week=k.week and a.sls_id=k.sls_id
        left outer join discount_potTunai L on a.custd_id=L.custd_id and a.prod_id=L.prod_id and a.year=L.year and a.week=L.week and a.sls_id=L.sls_id
		left outer join custmkt g on a.custd_id=g.custd_id
		left outer join mktmst h on g.mkt_id=h.mkt_id -- select *from mktmst
	 -- inner join mkt_focus_outlet j on g.mkt_id=j.mkt_id   

	  -- select *from mkt_focus
  --where week<27
  --where (month=(select mth from begmonth) and year=(select yr_num from begmonth)) or month between 10 and 12  
 --where year=(select yr_num from begmonth) --and month=(select mth-1 from begmonth)
GROUP BY  region,a.sp_id, c.depo,c.sp_name, a.custd_id, f.custd_name, f.channel, i.sls_type, i.sls_name,a.sls_id,
/*( e.ProdSubBr*/  udf6, udf7,brand,/*d.text_id, prod_name,*/a.year, a.month,a.week,branch_name,f.address_1,RetWhs,a.branch_id,
 sls_spv,type_outlet1,sub_channel,j.mkt_id,h.mktname,mkt,crm,/*chiller,h.kode_iap,*/ j.mktname,j.no,j.slstype,j.slsname,mdNo,MdName

 -- select *from custmkt



 /*
 -- select distinct custd_id from adventuresales_lower2019.dbo.v_OutletTracking_FY_Mkt_Focus_tbl
 --  select distinct branch_name,depo,depo,depo  from slsexc_chlprn6 a inner join branch b on '5200/'+ substring(sp_id_org,1,4)=b.branch_id
 -- select distinct udf6,udf7 from product_svr55
 -- select *from sttwk_2020 where branch_id like '5200/5203%'  --select *from branch where branch_name,depo,depo,depo like '%baru%'
 drop table adventuresales_lower2019.dbo.v_OutletTracking_FY_Mkt_Focus_Outlet_tbl
 select *into adventuresales_lower2019.dbo.v_OutletTracking_FY_Mkt_Focus_Outlet
  from v_OutletTracking_FY_Mkt_Focus_Outlet  

  select *from customerdist_1910a where kode_iap like '%980503%' or custd_name like '%raudhatul%' order by kode_iap


  drop table adventuresales_lower2019.dbo.v_SCMa_Strata_sum_tbl_mrg_bdg
 SELECT * into  adventuresales_lower2019.dbo.v_SCMa_Strata_sum_tbl_mrg_bdg
  FROM adventuresales_lower2019.dbo.v_SCMa_Strata_sum_tbl_mrg
   where branch_name,depo,depo,depo='bandung'

     drop table adventuresales_lower2019.dbo.v_kidsa_Strata_sum_tbl_mrg_bdg
 SELECT * into  adventuresales_lower2019.dbo.v_kidsa_Strata_sum_tbl_mrg_bdg
  FROM adventuresales_lower2019.dbo.v_kidsa_Strata_sum_tbl_mrg
   where branch_name,depo,depo,depo='bandung'

   ---v_U180a_Strata_sum_tbl_mrg

        drop table adventuresales_lower2019.dbo.v_u180a_Strata_sum_tbl_mrg_bdg
 SELECT * into  adventuresales_lower2019.dbo.v_u180a_Strata_sum_tbl_mrg_bdg
  FROM adventuresales_lower2019.dbo.v_u180a_Strata_sum_tbl_mrg
   where branch_name,depo,depo,depo='mama'

   --Scia_Strata_sum_tbl_mrg

           drop table adventuresales_lower2019.dbo.Scia_Strata_sum_tbl_mrg_bdg
 SELECT * into  adventuresales_lower2019.dbo.Scia_Strata_sum_tbl_mrg_bdg
  FROM adventuresales_lower2019.dbo.Scia_Strata_sum_tbl_mrg
   where branch_name,depo,depo,depo='bandung'


 */




































GO

