USE [AdventureSales]
GO

/****** Object:  View [dbo].[Complete_Wk_Report_bySubChannel_All_Dtl_Stockpoint_LY2]    Script Date: 21/03/2025 9:35:29 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO











alter VIEW [dbo].[Complete_Mth_Report_bySubChannel_All_Dtl_Stockpoint_LY2]
AS
SELECT        region, branch_id, branch_name, year, month,  channel, sub_channel, 
  prodgrp, psub_id, psub_id1, CRM, sls_100,DW_18,DW_Oth,product,retwhs,chiller,
 sum(net_qty) as net_qty, sum(net_amt) as net_amt,sum(grs_amt) as grs_amt,
 sum(rtn_amt) as rtn_amt,sum(disc_amt) as disc_amt, sum(Disc_B) as Discount_B, sum(Disc_PT) as Discount_PotTunai,
 sls_type,sls_412,sls_200
FROM            Complete_Wk_Report_bySubChannel_All_Dtl_Stockpoint_LY2 where year < 2025
 group by region, branch_id, branch_name, year, month,  channel, sub_channel, 
  prodgrp, psub_id, psub_id1, CRM, sls_100,DW_18,DW_Oth,sls_type,product,retwhs,sls_412,chiller,sls_200
  /*
  select *into adventuresales_lower2019.dbo.Complete_Mth_Report_bySubChannel_All_Dtl_Stockpoint_LY2_tbl
   from Complete_Mth_Report_bySubChannel_All_Dtl_Stockpoint_LY2
   */










GO

