USE [AdventureSales]
GO

/****** Object:  View [dbo].[v_MthStc]    Script Date: 04/02/2025 16:20:38 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO









ALTER VIEW [dbo].[v_MthStc]
AS
SELECT     * from adventuresales_lower2019.dbo.Mth_Report_Stc_Outlet    ---sp_InsertMonthlyReport_Dtl_OUtlet_stc




GO

