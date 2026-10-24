USE [AdventureSales]
GO

/****** Object:  View [dbo].[v_Top200_Outlet_STC_GT]    Script Date: 5/20/2025 9:16:18 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO











ALTER VIEW [dbo].[v_Top200_Outlet_STC_GT]  -- select distinct year,week from v_Top200_Outlet_STC_GT
AS

select r.*,s.year as YearWk,month,week,sum(disc_amt) as disc_amt,sum(net_qty) as net_qty,sum(net_amt) as net_amt,
 sum(grs_qty) as grs_qty,sum(grs_amt) as grs_amt
from
(select r.*,row_number() over(partition by r.psub_id1 order by r.Amt_12mth desc)rn
 from 
(select  region,a.branch_id,branch_name,a.year, a.depo,a.sp_name,a.sp_id,
 a.kode_iap,custd_name,channel,sub_channel,psub_id1,sum(net_amt) as Amt_12mth
 from v_MthStc a -- select distinct year,month,kode_iap from v_MthStc
  where year=2024 /*and month between 1 and 1 */ and psub_id1 ='STC189'
   and channel='GT' --or sub_channel='MTI')
   --and not exists
   --(select 1 from DW_ILO e where a.custd_id=e.custd_id)
   -- and channel<>'MT'
  group by  region,a.branch_id,branch_name,a.year, a.depo,a.sp_name,a.sp_id,
 a.kode_iap,custd_name,channel,sub_channel,psub_id1
  ) as r
) r left outer join v_wk_stc s on -- select distinct year,week from  v_wk_stc order by year,week
 r.kode_iap=s.kode_iap and r.psub_id1=s.psub_id1 
      where r.rn<=200 and s.year>=2024 --and r.channel='GT'
 
 group by  r.region,r.branch_id,r.branch_name,r.year,s.year, month,week,r.depo,r.sp_name,r.sp_id,
 r.kode_iap,r.custd_name,r.channel,r.sub_channel,r.psub_id1,Amt_12mth,rn


 /* cek 
 select distinct a.kode_iap,b.kode_iap,b.year,b.week from (
 select distinct year,month,kode_iap from v_MthStc) as a
  left outer join
  (select distinct year,month,week,kode_iap from v_wk_stc) as b on a.kode_iap=b.kode_iap
   where b.year=2024

 */


 ---select * from v_Top500_Slsman_Exc100
 --select *from v_MthKidsSkm















GO

