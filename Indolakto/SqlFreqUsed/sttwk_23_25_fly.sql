USE [AdventureSales]
GO

/****** Object:  View [dbo].[sttwk_22_23_fly]    Script Date: 30/01/2025 14:09:45 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO





create VIEW [dbo].[sttwk_23_25_fly]
AS

select * from sttwk_2023 -- select distinct year,week from sttwk_2022
union all
select * from sttwk_2024 -- select distinct year,week from sttwk_2023
union all
select * from sttwk_2025a  



GO

