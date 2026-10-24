alter PROCEDURE [dbo].[sp_Fix_Mitra_Outlet]
	-- Please run each sp one by one..by opening it first
AS
BEGIN
select a.* from mitra_outlet a
 where not exists
 (select 1 from customerdist_1910a b
  where a.kode_iap=b.kode_iap)

update mitra_outlet set kode_iap=''
 where not exists
 (select 1 from customerdist_1910a b
  where mitra_outlet.kode_iap=b.kode_iap)
 

  update mitra_outlet -- just once for update back from product_svr10
set
  sp_id=b.sp_id
from
  mitra_outlet a
  inner join customerdist_1910a b  on a.kode_cabang=b.branch_id 
    and a.custdid=b.custdid
   where isnull(a.sp_id,'')=''

   update mitra_outlet
    set kode_iap=concat(kode_cabang,'/',rtrim(sp_id),'/',custdid)
	 where isnull(kode_iap,'')=''

	 --fix wrong custdid
	 update mitra_outlet
	  set custdid='400352' where kode_otl='0' and kode_cabang='5200/5202'
	   and outlet like 'padang%'

-- create STT
drop table AdventureSales_lower2019.dbo.CekMitraOutlet_STT
 select channel,sub_channel,region,a.kode_cabang,a.cabang,a.sp_id,sp_name,depo,
  a.kode_kec,a.kecamatan,a.kode_otl,a.outlet,custd_name,a.No#,
  a.kode_iap,year,month,week, 
  case when crm='Y' then 'Y' else 'N' end  as crm,
  case when mkt='Y' then 'Y' else 'N' end as mkt,
  case when chiller='Y' then 'Y' else 'N' end  as chiller,udf8 as psub_id,
   sum(net_qty) as net_qty, sum(net_amt) as net_amt
  into AdventureSales_lower2019.dbo.CekMitraOutlet_STT
   from mitra_outlet a 
   left outer join customerdist_1910a b on a.kode_iap=b.kode_iap
   left outer join branch c on a.kode_cabang=c.branch_id
   left outer join stockpoint d on a.sp_id=d.sp_id
   left outer join sttwk1b e on a.kode_iap=e.custd_id
   left outer join product_svr55 f on e.prod_id=f.prod_id
   --where week<=(select cwk from begmonth)
   group by
   channel,sub_channel,region,a.kode_cabang,a.cabang,a.sp_id,sp_name,depo,
  a.kode_kec,a.kecamatan,a.kode_otl,a.outlet,custd_name,a.No#,
  a.kode_iap,year,month,week, crm,mkt,chiller,udf8 


END