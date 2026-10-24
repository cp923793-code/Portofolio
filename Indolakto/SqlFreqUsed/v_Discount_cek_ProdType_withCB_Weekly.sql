USE [AdventureSales]
GO

/****** Object:  View [dbo].[v_Discount_cek_ProdType_withCB_LY2]    Script Date: 22/01/2025 15:49:56 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO




--v_Discount_cek_Prodtype_withCB_LY2



alter VIEW [dbo].[v_Discount_cek_ProdType_withCB_Weekly]
 as
select *from adventuresales_lower2019.dbo.Discount_cek_ProdType_withCB_Weekly
--union all
--select *from adventuresales_lower2019.dbo.Discount_cek_ProdType_withCB_LY2
-- select *from v_Discount_cek_ProdType_withCB_LY2
 








GO

