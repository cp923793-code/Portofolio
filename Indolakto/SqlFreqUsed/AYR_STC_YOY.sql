----CB YOY
-- use sbob
select year,udf1 as product,region,branch_id,branch_name,channel,sub_channel,udf1,
 sum(cb_all) as cb_all,   sum(net_qty) as net_Qty
from
(
select year,region,branch_id,branch_name,channel,sub_channel,udf1,
 count(distinct(a.custd_id)) as CB_All,0 as Net_Qty,'CustBuy' as Type 
 from
 (select year,a.custd_id,region,a.branch_id,branch_name,channel,sub_channel,e.udf1,
  sum(net_qty) as net_qty
 from sttyr_Stc_yoy a left outer join customerdist_1910a b on a.custd_id=b.kode_iap
  left outer join stockpoint c on a.sp_id=c.sp_id
   left outer join branch d on a.branch_id=d.branch_id
    left outer join product  e on a.prod_id=e.prod_id
      --where  udf7 in ('TSC','TSC-TC')
  group by year,region,a.branch_id,branch_name,channel,sub_channel,e.udf1,a.custd_id
 ) as a 
  where net_qty>0 
  group by year,region,branch_id,branch_name,channel,sub_channel,udf1 

union all

select year,region,branch_id,branch_name,channel,sub_channel,udf1,
  0  as CB_All, sum(net_qty) as Net_Qty,'STT' as Type 
 from
 (select year,a.custd_id,region,a.branch_id,branch_name,channel,sub_channel,e.udf1,
  sum(net_qty) as net_qty
 from sttyr_Stc_yoy  a left outer join customerdist_1910a b on a.custd_id=b.kode_iap
  left outer join stockpoint c on a.sp_id=c.sp_id
   left outer join branch d on a.branch_id=d.branch_id
    left outer join product  e on a.prod_id=e.prod_id
     -- where  udf7 in ('TSC','TSC-TC')
  group by year,region,a.branch_id,branch_name,channel,sub_channel,e.udf1,a.custd_id
 ) as a 
  group by year,region,branch_id,branch_name,channel,sub_channel,udf1 
  ) as a
   group by year,region,branch_id,branch_name,channel,sub_channel,udf1