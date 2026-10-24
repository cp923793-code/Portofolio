USE [AdventureSales]
GO

/****** Object:  View [dbo].[v_SlsManExc_New1]    Script Date: 17/09/2024 13:31:45 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO





create VIEW [dbo].[v_SlsManExc_New1_a]
AS
SELECT     *
FROM         slsmanExc_batch1_a  

-- late entry to slsmanexc from slsman

 -- select *from slsmanExc_batch
-- select sp_id,sls_id,count(*) as cnt from slsmanexc group by sp_id,sls_id having count(*)>1
--insert into slsmanexc select *from slsmanexc_batch1
--SELECT     *
--FROM         slsmanExc where salesman in ('erlangga saputra','fikri h. kurniawan','arya p. susanto') 
-- select *from v_SlsManExc_New1_a select *from slsmanexc where no <4


GO

