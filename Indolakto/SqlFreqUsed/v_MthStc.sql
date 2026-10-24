USE [AdventureSales]
GO

/****** Object:  View [dbo].[v_MthKidsSkm]    Script Date: 04/02/2025 10:59:20 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO







create VIEW [dbo].[v_MthStc]
AS
SELECT     * from adventuresales_lower2019.dbo.Mth_Report_Stc_Outlet    ---sp_InsertMonthlyReport_Dtl_OUtlet_skm


GO

