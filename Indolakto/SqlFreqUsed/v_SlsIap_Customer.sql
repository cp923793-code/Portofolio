USE [AdventureSales]
GO

/****** Object:  View [dbo].[v_SlsIap_Customer]    Script Date: 6/4/2025 3:17:45 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

















ALTER VIEW [dbo].[v_SlsIap_Customer]
AS
/*
SELECT    count(*)
FROM         slsiap.dbo.ao_mstcustomer
*/
-- select distinct custd_id from sttwk_2025b
select distinct custd_id from sttwk_2025 a where  not exists
(select 1 from 
(SELECT    company+'/'+branch+'/'+stockpointid+'/'+custcd as custd_id
FROM         slsiap.dbo.ao_mstcustomer) as b where a.custd_id=b.custd_id)

select * from 
(SELECT    company+'/'+branch+'/'+stockpointid+'/'+custcd as custd_id,
 custnm,kelurahan
FROM         slsiap.dbo.ao_mstcustomer) as a
 where custd_id='5200/5202/5202/006/17070'
--order by week
/*
(SELECT    company+'/'+branch+'/'+stockpointid+'/'+custcd as custd_id
 custnme,kelurahan
FROM         slsiap.dbo.ao_mstcustomer)

select count(*) FROM         slsiap.dbo.ao_mstcustomer
select *from slsiap.dbo.ao_mstcustomer
select distinct custd_id from sttwktmp1 a where  not exists
(select 1 from 
(SELECT    company+'/'+branch+'/'+stockpointid+'/'+custcd as custd_id
FROM         slsiap.dbo.ao_mstcustomer) as b where a.custd_id=b.custd_id)
*/











GO

