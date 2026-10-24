-- use slsexc
alter PROCEDURE [dbo].[sp_CreateWeeklyReport_Dtl_CustId_SlsTyp_SlsExc_NoDrop_Reprocess_test]  AS -- 11 minutes
/*
 select * from sls_slc_add
delete from slsmanexc where exists (select 1 from sls_slc_dlt b where slsmanexc.no=b.no)  
select year,week,sum(net_qty)  from sales_bak.dbo.sttwk_2024 group by year,week order by year,week
select year,week,sum(net_qty)  from sttwk_2024d.dbo.sttwk group by year,week order by year,week
select *into adventuresales_lower2019.dbo.Wk_Report_bySubChannel_All_Dtl_Cust_SlsId_SlsExc
  from Wk_Report_bySubChannel_All_Dtl_Cust_SlsId_SlsExc
-- delete from slsexc_chlprn6 where sp_id_org like '5227%'
-- select *from slsexc_chlprn6_jbi where sp_id_org like '5227%' order by sp_id_org,year,week 
-- select *from slsexc_chlprn6 order by year,week  -- truncate table slsexc_chlprn6
-- insert into slsexc_chlprn6 select *from slsexc_chlprn6_bak where sp_id_org like '5204%'
-- select *into slsexc_chlprn6_lmp from slsexc_chlprn6
insert into slsmanexc
select *from sls_slc_add
select *from slsmanexc_slc
select * into slsmanexc_slc from slsmanexc where branch_id='5200/5206'

select *from slsmanexc where branch_id='5200/5224'
update slsmanexc set salesman='MOHAMMAD F KATILI', sls_id='S026' where no=200
select *from slsexc_chlprn1 order by slsbefore
select *from branch where branch_name='manado'
select distinct year,week from slsman_hst order by year,week

select *from slsman_hst where (sls_name like '%katili%') or sls_name like 'REYNALDI%' 
 order by year,week

select *from slsman_hst where sp_id='5224/021' and sls_id='S026' order by year,week

delete  from Wk_Report_bySubChannel_All_Dtl_Cust_SlsId_SlsExc where no=200
use slsexc
 insert into slsmanexc_slc
 select *from slsmanexc where sp_id like '5207%' or sp_id like '5204%'
  or sp_id like '5205%' or sp_id like '5227%'

select *from slsmanexc_slc order by sp_id
select *from slsmanexc order by no a where exists (select 1 from sls_slc_add b where a.no=b.no) order by no

select * into slsmanexc_slc from slsmanexc where branch_id='5200/5206'
*/

declare @week as smallint;
--set @week=48--(select cwk from begmonth);
set @week=1--(select cwk from begmonth);
declare @year as smallint;
--set @year=2023--(select cwk from begmonth);
set @year=2023--(select yr_num from begmonth);
declare @branch as varchar(20);
set @branch='5200/5204';
-- insert into slsmanexc_slc select *from slsmanexc where branch_id='5200/5227'
delete from -- please change as required
 Wk_Report_bySubChannel_All_Dtl_Cust_SlsId_SlsExc_test
 -- select * into Wk_Report_bySubChannel_All_Dtl_Cust_SlsId_SlsExc_test_bak from Wk_Report_bySubChannel_All_Dtl_Cust_SlsId_SlsExc_test  
-- select *from slsmanexc_slc_bak  -- select *from slsexc_chlprn6 order by week
-- select * into slsexc_chlprn6_bak1 from slsexc_chlprn6  -- delete from slsexc_chlprn6 where sp_id_org not like '5207%' -- delete from slsmanexc_slc where branch_id <> '5200/5207'
   where exists (select 1 from slsmanexc_slc b 
     where Wk_Report_bySubChannel_All_Dtl_Cust_SlsId_SlsExc_test.sp_id=b.sp_id)

 --insert   into adventuresales_lower2019.dbo.Wk_Report_bySubChannel_All_Dtl_Cust_SlsId_SlsExc
  insert   into Wk_Report_bySubChannel_All_Dtl_Cust_SlsId_SlsExc_test
select sales_manager,supervisor,salesman,
no,f.region,f.branch_id,f.branch_name,b.year,b.month,week,
 channel,sub_channel,prodLine,prodgrp,d.udf1 as psub_id,g.depo,g.sp_name,'Exclusive Indolakto' as sls_type,n.sls_id,salesman as sls_name,--b.custd_id,custd_name,
 d.prod_id,d.text_id,d.product,RetWhs,kode_iap,custd_name,/*type_outlet1,*/
 case when crm ='Y'  then 'Y' else 'N' end as CRM, 
 case when no<=100 then 'Y' else 'N' end as sls_100, case when no between 101 and 200 then 'Y' else 'N' end as  sls_100a,'Y' as sls_200,
 convert(dec(17,5),sum(b.net_qty)) as net_qty,convert(dec(17,5),sum(b.net_amt)) as net_amt,
 convert(dec(17,5),sum(b.grs_qty)) as grs_qty,convert(dec(17,5),sum(b.grs_amt)) as grs_amt,
 convert(dec(17,5),sum(b.rtn_qty)) as rtn_qty,convert(dec(17,5),sum(b.rtn_amt)) as rtn_amt,
 convert(dec(17,5),sum(b.grs_amt-b.net_amt-b.rtn_amt)) as disc_amt,b.sp_id,batch
   from sttwk1c b -- please check first what this view contain
 --left outer join sales1.dbo.Customer_GT_MT c on b.custd_id=c.kode_iap
 inner join customerdist_1910a c on b.custd_id=c.kode_iap
 left outer join product_svr55 d on b.prod_id=d.prod_id
 left outer join prodcat e on d.psub_id=e.psub_id
 left outer join branch f on b.branch_id=f.branch_id
 left outer join stockpoint g on b.sp_id=g.sp_id
 --left outer join crmtarget_prod_22 i on b.custd_id=i.[customer id full]
 -- left outer join crmchlprn j on b.custd_id=j.child 
 --  left outer join crmtarget_prod_22 k on j.Parent=k.[customer id full]
  --left outer join slsman L on rtrim(b.branch_id)+'/'+rtrim(b.sp_id)+'/'+rtrim(b.sls_id)=L.Sls_id_Full
  --inner join slsExc_chlprn m on b.sp_id=m.sp_id and b.sls_id = m.slsbefore
   inner join slsmanexc_slc n on b.sp_id=n.sp_id and b.sls_id=n.sls_id
  --select *from branch where region like '%central%'
 where year>=@year and week>=@week
 --where   d.psub_id like ('kid%') and channel='GT' and f.region='2_Central1'--AND CHANNEL='GT'-- and year = 2022
 --ND month = 10 and year=2022 --and region like '%east%'
     --where exists
	  --(select 1 from slsmanexc_slc c where b.sp_id=c.sp_id and b.sls_id=c.sls_id)
 group by no,sales_manager,supervisor,salesman,f.region,f.branch_id,f.branch_name,year,month,week,g.depo,g.sp_name, 
 n.sp_id,n.sls_id,
 --b.custd_id,custd_name
 channel,sub_channel,prodLine,prodgrp,d.udf1,d.prod_id,d.text_id,d.product,b.sls_id,salesman,crm,kode_iap,custd_name,RetWhs,b.sp_id,batch--,type_outlet1 --) as a

--
 exec sp_CreateWeeklyReport_Dtl_CustId_SlsTyp_SlsExc_NoDrop_SlcWk_FixWeekByWeek_test
-- delete from slsexc_chlprn6 where year=2024 and sp_id_org<>'5206%'
-- delete from slsexc_chlprn6 where year=2023 and sp_id_org like '5207%' and week>47
-- select * from slsexc_chlprn6 where year=2023 and sp_id_org like '5207%' order by sp_id_org,year,week

 update Wk_Report_bySubChannel_All_Dtl_Cust_SlsId_SlsExc_test set sls_type='Exclusive Indolakto'
-- select *from slsexc_chlprn6 where sp_id_org like '5206%' order by year,week