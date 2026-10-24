
USE [AdventureSales]
GO
/****** Object:  StoredProcedure [dbo].[sp_Create_STT_CB_Strata_SKM_Can_Fly_23_24_Weekly]    Script Date: 20/03/2025 10:35:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
alter PROCEDURE [dbo].[sp_DropTemporaryTables]
AS
BEGIN
-- strata weekly skm
drop table adventuresales_lower2019.dbo.STT_Strata_SKM_Wk_23_24 
drop table adventuresales_lower2019.dbo.Wk_23_24_CB_ProdSpc_strata_SKM
drop table adventuresales_lower2019.dbo.STT_Strata_SKM_Wk_23_24_tmp
drop table adventuresales_lower2019.dbo.Wk_23_24_CB_ProdSpc_strata_SKM_tmp
-- strata weekly skm by flavor
drop table adventuresales_lower2019.dbo.STT_Strata_SKM_Flav_Wk_23_24
drop table adventuresales_lower2019.dbo.Wk_23_24_CB_ProdSpc_strata_SKM_Flav
drop table adventuresales_lower2019.dbo.STT_Strata_SKM_Flav_Wk_23_24_tmp
drop table adventuresales_lower2019.dbo.Wk_23_24_CB_ProdSpc_strata_SKM_Flav_tmp
-- strata weekly skm sachet
drop table adventuresales_lower2019.dbo.STT_Strata_Skm_Sch_Fly_Wk_23_24
drop table adventuresales_lower2019.dbo.Wk_23_24_CB_ProdSpc_strata_SKM_Sch_Fly
-- strata weekly skm can
drop table  adventuresales_lower2019.dbo.STT_Strata_SKM_Can_fly_Wk_23_24
drop table adventuresales_lower2019.dbo.Wk_23_24_CB_ProdSpc_strata_SKM_Can_Fly
end