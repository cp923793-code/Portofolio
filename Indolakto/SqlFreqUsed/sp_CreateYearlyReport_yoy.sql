SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO


-- drop procedure sp_CreateWeeklyReport_Dtl_StockPoint_DiscB_NoDrop
alter   PROCEDURE [dbo].[sp_CreateYearlyReport_yoy]  AS  -- 2 minutes
 
drop table Yearly_Report_bySubChannel_yoy -- 15 minutes
--select a.*,prodgrp,prodline into Wk_Report_bySubChannel_All_Dtl from 
--(
--q1  please check the weeks for the last week
--insert into Wk_Report_bySubChannel_All_Dtl
--select count(*) from customerdist_1910a where chiller='Y'

--insert  into .Complete_2years_Wk_Report_bySubChannel_All_Dtl_StockPoint
select f.region,a.branch_id,f.branch_name,a.year,
  c.channel,sub_channel,prodLine,prodgrp,d.udf6 as psub_id,--g.depo,g.sp_name,g.sp_id,a.custd_id,custd_name,
 d.text_id,product,/*TypeOutlet,*/d.udf1 as psub_id1,
-- case when a.custd_id<>'' then 'Y' else 'N' end as DW_18,
-- case when h.custd_id<>'' then 'Y' else 'N' end as DW_Oth, 
 --case when c.CRM = 'Y' then 'Y' else 'N' end as CRM,
   /*
   case when L.sp_id <>'' then 'Y' else 'N' end  as Sp_246_RCan
 ,case when m.sp_id <>'' then 'Y' else 'N' end  as Sp_374_Sch
 ,case when n.sp_id <>'' then 'Y' else 'N' end  as Sp_607_Kid
,case when o.sp_id <>'' then 'Y' else 'N' end  as Sp_375_U180
 ,case when p.sp_id <>'' then 'Y' else 'N' end  as Sp_578_Sci
,case when q.sp_id <>'' then 'Y' else 'N' end  as Sp_441_TCa,
select *from slsmanexc
*/
-- case when ((h.sls_id_chl <>'' and y.sls_id<>'') or sls_id_org<>'') and y.no<=100 then 'Y' else 'N' end as Sls_100,
-- case when L.sls_id <>'' then 'Y' else 'N' end as Sls_412,
--  case when (h.sls_id_chl <>'' and y.sls_id<>'') or sls_id_org<>''  then 'Y' else 'N' end as Sls_200,
 /*
 case when s.kode_iap<>'' then 'Y' else 'N' end as Chiller,
 case when t.kode_iap<>'' then 'Y' else 'N' end as Hanger,
 */
 --case when u.custd_id<>'' then 'Y' else 'N' end as DW_18,
 --case when v.custd_id<>'' then 'Y' else 'N' end as DW_Oth,Retwhs,
 --case when c.Chiller = 'Y' then 'Y' else 'N' end as Chiller,
 convert(dec(17,5),sum(a.net_qty)) as net_qty,convert(dec(17,5),sum(a.net_amt)) as net_amt  --,
  
  /*case when w.sp_id<>'' then 'Y' else 'N' end as Sp_94_stc,x.sls_type,*/   --case when m.sp_id <>'' then 'Y' else 'N' end  as Sp_246,
 --  case when x.sls_type like '%canva%' then 'Y' else 'N' end  as Canvass,
 --  case when c.Mkt = 'Y' then 'Y' else 'N' end  as Mkt
  into Yearly_Report_bySubChannel_yoy
  --from sttwktmp1 a  
 -- select week,sum(net_qty) from sttwk_2024a group by week order by week
  from sttyr_17_yoy a  
 --  from sttmttmp a 
 --left outer join sales1.dbo.Customer_GT_MT c on a.custd_id=c.kode_iap
 left outer join customerdist_1910a c on a.custd_id=c.kode_iap
 left outer join product_svr55 d on a.prod_id=d.prod_id
 left outer join prodcat e on d.psub_id=e.psub_id
 left outer join branch f on a.branch_id=f.branch_id
 --left outer join stockpoint g on a.sp_id=g.sp_id
 --left outer join dw_ilo_18 a on a.custd_id=a.custd_id
 -- left outer join dw_ilo_oth h on a.custd_id=h.custd_id
 -- left outer join discount_b i on a.custd_id=i.custd_id and a.prod_id=i.prod_id and a.year=i.year and a.week=i.week and a.sls_id=i.sls_id
 -- left outer join discount_potTunai j on a.custd_id=j.custd_id and a.prod_id=j.prod_id and a.year=j.year and a.week=j.week and a.sls_id=j.sls_id
  --left outer join crmchlprn j on a.custd_id=j.child 
  -- left outer join v_CRMTargetProd_22_Mrg k on j.Parent=k.[customer id full]
  -- left outer join sls_chlprn h on a.branch_id=h.br_chl and a.sp_id=h.sp_chl 
  -- and a.sls_id=h.sls_id_chl and a.year=h.year and a.week=h.week
  --  left outer join slsmanexc y on h.br_chl=y.branch_id and h.sp_chl=y.sp_id 
  -- and h.sls_id_prn=y.sls_id 
  -- left outer join slsexc_chlprn6 b on  a.sp_id=b.sp_id1 
   --    and a.sls_id=b.sls_id1 and a.year=b.year and a.week=b.week
 --left outer join sp_slc_246 m on a.sp_id=m.sp_id
    /*
	select *from slsexc_chlprn6

 select sp_id_org,sls_id_org,sp_id1,sls_id1,sls_name,year,week,sls_type
  from slsexc_chlprn6 where year=2024 order by year,week

 left outer join sp_slc_374 m on a.sp_id=m.sp_id
 left outer join sp_slc_607 n on a.sp_id=n.sp_id
 left outer join sp_slc_375 o on a.sp_id=o.sp_id
 left outer join sp_slc_578 p on a.sp_id=p.sp_id
 left outer join sp_slc_441 q on a.sp_id=q.sp_id
 */
 --left outer join sls_slc r on a.branch_id=r.branch_id and a.sp_id=r.sp_id and a.sls_id=r.sls_id
 --left outer join sls_slc_412 L on a.branch_id=L.branch_id and a.sp_id=L.sp_id and a.sls_id=L.sls_id

 -- left outer join sls_slc_200 m on a.sp_id=m.sp_id
 /*
  left outer join chillertoko_1_2_3 s on a.custd_id=s.kode_iap
 left outer join hangertoko_1_2_3 t on a.custd_id=t.kode_iap
 -- insert into  dw_ilo values ('5200/5223/5223/030/470046','PT. SINAR SURI','BIAK','MAKASSAR')
 */
 -- left outer join dw_ilo_18 u on a.custd_id=u.custd_id
 -- left outer join dw_ilo_oth v on a.custd_id=v.custd_id
   --left outer join sp_slc_94 w on a.sp_id=w.sp_id
  -- left outer join slsman x on a.branch_id=x.branch_id and a.sp_id=x.sp_id and a.sls_id=x.sls_id
 --where  f.branch_name ='bekasi' --and region like '%east%'
 -- where a.year>=@year and a.week>=@week 
 group by f.region,a.branch_id,f.branch_name,a.year, -- g.depo,g.sp_name,g.sp_id,crm,chiller,
 --a.custd_id,custd_name,
 c.channel,sub_channel,prodLine,prodgrp,d.udf6,d.text_id,product,/*a.custd_id,*/d.udf1
---  ,--,TypeOutlet --) as a
 --  u.custd_id,v.custd_id/*,w.sp_id,x.sls_type,sls_id_chl,y.sls_id,RetWhs,i.sls_id,j.sls_id
 -- ,sls_id_org,mkt,y.no */

  --exec sp_CTE_CreateWeeklyReport_Dtl_StockPoint_DiscB_DWFSILO




GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

