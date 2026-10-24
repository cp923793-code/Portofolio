USE [AdventureSales]
GO

/****** Object:  View [dbo].[v_ILO_MT_Dy_Prem2]    Script Date: 06/11/2024 0:15:59 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

create VIEW [dbo].[v_ILO_MT_Dy_Prem2]
AS
SELECT     a.BranchName, a.PrincipalName, a.Brand, a.ProductName, week, sum(SalesQty) as SalesQty,
 sum(SalesRp) as SalesRp, sum(SalesStore) as SalesStore,sum(SellStore) as SellStore,
 a.Year, a.Month, a.day,b.PackSize, c.Region
FROM         ilo_mt_dy_prem AS a LEFT OUTER JOIN
                      dbo.IdmProdPrm AS b ON a.ProductName = b.prodName LEFT OUTER JOIN
                      dbo.IdmDCPrm AS c ON a.BranchName = c.BrnNm LEFT OUTER JOIN
                      dbo.CDay d ON a.[Year] = d.[year] AND a.[Month] = d.[month] AND a.Day = d.dy
 where a.year>2020
 group by a.BranchName, a.PrincipalName, a.Brand, a.ProductName,a.Year, a.Month, a.day,
 b.PackSize, c.Region,week

-- select *from IdmProdPrm order by packsize
/*
select distinct productname,packsize into NewProduct from ilo_mt_dy_prem AS a LEFT OUTER JOIN
                      dbo.IdmProdPrm AS b ON a.ProductName = b.prodName 
 where isnull(packsize,'')=''
 order by packsize,productname

select *into adventuresales.dbo.ilo_mt_dy_prem from ilo_mt_dy_prem
select *into adventuresales.dbo.IdmProdPrm from IdmProdPrm
select *into adventuresales.dbo.IdmDCPrm from IdmDCPrm

  select distinct year,month,dy from adventuresales.dbo.ilo_mt_dy with (nolock) where year>2021 order by year,month,dy
select distinct year from ilo_mt_dy_prem
select distinct year,month,day from ilo_mt_dy_prem where year>=2023 order by year,month,day
select distinct year,month,dy from ilo_mt_dy where year>=2023 order by year,month,dy

INSERT INTO IdmProdPrm
SELECT *FROM NEWPRODUCT WHERE PRODUCTNAME LIKE '%370%'

*/

GO

