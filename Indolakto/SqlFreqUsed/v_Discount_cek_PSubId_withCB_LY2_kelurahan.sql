USE [AdventureSales]
GO

/****** Object:  View [dbo].[v_Discount_cek_PSubId_withCB_LY2]    Script Date: 6/4/2025 3:27:28 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO






create VIEW [dbo].[v_Discount_cek_PSubId_withCB_LY2_kelurahan]
 as
select *from adventuresales_lower2019.dbo.Discount_cek_PSubId_withCB_weekly_kelurahan
--union all
--select *from adventuresales_lower2019.dbo.Discount_cek_PSubId_withCB_LY2
 

 -- select distinct year,week from adventuresales_lower2019.dbo.Discount_cek_PSubId_withCB order by year,week

 -- delete from adventuresales_lower2019.dbo.v_U180_mt_Strata_sum_tbl_mrg where year<2023
 -- delete from adventuresales_lower2019.dbo.v_U180a_Strata_sum_tbl_mrg  where year<2023


GO

