USE [AdventureSales]
GO

/****** Object:  View [dbo].[sttmt_skm_FLY]    Script Date: 15/10/2024 14:26:24 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO





ALTER VIEW [dbo].[v_CB_TSC_Can_Yr]
AS
select year,'TSC-CAN' as product,region,branch_id,branch_name,channel,sub_channel,
 sum(cb_all) as cb_all,   sum(net_qty) as net_Qty
from
(
select year,region,branch_id,branch_name,channel,sub_channel,
 count(distinct(a.custd_id)) as CB_All,0 as Net_Qty,'CustBuy' as Type 
 from
 (select year,a.custd_id,region,a.branch_id,branch_name,channel,sub_channel,
  sum(net_qty) as net_qty
 from sttyr_skm_23_24_a a left outer join customerdist_1910a b on a.custd_id=b.kode_iap
  left outer join stockpoint c on a.sp_id=c.sp_id
   left outer join branch d on a.branch_id=d.branch_id
    left outer join product_svr55 e on a.prod_id=e.prod_id
      where  udf7 in ('TSC','TSC-TC')
  group by year,region,a.branch_id,branch_name,channel,sub_channel,a.custd_id
 ) as a 
  where net_qty>0 
  group by year,region,branch_id,branch_name,channel,sub_channel 

union all

select year,region,branch_id,branch_name,channel,sub_channel,
  0  as CB_All, sum(net_qty) as Net_Qty,'STT' as Type 
 from
 (select year,a.custd_id,region,a.branch_id,branch_name,channel,sub_channel,
  sum(net_qty) as net_qty
 from sttyr_skm_23_24_a a left outer join customerdist_1910a b on a.custd_id=b.kode_iap
  left outer join stockpoint c on a.sp_id=c.sp_id
   left outer join branch d on a.branch_id=d.branch_id
    left outer join product_svr55 e on a.prod_id=e.prod_id
      where  udf7 in ('TSC','TSC-TC')
  group by year,region,a.branch_id,branch_name,channel,sub_channel,a.custd_id
 ) as a 
  group by year,region,branch_id,branch_name,channel,sub_channel 
  ) as a
   group by year,region,branch_id,branch_name,channel,sub_channel





GO

