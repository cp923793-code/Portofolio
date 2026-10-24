USE [AdventureSales]
GO

/****** Object:  View [dbo].[v_Wk_KidsSkm]    Script Date: 04/02/2025 11:11:15 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO





alter VIEW [dbo].[v_Wk_Stc]
AS
SELECT     * from adventuresales_lower2019.dbo.Wk_Report_stc_Outlet  --- by sp_InsertWeeklyReport_Dtl_Outlet_Stc

 



GO

