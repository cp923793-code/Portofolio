USE [AdventureSales]
GO

/****** Object:  View [dbo].[v_ProdType]    Script Date: 13/04/2025 01:10:53 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

--select *from v_prodtype

ALTER VIEW [dbo].[v_ProdType]
AS
 select ProdType,text_id,prod_id,udf7,udf6,udf5,udf1 from product_svr55
  where prod_id not in ('000000000000106876','000000000000106893','000000000000106898')
-- please exclude one prod_id that has the same text id in the query below..or v_DoubleTextId
-- select *from slstypgrp_1
-- cek double text_id
/*
 select *from v_prodType a where exists (select 1 from 
 (select text_id,count(*) as cnt from sales.dbo.product_svr55  group by text_id having count(*)>1) as b
 where a.text_id=b.text_id) 
 and isnull(prodtype,'')<>''
 order by text_id
*/
GO

