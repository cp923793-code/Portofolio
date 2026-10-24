USE [AdventureSales]
GO

/****** Object:  View [dbo].[sttwk1a1_kids]    Script Date: 14/01/2025 10:36:33 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


ALTER VIEW [dbo].[sttwk1a1_kids]
AS
SELECT    *
FROM         sttwk1a_Kids  -- select distinct year,week from sttwk1a1_kids order by year,week
 UNION ALL
SELECT    *
FROM         sttwk1a_kids_2024
--SELECT     *
--FROM         sttwk1a_Kids

 --where week <= (select cwk from begmonth)


GO

