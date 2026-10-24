USE [AdventureSales]
GO

/****** Object:  View [dbo].[Complete_Wk_Report_bySubChannel_All_Dtl_Stockpoint_LY3]    Script Date: 04/03/2025 5:52:02 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


alter VIEW [dbo].[sttwk_VS_Complete2Years_spWk]
AS
select a.sp_id,a.week from (
(SELECT     sp_id,week,sum(net_qty) as neta from sttwk_2025a
 where year=(select yr_num from begmonth)
 group by sp_id,week) as a 
 left outer join
(SELECT     sp_id,week,sum(net_qty) as netb from Complete_2Years_Wk_Report_bySubChannel_All_Dtl_StockPoint
 where year=(select yr_num from begmonth)
 group by sp_id,week) as b
 on a.sp_id=b.sp_id and a.week=b.week
  ) 
  where neta<>netb or isnull(netb,0)=0

-- select *from reprocesssp order by week
--delete from reprocesssp insert into reprocesssp select *from  sttwk_VS_Complete2Years_spWk
--union all 
--select * from  adventuresales_lower2019.dbo.Wk_Report_bySubChannel_All_Dtl_StockPoint_2021
/*
select *into adventuresales_lower2019.dbo.Wk_Report_bySubChannel_All_Dtl_StockPoint_LY1
  from Complete_2Years_Wk_Report_bySubChannel_All_Dtl_StockPoint where year=2023
delete from Complete_2Years_Wk_Report_bySubChannel_All_Dtl_StockPoint where year=2023
select *from stockpoint where sp_id='5219/011'
*/










GO

