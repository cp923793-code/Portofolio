USE [AdventureSales]
GO

/****** Object:  View [dbo].[Complete_Wk_Report_bySubChannel_All_Dtl_Stockpoint]    Script Date: 05/03/2025 15:32:53 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO











alter VIEW [dbo].[Complete_Wk_Report_bySubChannel_All_Dtl_Stockpoint_CurrWeek]
AS
SELECT     * from Complete_2Years_Wk_Report_bySubChannel_All_Dtl_StockPoint
 where year=(select yr_num-1 from begmonth1) and week=(select cwk from begmonth1)
-- union all
--SELECT     * from adventuresales_lower2019.dbo.Wk_Report_bySubChannel_All_Dtl_StockPoint_LY
--union all 
--select * from  adventuresales_lower2019.dbo.Wk_Report_bySubChannel_All_Dtl_StockPoint_2021











GO

