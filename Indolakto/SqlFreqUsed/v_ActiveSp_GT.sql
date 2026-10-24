USE [AdventureSales]
GO

/****** Object:  View [dbo].[v_ActiveSp_GT]    Script Date: 07/10/2024 14:26:44 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- select *from v_activesp_gt
ALTER view [dbo].[v_ActiveSp_GT]
AS
SELECT   distinct a.sp_id,sp_name
FROM         customerdist_1910a a inner join active_sp b on a.sp_id=b.sp_id where channel='GT'

--select *from v_activesp_sls_100
--select *from sls_slc
--check GT exists in all sp ?
-- select count(distinct a.sp_id) from customerdist_1910a a inner join active_sp b on a.sp_id=b.sp_id
-- where channel='GT'


GO

