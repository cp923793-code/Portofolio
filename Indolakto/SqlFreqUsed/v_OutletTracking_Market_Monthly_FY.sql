USE [AdventureSales]
GO

/****** Object:  View [dbo].[v_OutletTracking_Market_Monthly_FY]    Script Date: 11/11/2024 18:01:06 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO






ALTER VIEW [dbo].[v_OutletTracking_Market_Monthly_FY]
AS
SELECT     region,area,a.sp_id, c.depo,c.sp_name, a.custd_id, f.custd_name, f.channel, i.sls_type, i.sls_name,a.sls_id,a.branch_id,
 e.ProdSubBr AS prodgroup, d.psub_id, brand,d.text_id, prod_name,a.year, a.month, branch_name,f.address_1,RetWhs,g.mkt_id,mktname,mkt,
  SUM(a.net_qty) AS net_qty,
 SUM(a.net_amt) AS net_amt
 --select distinct year,week from sttwk1b order by year,week
--FROM        sttwk1b AS a LEFT OUTER JOIN -- sttwk_2023 AS a LEFT OUTER JOIN
-- select *from custmkt  --select *from mktmst
 FROM        sttmt_23_24 AS a LEFT OUTER JOIN -- sttwk_2023 AS a LEFT OUTER JOIN
                      dbo.Branch AS b ON a.branch_id = b.branch_id LEFT OUTER JOIN
                      dbo.stockpoint AS c ON a.sp_id = c.sp_id LEFT OUTER JOIN
                      dbo.product_SVR55 AS d ON a.prod_id = d.prod_id LEFT OUTER JOIN
                      dbo.ILO_PrdAlias AS e ON d.text_id = e.Product LEFT OUTER JOIN
                      dbo.customerdist_1910a AS f ON a.custd_id = f.kode_iap
 left outer join slsman i on rtrim(a.branch_id)+'/'+rtrim(a.sp_id)+'/'+rtrim(a.sls_id)=i.Sls_id_Full
 left outer join custmkt g on a.custd_id=g.custd_id
 left outer join mktmst h on g.mkt_id=h.mkt_id
 -- select *from customerdist_1910a  -- select distinct area,branch_name from branch where region like '%east%'
 -- select *from custmkttmp
  --where (month=(select mth from begmonth) and year=(select yr_num from begmonth)) or month between 10 and 12  
 --where year=(select yr_num from begmonth) --and month=(select mth-1 from begmonth)
GROUP BY  region,area,a.sp_id, c.depo,c.sp_name, a.custd_id, f.custd_name, f.channel, i.sls_type, i.sls_name,a.sls_id,
 e.ProdSubBr , d.psub_id, brand,d.text_id, prod_name,a.year, a.month,branch_name,f.address_1,RetWhs,a.branch_id,g.mkt_id,mktname,mkt

 /*
 -- select *from sttwk_2020 where branch_id like '5200/5203%'  --select *from branch where branch_name like '%baru%'
 use adventuresales
 --please do east java and east area separeately
        drop table adventuresales_lower2019.dbo.v_OutletTracking_Market_Monthly_C2b_FY_tbl
 select *into adventuresales_lower2019.dbo.v_OutletTracking_Market_Monthly_C2b_FY_tbl
  from v_OutletTracking_Market_Monthly_FY where area like '%east java%' -----or region like '%east%'
  update adventuresales_lower2019.dbo.v_OutletTracking_Market_Monthly_C2b_FY_tbl set mkt='N' where isnull(mkt,'')=''
  delete from adventuresales_lower2019.dbo.v_OutletTracking_Market_Monthly_C2b_FY_tbl where area not like '%east java%'
  select distinct year,month from adventuresales_lower2019.dbo.v_OutletTracking_Market_Monthly_C2B_FY_tbl 
 order by year,month

          drop table adventuresales_lower2019.dbo.v_OutletTracking_Market_Monthly_East_FY_tbl 
 select *into adventuresales_lower2019.dbo.v_OutletTracking_Market_Monthly_East_FY_tbl 
  from v_OutletTracking_Market_Monthly_FY where region like '%east%'
  update adventuresales_lower2019.dbo.v_OutletTracking_Market_Monthly_East_FY_tbl  set mkt='N' where isnull(mkt,'')=''
    delete from adventuresales_lower2019.dbo.v_OutletTracking_Market_Monthly_East_FY_tbl  where area like '%east java%'
select distinct year,month from adventuresales_lower2019.dbo.v_OutletTracking_Market_Monthly_East_FY_tbl 
 order by year,month

  --please do bogor separeately
        drop table adventuresales_lower2019.dbo.v_OutletTracking_Market_Monthly_bogor_FY_tbl
 select *into adventuresales_lower2019.dbo.v_OutletTracking_Market_Monthly_C2b_FY_tbl
  from v_OutletTracking_Market_Monthly_FY where area like '%east java%' -----or region like '%east%'
  update adventuresales_lower2019.dbo.v_OutletTracking_Market_Monthly_C2b_FY_tbl set mkt='N' where isnull(mkt,'')=''
  delete from adventuresales_lower2019.dbo.v_OutletTracking_Market_Monthly_C2b_FY_tbl where area not like '%east java%'
  select distinct year,month from adventuresales_lower2019.dbo.v_OutletTracking_Market_Monthly_C2B_FY_tbl 
 order by year,month

	-- drop table adventuresales_lower2019.dbo.v_OutletTracking_Market_Monthly_FY_tbl 

 drop table adventuresales_lower2019.dbo.v_OutletTracking_FY_tbl
 select *into adventuresales_lower2019.dbo.v_OutletTracking_FY_tbl 
  from v_OutletTracking_FY where branch_name='malang' and depo='Madiun'

   drop table adventuresales_lower2019.dbo.v_OutletTracking_Market_Monthly_FY_tbl
 select *into adventuresales_lower2019.dbo.v_OutletTracking_Market_Monthly_FY_tbl
  from v_OutletTracking_Market_Monthly_FY where branch_name='malang' and depo like 'malang%'
  update adventuresales_lower2019.dbo.v_OutletTracking_Market_Monthly_FY_tbl set mkt='N' where isnull(mkt,'')=''

     drop table adventuresales_lower2019.dbo.v_OutletTracking_Market_Monthly_East_FY_tbl
 select *into adventuresales_lower2019.dbo.v_OutletTracking_Market_Monthly_East_FY_tbl
  from v_OutletTracking_Market_Monthly_FY where region like '%central%'  
  update adventuresales_lower2019.dbo.v_OutletTracking_Market_Monthly_East_FY_tbl set mkt='N' where isnull(mkt,'')=''



  delete from adventuresales_lower2019.dbo.v_OutletTracking_Market_Monthly_C2b_FY_tbl where area<>'east java'
  select distinct branch_name,area from   adventuresales_lower2019.dbo.v_OutletTracking_Market_Monthly_C2b_FY_tbl

  alter table adventuresales_lower2019.dbo.v_OutletTracking_Market_Monthly_East_FY_tbl
  add  area varchar(20)   null;

  update adventuresales_lower2019.dbo.v_OutletTracking_Market_Monthly_East_FY_tbl -- just once for update back from product_svr10
set
  area=b.area 
from
  adventuresales_lower2019.dbo.v_OutletTracking_Market_Monthly_East_FY_tbl a
  inner join branch b  on a.branch_id=b.branch_id
 -- where a.sub_channel<>b.sub_channel or a.retwhs<>b.retwhs or a.type_outlet1<>b.type_outlet1
 --  or a.mkt<>b.mkt or a.crm<>b.crm


    select year,sum(net_amt) from Complete_Wk_Report_bySubChannel_All_Dtl_StockPoint 
   where week<7 group by year

   select *  FROM customerdist_1910a
    where kode_iap in ('5200/5213/5213/027/306146','5200/5216/5216/093/468990','5200/5216/5216/093/100116')
 where exists
 (select 1 from customerdist_1910a b where mti_outlet1.custd_id=b.kode_iap
  and b.sub_channel <> 'MTI')

  drop table adventuresales_lower2019.dbo.v_KIDSa_Strata_sum_tbl_mrg_bdg
 SELECT * into  adventuresales_lower2019.dbo.v_KIDSa_Strata_sum_tbl_mrg_bdg
  FROM adventuresales_lower2019.dbo.v_KIDSa_Strata_sum_tbl_mrg
   where branch_name='bandung'
 */
















GO

