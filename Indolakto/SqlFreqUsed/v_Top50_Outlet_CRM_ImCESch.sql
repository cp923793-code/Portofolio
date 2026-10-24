USE [AdventureSales]
GO

/****** Object:  View [dbo].[v_Top100_Outlet_KidsImSch]    Script Date: 23/09/5024 16:01:57 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

create VIEW [dbo].[v_Top50_Outlet_CRM_ImCESch]
AS
-- select *from stt_crm_weekly_fly
-- select *from v_CRM_Weekly_Sum
select r.*,year,month,week,sum(net_qty) as net_qty,sum(net_amt) as net_amt
from
(select r.*,row_number() over(partition by r.psub_id1,r.branch_id,r.branch_name order by r.SumQty desc)rn
 from 
(select  region,a.branch_id,branch_name, a.depo,a.sp_name,a.sp_id,
 a.custd_id,cust_name,channel,sub_channel,a.psub_id1,sum(a.net_qty) as SumQty, sum(a.net_qty)/b.net_qty*100 as pct
 from adventuresales_lower2019.dbo.stt_crm_weekly_fly a left outer join v_CRM_Weekly_Sum b 
  on a.psub_id1=b.psub_id1 and a.branch_id=b.branch_id
  where a.year=2024  and a.psub_id1 in ('CE-SCH','IM-SCH') and b.net_qty>0
  -- and region like '%central%' --and (channel='GT' or sub_channel='MTI')
   --and not exists
   --(select 1 from DW_ILO e where a.custd_id=e.custd_id)
   -- and channel<>'MT'
  group by  region,a.branch_id,branch_name, a.depo,a.sp_name,a.sp_id,
 a.custd_id,cust_name,channel,sub_channel,a.psub_id1,b.net_qty
  ) as r
) r left outer join adventuresales_lower2019.dbo.stt_crm_weekly_fly s on -- create this table first for fast access
 r.custd_id=s.custd_id and r.psub_id1=s.psub_id1 
      where r.rn<=50 and r.psub_id1 in ('CE-SCH','IM-SCH') --and s.year=502 --and r.channel='GT'
 
 group by  r.region,r.branch_id,r.branch_name,year, month,week,r.depo,r.sp_name,r.sp_id,
 r.custd_id,r.cust_name,r.channel,r.sub_channel,r.psub_id1,SumQty,rn,pct

 



 ---select * from v_Top500_Slsman_Exc100
 --select *from v_MthKidsSkm














GO

