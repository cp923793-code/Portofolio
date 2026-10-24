USE [AdventureSales]
GO

/****** Object:  View [dbo].[sttmt]    Script Date: 23/09/2024 11:21:07 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


alter VIEW [dbo].[v_Discount_Customer_UpFrom40]
AS

select * from(
select *,disc_amt/grs_amt*100 as pct from (
select a.branch_id,a.sp_id,branch_name,sp_name,a.custd_id,custd_name,year,month,channel,sub_channel,
 sum(grs_amt) as grs_amt,sum(net_amt) as net_amt, sum(rtn_amt) as ret_amt,sum(grs_amt-net_amt-rtn_amt) as Disc_Amt
  from sttmt_23_24 a left outer join branch b on a.branch_id=b.branch_id
    left outer join stockpoint c on a.sp_id=c.sp_id
	left outer join customerdist_1910a d on a.custd_id=d.kode_iap
	group by a.branch_id,a.sp_id,branch_name,sp_name,a.custd_id,custd_name,year,month,channel,sub_channel) as a
	) as b where pct>=40

	/*
	drop table adveneturesales_lower2019.dbo.v_Discount_Customer_UpFrom40_tbl
	 select *into  adveneturesales_lower2019.dbo.v_Discount_Customer_UpFrom40_tbl
	  from v_Discount_Customer_UpFrom40
	*/
GO

