USE [AdventureSales]
GO

/****** Object:  View [dbo].[v_Discount_cek_PSubId_withCB_LY2]    Script Date: 6/3/2025 2:34:19 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO






create VIEW [dbo].[v_Discount_cek_PSubId_withCB_LY2_tgt]
 as
select *from adventuresales_lower2019.dbo.Discount_cek_PSubId_withCB_weekly
--union all
--select *from adventuresales_lower2019.dbo.Discount_cek_PSubId_withCB_LY2
 

 -- select distinct year,week from adventuresales_lower2019.dbo.Discount_cek_PSubId_withCB order by year,week

 -- delete from adventuresales_lower2019.dbo.v_U180_mt_Strata_sum_tbl_mrg where year<2023
 -- delete from adventuresales_lower2019.dbo.v_U180a_Strata_sum_tbl_mrg  where year<2023
 /*
 redefine STT
 select *,convert(dec(12,0),0) as target
  into adventuresales_lower2019.dbo.Discount_cek_PSubId_withCB_weekly_with_tgt 
   from adventuresales_lower2019.dbo.Discount_cek_PSubId_withCB_weekly
 */

  /*
 redefine target
 select *  
  into adventuresales_lower2019.dbo.v_SP_STT25_AOP25_tbl_tgt 
   from adventuresales_lower2019.dbo.Discount_cek_PSubId_withCB_weekly
 */

GO

