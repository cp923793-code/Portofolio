USE [AdventureSales]
GO

/****** Object:  View [dbo].[v_ILO_MT_Dy]    Script Date: 05/11/2024 23:51:52 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

alter VIEW [dbo].[v_ILO_MT_Dy]
AS
SELECT     a.*, b.kode_sub AS kode_sub, b.product AS product, b.prodgrp AS prodgrp, b.prod_sub AS prod_sub, b.PLU AS PLU, c.week AS week
FROM         ilo_mt_dy a LEFT OUTER JOIN
                      dbo.MT_Product b ON a.ITEM = b.NamaProduct LEFT OUTER JOIN
                      dbo.CDay c ON a.[Year] = c.[year] AND a.[Month] = c.[month] AND a.Dy = c.dy
-- left outer join dms_ddi.dbo.dim_period d
  
/* 
insert into Cday
select year_num,month_num,day_num,week_of_year_num 
 from dms_ddi.dbo.dim_period where year_num=2023

 select *into adventuresales.dbo.MT_Product from MT_Product
  select *into adventuresales.dbo.CDay from CDay
  select *into adventuresales.dbo.ilo_mt_dy from ilo_mt_dy

  truncate table adventuresales.dbo.MT_Product
    truncate table adventuresales.dbo.IdmProdPrm
  delete from adventuresales.dbo.ilo_mt_dy where year>=2023 and month>10
   delete from adventuresales.dbo.ilo_mt_dy where year>2023
  -- select distinct year from ilo_mt_dy
  select *from   IdmProdPrm
  select *from IdmDCPrm

  select distinct year,month,dy from adventuresales.dbo.ilo_mt_dy with (nolock) 
   where year>=2024 and month=10
  order by year,month,dy

    select distinct year,month,day from adventuresales.dbo.ilo_mt_dy_prem with (nolock) 
   where year>2023 and month=10
  order by year,month,day

      select distinct year,month,day from adventuresales.dbo.ilo_mt_dy_prem with (nolock) 
   where year>=2023 and month>10
  order by year,month,day
  ---runcate table adventuresales.dbo.ilo_mt_dy

   insert into adventuresales.dbo.ilo_mt_dy
   select *from adventuresales_lower2019.dbo.ilo_mt_dy

*/

GO

