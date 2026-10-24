-- use slsexc
alter PROCEDURE [dbo].[sp_CreateWeeklyReport_Dtl_CustId_SlsTyp_SlsExc_NoDrop_SlcWk_FixWeekByWeek_test]  AS -- 11 minutes
-- Please change according to sp you want to correct
-- drop procedure sp_CreateWeeklyReport_Dtl_CustId_SlsTyp_SlsExc_NoDrop_SlcWk_MostFrequentUse
-- select distinct year,month from sttmt_22_23 order by year,month
-- for temporary use only..thats why hardcode here
-- select week,sum(net_qty) from sttwk_2023d group by week order by week
-- select * into slsmanexc_slc_bak from slsmanexc_slc
-- insert into slsexc_chlprn6 select * from sales_bak.dbo.slsexc_chlprn6 where sp_id_org like '5207%' and year=2024 order by week
-- select * into slsexc_chlprn6_bak from slsexc_chlprn6
-- select *from slsexc_chlprn6_bak where sp_id_org like '5227%' order by year,week
-- delete from slsexc_chlprn6 where sp_id_org like '5227%'
-- select * from slsexc_chlprn6 where sp_id_org like '5207%' order by year,week
-- select * into slsmanexc_bak from slsmanexc 
/*
  select *from slsexc_chlprn6 a where not exists (select 1 from slsmanexc_slc b
 where a.sp_id_org=b.sp_id and a.sls_id1=b.sls_id) and sp_id_org like '5227%'

select *from slsexc_chlprn6 where sp_id_org like '5227%'
drop table slsexc_chlprn6_bak2 
select *into slsexc_chlprn6_bak2 from slsexc_chlprn6
select *from slsexc_chlprn6_bak1

insert into slsexc_chlprn6
select *from 

delete from slsexc_chlprn6 where sp_id_org not like '5227%'
delete from slsmanexc_slc where sp_id not like '5200/5227%'

 delete from slsexc_chlprn6 where exists (select 1 from slsmanexc_slc b
 where slsexc_chlprn6.sp_id_org=b.sp_id and slsexc_chlprn6.sls_id1=b.sls_id) and sp_id_org like '5227%'
*/
-- select *from slsexc_chlprn6 order by sp_id_org,sls_id_org,year,week
-- select *from slsexc_chlprn6 where sp_id_org <> sp_id1 order by sp_id_org,sls_id_org,year,week
declare @week as smallint;
--set @week=48--(select cwk from begmonth);
set @week=1--(select cwk from begmonth);
declare @year as smallint;
--set @year=2023--(select cwk from begmonth);
set @year=2023--(select yr_num from begmonth);
declare @branch as varchar(20);
set @branch='5200/5204';

--select *from slsexc_chlprn6 order by sp_id_org,year,week
--backup please
--truncate table adventuresales_lower2019.dbo.sttwk1c  -- select distinct year,month from adventuresales_lower2019.dbo.sttwk1c order by year,month
--insert into adventuresales_lower2019.dbo.sttwk1c select * from sttwk1c where branch_id in ('5200/5204','5200/5205','5200/5206','5200/5207','5200/5227') and year>2022
/*
select * into adventurestock.dbo.adventuresales_lower2019.dbo.Wk_Report_bySubChannel_All_Dtl_Cust_SlsId_SlsExc
  from adventuresales_lower2019.dbo.Wk_Report_bySubChannel_All_Dtl_Cust_SlsId_SlsExc

  select distinct branch_id from adventuresales_lower2019.dbo.Wk_Report_bySubChannel_All_Dtl_Cust_SlsId_SlsExc_test
-- sp_id_org must be in slsmanexc 
-- select *from slsexc_chlprn6 order by sp_id_org

delete from slsexc_chlprn6 where not exists
 (select 1 from slsmanexc_slc b where slsexc_chlprn6.sp_id_org=b.sp_id)

delete from slsexc_chlprn6 where not exists
 (select 1 from slsmanexc b where slsexc_chlprn6.sp_id_org=b.sp_id)

select *from slsexc_chlprn6 where year=2024 order by sp_id_org,year,week

    select count(*) from adventuresales_lower2019.dbo.Wk_Report_bySubChannel_All_Dtl_Cust_SlsId_SlsExc_test
  */
  -- this delete statemnt only to make sure..no sls_id will be count more than once

/* you dont have a plan for delete operation in this procedure  
-- delete operaition only in : sp_CreateWeeklyReport_Dtl_CustId_SlsTyp_SlsExc_NoDrop_Reprocess_test
 delete a from -- please change as required select * from
 Wk_Report_bySubChannel_All_Dtl_Cust_SlsId_SlsExc_test as a
  inner join slsexc_chlprn6 b on a.sp_id=b.sp_id_org and a.sls_id=b.sls_id1  -- dont use sls_id_org here.. the original not deleted, this is for additional
*/  

 insert   into Wk_Report_bySubChannel_All_Dtl_Cust_SlsId_SlsExc_test
select sales_manager,supervisor,salesman,
no,f.region,b.branch_id,f.branch_name,b.year,b.month,b.week,
 channel,sub_channel,prodLine,prodgrp,d.udf1 as psub_id,g.depo,g.sp_name,n.sls_type,sls_id_org as sls_id,salesman as sls_name,--b.custd_id,custd_name,
 d.prod_id,d.text_id,d.product,RetWhs,kode_iap,custd_name,/*type_outlet1,*/
 case when crm ='Y'  then 'Y' else 'N' end as CRM, 
 case when no<=100 then 'Y' else 'N' end as sls_100, case when no between 101 and 200 then 'Y' else 'N' end as  sls_100a,'Y' as sls_200,
 convert(dec(17,5),sum(b.net_qty)) as net_qty,convert(dec(17,5),sum(b.net_amt)) as net_amt,
 convert(dec(17,5),sum(b.grs_qty)) as grs_qty,convert(dec(17,5),sum(b.grs_amt)) as grs_amt,
 convert(dec(17,5),sum(b.rtn_qty)) as rtn_qty,convert(dec(17,5),sum(b.rtn_amt)) as rtn_amt,
 convert(dec(17,5),sum(b.grs_amt-b.net_amt-b.rtn_amt)) as disc_amt,sp_id_org as sp_id,batch
  -- from sttwk_2024a b -- please check first what this view contain  --select distinct year,week from sttwk_2023d order by year,week
   from slsexc.dbo.sttwk1c b -- please check first what this view contain
  --  from sttmttmp b -- please check first what this view contain

 --left outer join sales1.dbo.Customer_GT_MT c on b.custd_id=c.kode_iap
 inner join customerdist_1910a c on b.custd_id=c.kode_iap
 left outer join product_svr55 d on b.prod_id=d.prod_id
 left outer join prodcat e on d.psub_id=e.psub_id
 left outer join branch f on b.branch_id=f.branch_id
 left outer join stockpoint g on b.sp_id=g.sp_id
  inner join slsexc_chlprn6 m on b.sp_id=m.sp_id1 and b.sls_id = m.sls_id1 and b.year=m.year and b.week=m.week 
   inner join slsmanexc n on m.sp_id_org=n.sp_id and m.sls_id_org=n.sls_id  -- intended to get no# update slsmanexc set sls_id='S117' where salesman like 'qori%'
  --select *from slsmanexc where salesman like 'qori%'
 --where   d.psub_id like ('kid%') and channel='GT' and f.region='2_Central1'--AND CHANNEL='GT'-- and year = 2022
 --ND month = 10 and year=2022 --and region like '%east%'
      where  b.year>=@year and b.week >=@week --and b.branch_id=@branch
 group by no,sales_manager,supervisor,salesman,f.region,b.branch_id,f.branch_name,b.year,month,b.week,g.depo,g.sp_name, 
 --b.custd_id,custd_name,
 channel,sub_channel,prodLine,prodgrp,d.udf1,d.prod_id,d.text_id,d.product,b.sp_id,sls_id1,n.sls_type,sls_id_org,b.sls_id,salesman,crm,kode_iap,custd_name,RetWhs,sp_id_org,batch--,type_outlet1 --) as a

 

--update adventuresales_lower2019.dbo.Wk_Report_bySubChannel_All_Dtl_Cust_SlsId_SlsExc set sls_type='Exclusive Indolakto'
-- backup first please
-- select * into adventuresales_lower2019.dbo.Wk_Report_bySubChannel_All_Dtl_Cust_SlsId_SlsExc_bak from
   --adventuresales_lower2019.dbo.Wk_Report_bySubChannel_All_Dtl_Cust_SlsId_SlsExc
   -- select *from slsexc_chlprn6 where sp_id_org='5208/008'
   --delete from -- please change as required


 -- select *from slsmanExc 
 --update slsmanexc set sp_id=ltrim(rtrim(sp_id)),sls_id=ltrim(rtrim(sls_id))
 -- delete from slsmanexc where no in (134,151)
 /*
 insert into slsmanexc
 134 as no,

 select *from slsexc_chlprn order by sp_id,slsafter
 select *from slsman_hst where sls_name='JULIUS WIBOWO GULTOM' order by week

 select a.* from sttwk_22_23_fly a inner join slsexc_chlprn b on a.sp_id=b.sp_id and a.sls_id=b.slsbefore
 select *from slsexc_chlprn3
  
 update adventuresales_lower2019.dbo.Wk_Report_bySubChannel_All_Dtl_Cust_SlsId_SlsExc set sls_type='Exclusive Indolakto'
update adventuresales_lower2019.dbo.Wk_Report_bySubChannel_All_Dtl_Cust_SlsId_SlsExc-- just once for update back from product_svr10
set
  salesman=b.salesman 
--,
from
  adventuresales_lower2019.dbo.Wk_Report_bySubChannel_All_Dtl_Cust_SlsId_SlsExc a
  inner join slsmanexc b  on a.branch_id=b.branch_id and a.sp_id=b.sp_id and a.sls_id=b.sls_id
 where year>=@year and week>=@week
  */
 --delete from slsmanexc where no in (134,151)
 --insert into slsmanexc select *from sls_slc where no>100
 --select *from slsmanexc
  -- select distinct sp_id,sls_id from slsmanexc
  /*
  select *from slsmanexc
 select a.*,salesman from slsexc_chlprn6 a 
  left outer join slsmanexc b on a.sp_id_org=b.sp_id and a.sls_id_org=b.sls_id
   order by sp_id_org,week

   left outer join slsmanexc b on slsexc_chlprn.slsname=b.salesman

  select *from slsmanexc where salesman='Riski Saputra'
    select *from sls_slc where salesman='Riski Saputra'

	  select *from slsmanexc where sls_id='S269'

select *from sttwk_22_23_fly a inner join slsexc_chlprn b on a.sp_id=b.sp_id   and a.sls_id=b.slsbefore
 and sls_name='JULIUS WIBOWO GULTOM'

 select *from slsexc_chlprn6 where sls_id_org='S086' and sp_id_org like '5208%'
 select *from slsmanexc where sp_id='5208/009'

	  */