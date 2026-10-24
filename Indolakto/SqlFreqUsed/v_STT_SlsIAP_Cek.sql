USE [AdventureSales]
GO

/****** Object:  View [dbo].[v_STT_SlsIAP_Cek]    Script Date: 4/28/2025 4:46:27 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



ALTER VIEW [dbo].[v_STT_SlsIAP_Cek]
AS

--select distinct fiscalyear,period,week,wkday from ao_salesdetailiap order by fiscalyear,period,week,wkday
--select sum(netslsqty_car) as net_qty from slsiap.dbo.ao_salesdetailiap where fiscalyear=2025 and period=4 and week=14

select fiscalyear,cast(week as int) as week,sum(netslsqty_car) as net_qty from slsiap.dbo.ao_salesdetailiap where fiscalyear=2025 
 group by fiscalyear,week order by fiscalyear,cast(week as int)
 /*
 select distinct companyid +'/'+branchid +'/'+ stockpointid+'/'+ custid,custname,fiscalyear,week 
  from slsiap.dbo.ao_salesdetailiap a where not exists 
   (select 1 from customerdist_1910a b where companyid +'/'+branchid +'/'+ stockpointid+'/'+ custid
   = b.kode_iap)
  --and fiscalyear=2025 and week=16 and custname like '%nasiah%' 


  select *from slsiap.dbo.ao_salesdetailiap
   where companyid +'/'+branchid +'/'+ stockpointid+'/'+ custid='5200/5219/5219/031/193507'
   */
--select distinct fiscalyear,period,week,wkday from ao_salesdetailiap_temp order by fiscalyear,period,week,wkday

--select distinct fiscalyear,period,week,wkday from bw_salesdetailiap order by fiscalyear,period,week,wkday

GO

