USE [AdventureSales]
GO

/****** Object:  View [dbo].[v_Discount_cek_ProdType_withCB_LY2]    Script Date: 04/10/2024 15:30:16 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO





alter VIEW [dbo].[v_Discount_cek_ProdType_withCB_LY2]
 as
select *from adventuresales_lower2019.dbo.Discount_cek_ProdType_withCB
union all
select *from adventuresales_lower2019.dbo.Discount_cek_ProdType_withCB_LY2
-- select *from v_Discount_cek_ProdType_withCB_LY2
 






GO

