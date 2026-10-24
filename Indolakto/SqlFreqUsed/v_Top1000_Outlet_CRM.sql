USE [AdventureSales]
GO

/****** Object:  View [dbo].[v_Top1000_Outlet_CRM]    Script Date: 23/09/2024 15:59:19 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


ALTER VIEW [dbo].[v_Top1000_Outlet_CRM]
AS

select r.*,year,AvgAmt,AvgQty,psub_id
from
(select r.*,row_number() over(partition by r.branch_name order by r.Avg_Mth_23 desc)rn
 from 
(select  region,a.branch_id,branch_name, a.depo,a.sp_name,a.sp_id,
 a.custd_id,cust_name,sum(net_amt)/7 as Avg_Mth_23
 from  stt_crm_weekly_fly a 
  where month between 1 and 7 and year=2023 and branch_name='bandung'
  group by  region,a.branch_id,branch_name, a.depo,a.sp_name,a.sp_id,
 a.custd_id,cust_name
  ) as r
) r left outer join v_stt_crm s on -- create this table first for fast access
 r.custd_id=s.custd_id-- and r.psub_id=s.psub_id 
      where r.rn<=1000  --s.year=2023
 

GO

