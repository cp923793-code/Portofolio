USE [AdventureSales]
GO

/****** Object:  View [dbo].[sttyr_yoy]    Script Date: 6/4/2025 2:56:34 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


-- select year,sum(net_amt) from sttyr_yoy group by year

ALTER VIEW [dbo].[sttyr_yoy]
 AS
SELECT    * FROM         sttyr_skm_yoy
union all
SELECT    * FROM         sttyr_kids_yoy
union all
SELECT    * FROM         sttyr_sci_yoy 
union all
SELECT    * FROM         sttyr_uhtoth_yoy
union all
 SELECT   * FROM         sttyr_mk_yoy  
union all
SELECT    * FROM         sttyr_sbob_yoy
union all
SELECT    * FROM         sttyr_stc_yoy 
--union all
--select *from sttyr_ytd


GO

