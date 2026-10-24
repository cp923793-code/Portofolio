USE [AdventureSales]
GO

/****** Object:  View [dbo].[sttwk_2021]    Script Date: 17/01/2025 14:17:27 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


alter VIEW [dbo].[v_KIDS_SCI_Up_15]
AS
-- select *from productgrpspc_kids order by text_id
select * from (
select kode_iap,sum(net_qty) as net_qty
  from customerdist_1910a a inner join sttwk_2024d b on a.kode_iap=b.custd_id
   inner join product_svr55 c on b.prod_id=c.prod_id
  where udf8 in ('KID','SCI') and (channel='GT' or sub_channel='MTI')
  group by kode_iap) as a
   where net_qty>=15

   -- select *into adventuresales_lower2019.dbo.v_KIDS_SCI_Up_15_tbl from v_KIDS_SCI_Up_15
   /*
   drop table adventuresales_lower2019.dbo.v_KIDS_SCI_Up_15_dtl_tbl
   select a.kode_iap,b.branch_id,b.sp_id,branch_name,sp_name,region,b.address_1,udf8 as product,sub_channel,a.net_qty,b.custd_name,crm,
     sum(c.net_qty) as Dtl_qty
	 into adventuresales_lower2019.dbo.v_KIDS_SCI_Up_15_dtl_tbl
    from adventuresales_lower2019.dbo.v_KIDS_SCI_Up_15_tbl a
    inner join customerdist_1910a as b on a.kode_iap=b.kode_iap
	inner join sttwk_2024d as c on a.kode_iap=c.custd_id
	left outer join branch d on b.branch_id=d.branch_id
	left outer join stockpoint e on b.sp_id=e.sp_id
	left outer join product_svr55 f on c.prod_id=f.prod_id
	inner join chiller_independen g on a.kode_iap=g.custd_id
	 where udf8 in ('KID','SCI')
	group by a.kode_iap,b.branch_id,b.sp_id,branch_name,sp_name,region,b.address_1,udf8,sub_channel,a.net_qty,b.custd_name,crm

   */
 
