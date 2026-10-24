USE [AdventureSales]
GO

/****** Object:  View [dbo].[v_SlsManExc_New1_a]    Script Date: 13/11/2024 7:06:17 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO






alter VIEW [dbo].[v_SlsManExc_New1_b]
AS
SELECT     *
FROM         slsmanExc_batch1  a
 where not exists
 (select 1 from slsmanexc b where a.branch_id=b.branch_id and a.sp_id=b.sp_id and a.sls_id=b.sls_id)

-- late entry to slsmanexc from slsman
-- delete FROM         slsmanExc_batch1 where sp_id='5229/024' and sls_id='S008'
 -- select *from v_SlsManExc_New1_b
 -- select *from slsman where sp_id='5229/020' and sls_type='Exclusive Indolakto'
-- select sp_id,sls_id,count(*) as cnt from slsmanexc group by sp_id,sls_id having count(*)>1
--insert into slsmanexc select *from slsmanexc_batch1
--SELECT     *
--FROM         slsmanExc where salesman in ('erlangga saputra','fikri h. kurniawan','arya p. susanto') 



GO

