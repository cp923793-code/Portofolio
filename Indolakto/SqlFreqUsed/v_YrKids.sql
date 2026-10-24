USE [AdventureSales]
GO

/****** Object:  View [dbo].[v_MthStc]    Script Date: 5/20/2025 9:21:45 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO









alter VIEW [dbo].[v_YrKids]
AS
SELECT     c.udf1 as psub_id1, a.branch_id,branch_name, kode_iap,
 year, b.custd_name,depo,sp_name,  region, a.sp_id,  
channel,sub_channel, 
 sum(net_qty) as net_qty, 
 sum(net_amt) as net_amt 
 
FROM   sttyr_kids a inner join customerdist_1910a b on a.custd_id=b.kode_iap
 left outer join product_svr55 c on a.prod_id=c.prod_id
 left outer join branch d on a.branch_id=d.branch_id
 left outer join stockpoint e on a.sp_id=e.sp_id
 where   c.udf1='KIDS'
  group by c.udf1, a.branch_id,branch_name, kode_iap,
 year,  b.custd_name,depo,sp_name,  region, a.sp_id,  
  channel,sub_channel,customer_group

GO

