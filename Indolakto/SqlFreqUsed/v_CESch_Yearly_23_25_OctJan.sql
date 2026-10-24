create VIEW [dbo].[v_CEch_Yearly_23_25_OctJan]
 AS
select year,month,psub_id,region,branch_id,branch_name,sp_id,sp_name,channel,sub_channel,
 sum(cb_all) as cb_all,   sum(net_qty) as net_Qty
from
(
select year,month,psub_id,region,branch_id,branch_name,sp_id,sp_name,channel,sub_channel,
 count(distinct(a.custd_id)) as CB_All,0 as Net_Qty,'CustBuy' as Type 
 from
 (select year,'Oct23_Jan24' as month,psub_id,a.custd_id,region,a.branch_id,branch_name,a.sp_id,sp_name,channel,sub_channel,
  sum(net_qty) as net_qty
 from sttmt_skm_fly a left outer join customerdist_1910a b on a.custd_id=b.kode_iap
  left outer join stockpoint c on a.sp_id=c.sp_id
   left outer join branch d on a.branch_id=d.branch_id
    left outer join product_svr55 e on a.prod_id=e.prod_id
      where ((year=2023 and month between 10 and 12) or (year=2024 and month =1))and psub_id='CE-SCH'
  group by year,psub_id,region,a.branch_id,branch_name,a.sp_id,sp_name,channel,sub_channel,a.custd_id
 ) as a 
  where net_qty>0 
  group by year,month,region,branch_id,branch_name,sp_id,sp_name,channel,sub_channel,psub_id

union all

select year,month,psub_id,region,branch_id,branch_name,sp_id,sp_name,channel,sub_channel,
  0  as CB_All, sum(net_qty) as Net_Qty,'STT' as Type 
 from
 (select year,'Oct23_Jan24' as month,psub_id,a.custd_id,region,a.branch_id,branch_name,a.sp_id,sp_name,channel,sub_channel,
  sum(net_qty) as net_qty
 from sttmt_skm_fly a left outer join customerdist_1910a b on a.custd_id=b.kode_iap
  left outer join stockpoint c on a.sp_id=c.sp_id
   left outer join branch d on a.branch_id=d.branch_id
    left outer join product_svr55 e on a.prod_id=e.prod_id
      where ((year=2023 and month between 10 and 12) or (year=2024 and month =1))and psub_id='CE-SCH'
  group by year,psub_id,region,a.branch_id,branch_name,a.sp_id,sp_name,channel,sub_channel,a.custd_id
 ) as a 
  group by year,month,region,branch_id,branch_name,sp_id,sp_name,channel,sub_channel,psub_id
  ) as a
   --where region like '%east%'
   group by year,month,psub_id,region,branch_id,branch_name,sp_id,sp_name,channel,sub_channel

   -- select distinct year,month from sttmt_skm_fly order by year,month
   union all -- jun24-sep24
   select year,month,psub_id,region,branch_id,branch_name,sp_id,sp_name,channel,sub_channel,
 sum(cb_all) as cb_all,   sum(net_qty) as net_Qty
from
(
select year,month,psub_id,region,branch_id,branch_name,sp_id,sp_name,channel,sub_channel,
 count(distinct(a.custd_id)) as CB_All,0 as Net_Qty,'CustBuy' as Type 
 from
 (select year,'Jun24_Sep24' as month,psub_id,a.custd_id,region,a.branch_id,branch_name,a.sp_id,sp_name,channel,sub_channel,
  sum(net_qty) as net_qty
 from sttmt_skm_fly a left outer join customerdist_1910a b on a.custd_id=b.kode_iap
  left outer join stockpoint c on a.sp_id=c.sp_id
   left outer join branch d on a.branch_id=d.branch_id
    left outer join product_svr55 e on a.prod_id=e.prod_id
      where (year=2024 and month between 6 and 9)and psub_id='CE-SCH'
  group by year,psub_id,region,a.branch_id,branch_name,a.sp_id,sp_name,channel,sub_channel,a.custd_id
 ) as a 
  where net_qty>0 
  group by year,month,region,branch_id,branch_name,sp_id,sp_name,channel,sub_channel,psub_id

union all

select year,month,psub_id,region,branch_id,branch_name,sp_id,sp_name,channel,sub_channel,
  0  as CB_All, sum(net_qty) as Net_Qty,'STT' as Type 
 from
 (select year,'Jun24_Sep24' as month,psub_id,a.custd_id,region,a.branch_id,branch_name,a.sp_id,sp_name,channel,sub_channel,
  sum(net_qty) as net_qty
 from sttmt_skm_fly a left outer join customerdist_1910a b on a.custd_id=b.kode_iap
  left outer join stockpoint c on a.sp_id=c.sp_id
   left outer join branch d on a.branch_id=d.branch_id
    left outer join product_svr55 e on a.prod_id=e.prod_id
      where (year=2024 and month between 6 and 9)and psub_id='CE-SCH'
  group by year,psub_id,region,a.branch_id,branch_name,a.sp_id,sp_name,channel,sub_channel,a.custd_id
 ) as a 
  group by year,month,region,branch_id,branch_name,sp_id,sp_name,channel,sub_channel,psub_id
  ) as a
   --where region like '%east%'
   group by year,month,psub_id,region,branch_id,branch_name,sp_id,sp_name,channel,sub_channel

   union all  --- Oct24-Jan25

   select year,month,psub_id,region,branch_id,branch_name,sp_id,sp_name,channel,sub_channel,
 sum(cb_all) as cb_all,   sum(net_qty) as net_Qty
from
(
select year,month,psub_id,region,branch_id,branch_name,sp_id,sp_name,channel,sub_channel,
 count(distinct(a.custd_id)) as CB_All,0 as Net_Qty,'CustBuy' as Type 
 from
 (select year,'Oct24_Jan25' as month,psub_id,a.custd_id,region,a.branch_id,branch_name,a.sp_id,sp_name,channel,sub_channel,
  sum(net_qty) as net_qty
 from sttmt_skm_fly a left outer join customerdist_1910a b on a.custd_id=b.kode_iap
  left outer join stockpoint c on a.sp_id=c.sp_id
   left outer join branch d on a.branch_id=d.branch_id
    left outer join product_svr55 e on a.prod_id=e.prod_id
      where ((year=2024 and month between 10 and 12) or (year=2025 and month =1))and psub_id='CE-SCH'
  group by year,psub_id,region,a.branch_id,branch_name,a.sp_id,sp_name,channel,sub_channel,a.custd_id
 ) as a 
  where net_qty>0 
  group by year,month,region,branch_id,branch_name,sp_id,sp_name,channel,sub_channel,psub_id

union all

select year,month,psub_id,region,branch_id,branch_name,sp_id,sp_name,channel,sub_channel,
  0  as CB_All, sum(net_qty) as Net_Qty,'STT' as Type 
 from
 (select year,'Oct24_Jan25' as month,psub_id,a.custd_id,region,a.branch_id,branch_name,a.sp_id,sp_name,channel,sub_channel,
  sum(net_qty) as net_qty
 from sttmt_skm_fly a left outer join customerdist_1910a b on a.custd_id=b.kode_iap
  left outer join stockpoint c on a.sp_id=c.sp_id
   left outer join branch d on a.branch_id=d.branch_id
    left outer join product_svr55 e on a.prod_id=e.prod_id
      where ((year=2024 and month between 10 and 12) or (year=2025 and month =1))and psub_id='CE-SCH'
  group by year,psub_id,region,a.branch_id,branch_name,a.sp_id,sp_name,channel,sub_channel,a.custd_id
 ) as a 
  group by year,month,region,branch_id,branch_name,sp_id,sp_name,channel,sub_channel,psub_id
  ) as a
   --where region like '%east%'
   group by year,month,psub_id,region,branch_id,branch_name,sp_id,sp_name,channel,sub_channel