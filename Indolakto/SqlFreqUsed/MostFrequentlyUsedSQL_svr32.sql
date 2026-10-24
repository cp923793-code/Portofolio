-- find additional stt for certain sp
 use adventuresales
 --select *from dim_period where full_date>'2024-10-25' order by full_date
 --select *from dim_period where full_date between '2024-10-28' and '2024-10-31'
  --select *from dim_period where full_date between '2024-10-28' and '2024-10-31'
 -- cek weekly
 select week,sum(net_amt) from sttwk_2024d group by week order  by week
 select week,sum(net_qty) from sttwk_2024d.dbo.sttwk group by week order  by week
 -- check blank_sp_id, prod_id, sls_id, kode_iap
  -- use adventuresales
select distinct sp_id from sttwktmp1 a where not exists  --5224/034_035
(select 1 from stockpoint b where a.sp_id=b.sp_id)
select distinct sp_id,week from sttmttmp a where not exists  --5224/034_035
(select 1 from stockpoint b where a.sp_id=b.sp_id)
select distinct sp_id,week from sttwk_2024d a where not exists  --5224/034_035
(select 1 from stockpoint b where a.sp_id=b.sp_id)
select  sp_id,week,sum(net_qty) as net_qty from sttwk_2025a a where not exists  --5224/034_035
(select 1 from stockpoint b where a.sp_id=b.sp_id)
group by sp_id,week
select distinct custd_id from sttwktmp1 a where not exists
(select 1 from customerdist_1910a b where a.custd_id=b.kode_iap)
select distinct prod_id from sttwktmp1 a where not exists
(select 1 from product b where a.prod_id=b.prod_id)
select distinct branch_id,sp_id,sls_id from sttwktmp1 a where not exists
(select 1 from slsman b where a.branch_id=b.branch_id and a.sp_id=b.sp_id)

 -- use adventuresales
 -- insert into reprocesssp1 values ('5219/024')  -- select *from reprocesssp1
 -- select disti nct week from Complete_2years_Wk_Report_bySubChannel_All_Dtl_StockPoint where year=2024 and sp_id in ('5219/011','5219/024')
select /*year,*/a.week,a.branch_id,sp_id,sum(net_amt) as net_amt from 
--(select * from sttwk1a1_23)  a  -- handle different table
--(select * from sttmttmp)  a  -- handle different table
--(select * from sttwktmp1)  a 
 (select * from sttwktmp1a)  a  -- handle different table
-- (select * from sttwk_2024)  a  -- handle different table
-- (select * from Complete_2years_Wk_Report_bySubChannel_All_Dtl_StockPoint )  a  -- handle different table
-- inner join reprocessbranch b on a.branch_id=b.branch_id --and a.week=b.week  -- only for single week
 --where a.week in (10)  --use it for multi week, multi branch
 where year=2025
 --and week in (select * from reprocessWk)
 group by /*year,*/a.week,a.branch_id,sp_id
 order by /*year,*/a.week,a.branch_id,sp_id
 --use sttwk_tmp
select /*year,*/a.week,a.branch_id,sp_id,sum(net_amt) as net_amt from 
--(select * from sttwk_tmp.dbo.sttwktmp1a)  a  -- handle different table
--(select * from sttwk_2024a)  a  -- handle different table
(select * from sttwktmp1)  a  -- handle different table
-- inner join reprocessbranch b on a.branch_id=b.branch_id --and a.week=b.week  -- only for single week
 --where a.week in (40) --(22,23,24,25)  --use it for multi week, multi branch
 --where year=2022 and a.branch_id in (select * from sales.dbo.reprocessBranch)
 --and week in (select * from reprocessWk)
 group by /*year,*/a.week,a.branch_id,sp_id
 order by /*year,*/a.week,a.branch_id,sp_id
-- cek outlet by name
use adventuresales
select *from customerdist_1910a where custd_name like '%benih kasih%' and branch_id='5200/5223'
--- check new sp
 select distinct sp_id from sttwk_2024 a where not exists (select 1 from stockpoint b where a.sp_id=b.sp_id)
 select *from reprocessbranch
 select distinct branch_id from complete_Wk_Report_bySubChannel_All_Dtl_StockPoint where isnull(sp_id,'')=''
  select distinct branch_id,week into ReprocessBranch_1 from complete_Wk_Report_bySubChannel_All_Dtl_StockPoint where isnull(sp_id,'')='' order by branch_id,week
 select *from stockpoint where depo like '%sanggau%' order by sp_id
 insert into stockpoint
 values ('5202/088','SP KUTACANE','5200/5202','PEMATANG SIANTAR','F','','','','','','','','','','','','','','')
  insert into stockpoint
 values ('5208/036','SP PUTUSSIBAU','5200/5208','SANGGAU','F','','','','','','','','','','','','','','')

-- find new outlet
select distinct custd_id from sttwk_2025a a where not exists
 (select 1  from customerdist_1910a b where a.custd_id=b.kode_iap)

 -- find new outlet
select distinct custd_id from sttwktmp1 a where not exists
 (select 1  from customerdist_1910a b where a.custd_id=b.kode_iap) order by custd_id
 -- cek wrong outlets
 select kode_iap from customerdist_1910a where branch_id='5200/5216' and custdid='891927'

 
-- find new outlet
--select * from sttwk_tmp.dbo.sttwktmp1a
--use adventuresales
select distinct custd_id from sttwktmp1a a where not exists
 (select 1  from customerdist_1910a b where a.custd_id=b.kode_iap)

-- find new outlet
--select * from sttwk_tmp.dbo.sttwktmp1a
--use adventuresales
select distinct custd_id from sttwktmp2 a where not exists
 (select 1  from customerdist_1910a b where a.custd_id=b.kode_iap)
 -- find new slsman
 select a.* from sttwktmp1a a
 where not exists (select 1 from slsman b 
 where a.branch_id=b.branch_id and a.sp_id=b.sp_id 
  and a.sls_id=b.sls_id)

     -- find new slsman (amount)
 select distinct branch_id,sp_id,sls_id from sttwktmp1a a
 where not exists (select 1 from slsman b 
 where a.branch_id=b.branch_id and a.sp_id=b.sp_id 
  and a.sls_id=b.sls_id)
   -- find new slsman (amount)
 select sum(net_amt) from sttwktmp1a a
 where not exists (select 1 from slsman b 
 where a.branch_id=b.branch_id and a.sp_id=b.sp_id 
  and a.sls_id=b.sls_id)
 --use adventuresales
 select sum(net_qty) from sttwktmp1
select distinct custd_id from sttwktmp1 a where not exists
 (select 1  from customerdist_1910a b where a.custd_id=b.kode_iap)

-- find new products
--select * from sttwk_tmp.dbo.sttwktmp1a
select distinct branch_id,prod_id from sttwktmp1a a where not exists
 (select 1  from product_svr55 b where a.prod_id=b.prod_id)

 select distinct branch_id,prod_id from sttwktmp1 a where not exists
 (select 1  from product_svr55 b where a.prod_id=b.prod_id)


 select *  from product_svr55 where text_id like 'IMPP260%'

  insert into product_svr55
  SELECT     '000000000000436817' as prod_id, 'Kental Manis Indomilk Choco Pch260g' as prod_name, 'IMPC260G' as text_id, uom_text, uom, brand_id, 
    psub_id, konversi, konversi_kg, non_active, na_date, active_date, 'IMPC260G' as product, rank, brand, sub_brand, grup, urut, 
                      selected, udf1, 'IMPC' as udf2, 'IMPC' as udf3, udf4, udf5, udf6, 'IMPC' as udf7, ProdType, ProdType1,udf8
  from product_svr55 where text_id like 'IMPP260%'
   


 

--cek outlet by name

--- ini dia paling top
--use sales
select a.custdid as keyid, a.kode_iap,a.custd_name,a.*,
 b.sp_name from sales.dbo.customerdist_1910a a left outer join sales.dbo.stockpoint b
 on a.sp_id=b.sp_id
 where custd_name like '%toko baru%' and a.branch_id='5200/5202' and a.sp_id='5202/003'
 order by custdid
-- ini juga
select a.custdid as keyid, a.kode_iap,a.custd_name,a.*,
 b.sp_name from sales.dbo.customerdist_1910a a left outer join sales.dbo.stockpoint b
 on a.sp_id=b.sp_id
 --where custd_name like '%usaha abadi%' and a.branch_id='5200/5208'
 where kode_iap like '%470558%' and a.branch_id='5200/5216'

use adventuresales  -- check what year exists
select distinct year from sttyr_fly

use sales --ccheck weekly tables
select year,week,sum(net_qty) from sttwk_2024d.dbo.sttwk group by year,week order by year,week

use discount --ccheck weekly tables
select year,week,sum(disc_b_amt) from discount_b where year=2025
 group by year,week order by year,week

 select week,sum(disc_b_amt) from discount_b_tmp --where year=2024 
 group by week order by week
 

use adventuresales --ccheck weekly tables
select year,week,sum(net_qty) from sttwk_2024 group by year,week order by year,week

use adventuresales --ccheck disc select *from diso b  select *from discount_pottunai
select year,week,sum(disc_b_amt) from discount_b where year=2025 group by year,week order by year,week
select year,week,sum(disc_pottunai) from discount_pottunai where year=2025 group by year,week order by year,week

-- most Freq sp
-- weekly process
use adventuresales
 select *from begmonth -- check calendar first
 exec sp_FillChannelNewOutlet_1  -- please open before run.. fill channel, subchannel for new outlets
 exec sp_UpdateTypeOutlet_All  -- after you update new outlet to MTI / MTKA
 exec sp_InsertDiscount_B_PT  -- insert discount check
   exec sp_InsertSttWkTmp_woExistChecking  -- reinsert temporary weekly, monthly, yearly tables
 exec sp_RecreateYearlyMonthlyWeeklyTables_2  -- reinsert permanent weekly, monthly, yearly tables

  exec sp_CreateWeeklyReport_Dtl_StockPoint_DiscB_NoDrop_ReprocessCertainWeekStockpoint
   exec sp_CreateWeeklyReport_Dtl_CustId_SlsTyp_SlsExc_NoDrop_Weekly_MostFrequentUse

 exec v_CekSlsExc_Replacement_Pku_Pdg_1
 exec v_OutletTracking_FY
 exec sp_checkingFilesFromServer55
  exec sp_Copy_2023_Yearly



/* 
--cek current week stt
 use sales
 select week,sum(net_qty) from sttwk_2024a.dbo.sttwk group by week order by week
 select week,sum(net_qty) from sttwk_tmp.dbo.sttwktmp1a group by week
-- cek salesman history
use adventuresales
select year,week,count(*) as cnt from slsman_hst group by year,week order by year,week

insert into slsman_hst
select a.* from
(select a.branch_id,a.sp_id, a.sls_id,a.sls_name,year,week,sls_type 
 from slsman a
 inner join (select distinct branch_id,sp_id,sls_id,year,week from  sttwk_2025b
 where net_qty>0 and year=2025 and week>=12) b   
on a.branch_id = b.branch_id AND a.sp_id = b.sp_id and a.sls_id=b.sls_id) as a
 where not exists
(select 1 from slsman_hst as b where a.branch_id=b.branch_id and a.sp_id=b.sp_id
 and a.sls_id=b.sls_id and a.year=b.year and a.week=b.week)

--cek if new outlet already have stt
select a.custd_id,custd_name,year,sum(net_amt) from customerdist_1910a a 
  inner join sttwk_2024a.dbo.sttwk b on a.kode_iap=b.custd_id
 where kode_iap in 
('5200/5223/5223/030/470042','5200/5223/5223/030/470043','5200/5223/5223/030/470044','5200/5223/5223/030/470045')
 group by a.custd_id,custd_name,year

-- insert new DW_ILO
select *from ilo1.dbo.dw_Ilo_bak
select *from sales.dbo.dw_Ilo
use sales
 insert into sales.dbo.dw_ILO
 select kode_iap as custd_id,'PT. BENIH KASIH S.M' as custd_name,'AMBON' as area
  ,'MAKASSAR' as branch from customerdist_1910a where kode_iap in
('5200/5223/5223/030/470042','5200/5223/5223/030/470043','5200/5223/5223/030/470044','5200/5223/5223/030/470045')
 
 select week,sum(net_qty) from sttwktmp1 group by week

 select *from customerdistributorlist where [cust index]='5200/5205/026/210136'

 select *from customerdist_1910a 
where (customer_group like '%AEON%' or customer_group like '%INDOGROS%' or customer_group like '%FROZ%') 
 and branch_id like '5200%'
 order by customer_group

 update customerdist_1910a set customer_group='AEON' where customer_group ='AEON SPM'
*/