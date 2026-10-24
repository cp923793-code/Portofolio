USE [Discount_Cek]
GO
/****** Object:  StoredProcedure [dbo].[sp_CreateWeeklyReport_Dtl_StockPoint_SlsId_2yrs_yoy]    Script Date: 12/07/2024 01:37:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- drop procedure sp_CreateWeeklyReport_Dtl_StockPoint_SlsId_2yrs_NoDrop
-- select distinct month from sttmt_2024.dbo.sttmt order by month
alter PROCEDURE [dbo].[sp_CreateDiscountCheck_Mth_ProdType_SlsId_NoDrop_1]  AS  -- 16 minutes
 -- vary important.. because you use monthly, you cannot use slsexc_chlprn6 here..
-- you can uee it later on by using union all if you have time ???
-- select *from sttmt_2023.dbo.sttmt where month=2
-- select count(*) from discount_cek_ProdType where month=1
--select * into sttmt_2023a.dbo.sttmt_3 from sttmt_2023.dbo.sttmt where month between 7 and 9
-- select sum(net_amt) from discount_cek_ProdType where month=1
-- select sum(net_amt) from sttmt_2023.dbo.sttmt_1 where month=1
-- truncate table discount_cek_ProdType 
declare @week as smallint;
set @week=26--(select cwk from begmonth);
declare @month as smallint;
set @month=(select mth from begmonth);
declare @year as smallint;
set @year=(select yr_num from begmonth);
-- drop table sales.dbo.slsmanexc
-- select *into  sales.dbo.slsmanexc from slsexc.dbo.slsmanexc
-- select distinct month from discount_cek_ProdType
insert into discount_cek_ProdType ---Complete_2years_Wk_Report_bySubChannel_All_Dtl_StockPoint_SlsId
 --where month>=@month
-- select year,sum(net_amt) from Complete_2years_Wk_Report_bySubChannel_All_Dtl_StockPoint_MktName  where week=24 group by year
 --insert    into Complete_2years_Wk_Report_bySubChannel_All_Dtl_StockPoint_SlsId 
select f.region,a.branch_id,f.branch_name,a.year,a.month,
 /*a.week,*/c.channel,sub_channel,prodLine,
 --prodgrp,d.udf6 as psub_id,
prodtype as prodgrp, prodtype as psub_id, -- prodtype as psub_id1
 g.depo,g.sp_name,g.sp_id,--a.custd_id,custd_name,
 /*d.text_id,product,d.udf1 as psub_id1,*/ -- remember..you create discount_cek not bychannel ????
  case when c.CRM = 'Y' then 'Y' else 'N' end as CRM,
 -- slsman exclusive
 --  case when (r.sls_id <>'' or (h.sls_id_chl <>'' and y.sls_id<>'') or sls_id_org<>'') and r.no<=100 then 'Y' else 'N' end as Sls_100,
  case when y.sls_id<>'' and y.no<=100 then 'Y' else 'N' end as Sls_100,
-- case when L.sls_id <>'' then 'Y' else 'N' end as Sls_412,
  case when  y.sls_id<>'' then 'Y' else 'N' end as Sls_200
 
 ,case when u.custd_id<>'' then 'Y' else 'N' end as DW_18,
 case when v.custd_id<>'' then 'Y' else 'N' end as DW_Oth,Retwhs,
 case when c.Chiller = 'Y' then 'Y' else 'N' end as Chiller,
 convert(dec(17,5),sum(a.net_qty)) as net_qty,convert(dec(17,5),sum(a.net_amt)) as net_amt,
 convert(dec(17,5),sum(a.grs_qty)) as grs_qty,convert(dec(17,5),sum(a.grs_amt)) as grs_amt,
 convert(dec(17,5),sum(a.rtn_qty)) as rtn_qty,convert(dec(17,5),sum(a.rtn_amt)) as rtn_amt,
 convert(dec(17,5),sum(a.grs_amt-a.net_amt-a.rtn_amt)) as disc_amt
 ,convert(dec(17,5),sum(i.disc_b_amt)) as Disc_B, convert(dec(17,5),sum(j.disc_PotTunai)) as Disc_PT 
  ,x.sls_type, case when x.sls_type like '%canva%' then 'Y' else 'N' end  as Canvass,
   x.sls_id --case when c.Mkt = 'Y' then 'Y' else 'N' end  as Mkt,MktName
    ---into discount_cek_ProdType ---Complete_2years_Wk_Report_bySubChannel_All_Dtl_StockPoint_SlsId
 --into .Wk_Report_bySubChannel_All_Dtl_StockPoint_MktName
 -- from sttwk1b a  
  from sttmt_2024.dbo.sttmt a  
  --from sttwk_2024b a  
  --  from sttwk_2024d a 
   --from sttmttmp a 
 --left outer join sales1.dbo.Customer_GT_MT c on a.custd_id=c.kode_iap
 left outer join customerdist_1910a c on a.custd_id=c.kode_iap
 left outer join product_svr55 d on a.prod_id=d.prod_id
 left outer join prodcat e on d.psub_id=e.psub_id
 left outer join branch f on a.branch_id=f.branch_id
 left outer join stockpoint g on a.sp_id=g.sp_id
 --left outer join dw_ilo_18 a on a.custd_id=a.custd_id
 -- left outer join dw_ilo_oth h on a.custd_id=h.custd_id
  left outer join discount_b_mth i on a.custd_id=i.custd_id and a.prod_id=i.prod_id and a.year=i.year and a.month=i.month and a.sls_id=i.sls_id
  left outer join discount_potTunai_mth j on a.custd_id=j.custd_id and a.prod_id=j.prod_id and a.year=j.year and a.month=j.month and a.sls_id=j.sls_id
  
  -- salesman exclusive
   --  left outer join sls_chlprn h on a.branch_id=h.br_chl and a.sp_id=h.sp_chl 
   --and a.sls_id=h.sls_id_chl and a.year=h.year and a.week=h.week
   left outer join slsmanexc y on a.branch_id=y.branch_id and a.sp_id=y.sp_id 
    and a.sls_id=y.sls_id 
  -- left outer join slsexc_chlprn6 b on  a.sp_id=b.sp_id1 
  --      and a.sls_id=b.sls_id1 and a.year=b.year and a.week=b.week
 --left outer join sls_slc r on a.branch_id=r.branch_id and a.sp_id=r.sp_id and a.sls_id=r.sls_id
 --left outer join sls_slc_412 L on a.branch_id=L.branch_id and a.sp_id=L.sp_id and a.sls_id=L.sls_id

  -- dw18
  left outer join dw_ilo_18 u on a.custd_id=u.custd_id
  left outer join dw_ilo_oth v on a.custd_id=v.custd_id
   --left outer join sp_slc_94 w on a.sp_id=w.sp_id
   left outer join slsman x on a.branch_id=x.branch_id and a.sp_id=x.sp_id and a.sls_id=x.sls_id
   -- left outer join custmkt m  on c.kode_iap=m.custd_id  
  -- left outer join mktmst z on m.mkt_id=z.mkt_id
 --where  f.branch_name ='bekasi' --and region like '%east%'
   where a.month =11---<= @week and  a.year>=@year --and a.month>=@month 
 group by f.region,a.branch_id,f.branch_name,a.year,a.month,/*a.week,*/g.depo,g.sp_name,g.sp_id,crm,chiller,
 --a.custd_id,custd_name,
 c.channel,sub_channel,prodLine,prodgrp,prodtype   --d.udf6,d.text_id,product,a.custd_id,d.udf1
  ,u.custd_id,v.custd_id,x.sls_type,RetWhs,x.sls_id,y.no,
  -- slsman exclusive
  /*r.Sls_id, r.No, h.Sls_id_Chl,*/ y.Sls_id--, b.sls_id_org, L.Sls_id 

  -- select *from custmkt
-- select * into sttmt_2023a.dbo.sttmt_1a from sttmt_2023a.dbo.sttmt_1 where month=3