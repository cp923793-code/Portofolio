USE [AdventureSales]
GO

/****** Object:  View [dbo].[v_CustomerDist_1910a_VS_CustomerDistributorList]    Script Date: 27/03/2025 12:01:41 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


alter VIEW [dbo].[v_CustomerDist_1910a_VS_CustomerDistributorList_NotYetReprocessed]  
AS  
 
/****** Object:  View [dbo].[CustomerBuybyProductSub]    Script Date: 04/07/2024 14:26:54 ******/



  select a.*,b.[category mt] from customerdist_1910a a
   left outer join customerdistributorlist b on a.branch_id=b.branch_id and a.sp_id=b.[stockpoint id]
    and a.custdid=b.[customer id]
	 --inner join v_ActiveOutlet_21 c on a.kode_iap=c.custd_id
	 --where a.sub_channel<>b.[category mt] and a.branch_id like '5200%'
	 where a.sub_channel=b.[category mt] and a.branch_id like '5200%'
	  and [category mt]='MTKA'
	   and not exists
	   (select 1 from (select distinct custd_id from adventuresales_lower2019.dbo.Wk_Report_byCustomer_All
	    where ((year=2025 and week<9) or year<2025)) as c
	     where a.custd_id=c.custd_id )
       and exists
	   (select 1 from (select distinct custd_id from sttyr) as d where a.kode_iap=d.custd_id)
		-- order by custd_name
	 --order by sub_channel
/*

select *from customerdist_1910a a
 where exists
 (select 1 from v_CustomerDist_1910a_VS_CustomerDistributorList b where a.kode_iap=b.kode_iap)

update customerdist_1910a set channel='MT',sub_channel='MTKA', RetWhs='MTKA'
 where exists
 (select 1 from v_CustomerDist_1910a_VS_CustomerDistributorList b where customerdist_1910a.kode_iap=b.kode_iap)

 select * from  customerdist_1910a  
 where (custd_name like '%TRansmart%' or custd_name like '%TRans retail%') and sub_channel='MTKA' --order by kode_iap
  and customer_group<>'CARREFOUR'

update  customerdist_1910a set customer_group='CARREFOUR'
 where (custd_name like '%TRansmart%' or custd_name like '%TRans retail%') and sub_channel='MTKA'
  and customer_group<>'CARREFOUR'

  select *into adventuresales_lower2019.dbo.CustomerDistributorList_mtka
    from CustomerDistributorList where [category mt]='MTKA'

*/

	 -- select *from customerdist_1910a where custd_name like 'griya derwa%'
	 -- update customerdist_1910a

	 --select *from customerdist_1910a where custd_name like '%hyfresh%'

	 --	 select *from customerdistributorlist where [customer name] like '%hyfresh%'


GO

