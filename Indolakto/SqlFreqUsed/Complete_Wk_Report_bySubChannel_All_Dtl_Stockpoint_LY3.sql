USE [AdventureSales]
GO

/****** Object:  View [dbo].[Complete_Wk_Report_bySubChannel_All_Dtl_Stockpoint_LY3]    Script Date: 13/02/2025 14:17:13 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO











ALTER VIEW [dbo].[Complete_Wk_Report_bySubChannel_All_Dtl_Stockpoint_LY3]
AS
SELECT     * from Complete_2Years_Wk_Report_bySubChannel_All_Dtl_StockPoint
 union all
SELECT     * from adventuresales_lower2019.dbo.Wk_Report_bySubChannel_All_Dtl_StockPoint_LY1
--union all 
--select * from  Complete_Wk_Report_bySubChannel_All_Dtl_Stockpoint_LY3 where product='CECCA'

/*
select distinct a.product,udf6
  from  Complete_Wk_Report_bySubChannel_All_Dtl_Stockpoint_LY3 a inner join product_svr55 b on a.text_id=b.text_id
   where isnull(a.psub_id,'')='' and isnull(udf6,'')<>''

select *into adventuresales_lower2019.dbo.Wk_Report_bySubChannel_All_Dtl_StockPoint_LY1
  from Complete_2Years_Wk_Report_bySubChannel_All_Dtl_StockPoint where year=2023
delete from Complete_2Years_Wk_Report_bySubChannel_All_Dtl_StockPoint where year=2023
*/










GO

