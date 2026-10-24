USE [AdventureSales]
GO

/****** Object:  View [dbo].[v_SlsIap_Customer]    Script Date: 6/3/2025 7:38:16 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

















create VIEW [dbo].[v_customerdist_1910a_SlsIap_Customer]
AS
/*
SELECT    count(*)
FROM         slsiap.dbo.ao_mstcustomer
*/
-- select distinct custd_id from sttwk_2025b
select a.kode_iap,a.custd_name,a.kelurahan,b.kelurahan as kelurahan1
 from customerdist_1910a a left outer join
 (SELECT    company+'/'+branch+'/'+stockpointid+'/'+custcd as custd_id,kelurahan
FROM         slsiap.dbo.ao_mstcustomer) as b 
 on a.kode_iap=b.custd_id
 where a.kelurahan<>b.kelurahan
--order by week
/*

   update customerdist_1910a -- just once for update back from product_svr10
set
  kelurahan=b.kelurahan
from
  customerdist_1910a a
  inner join 
  (SELECT    company+'/'+branch+'/'+stockpointid+'/'+custcd as custd_id,kelurahan
FROM         slsiap.dbo.ao_mstcustomer) as b  on a.kode_iap=b.custd_id  
where a.kelurahan<>b.kelurahan

select count(*) FROM         slsiap.dbo.ao_mstcustomer
select *from slsiap.dbo.ao_mstcustomer
select distinct custd_id from sttwktmp1 a where  not exists
(select 1 from 
(SELECT    company+'/'+branch+'/'+stockpointid+'/'+custcd as custd_id
FROM         slsiap.dbo.ao_mstcustomer) as b where a.custd_id=b.custd_id)

select distinct a.custd_id from sttyr a
 inner join customerdist_1910a b on a.custd_id=b.kode_iap
  where isnull(kelurahan,'')='' and net_qty>0

  select *from customerdist_1910a where mkt='Y'
*/











GO

