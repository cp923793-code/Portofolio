USE [AdventureSales]
GO

/****** Object:  View [dbo].[v_NewSalesmanExclusiveNotExists]    Script Date: 29/10/2024 9:50:26 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO




create VIEW [dbo].[v_ActiveSlsMan_2024]
AS
 select a.branch_id,a.sp_id,a.sls_id,branch_name,region,d.sp_name,sls_name,a.sls_type,sls_type2
  from slsman a left outer join slstypgrp_1 b on a.sls_type=b.sls_type
   left outer join branch c on a.branch_id=c.branch_id 
   left outer join stockpoint d on a.sp_id=d.sp_id
   inner join
  (select distinct branch_id,sp_id,sls_id from sttyr where net_qty >0) as e
   on a.branch_id=e.branch_id and a.sp_id=e.sp_id and a.sls_id=e.sls_id

-- select *from slstypgrp_1
GO

