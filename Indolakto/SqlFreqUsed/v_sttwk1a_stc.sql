USE [AdventureSales]
GO

/****** Object:  View [dbo].[v_sttwk1a_stc]    Script Date: 05/02/2025 10:32:50 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO






ALTER VIEW [dbo].[v_sttwk1a_stc]
AS
select b.* ,
 case when i.crm='Y' then 'Y' else 'N' end as CRM,
 case when r.sls_id <>'' then 'Y' else 'N' end as Sls_100
from (
SELECT     branch_id, sp_id, custd_id, prod_id, sls_id, year, month, week, net_qty, net_amt,
 grs_qty, grs_amt,rtn_qty, rtn_amt, (grs_amt-net_amt-rtn_amt) as disc_amt
FROM         sttwk1a_stc
UNION ALL
SELECT     branch_id, sp_id, custd_id, prod_id, sls_id, year, month, week, net_qty, net_amt,
 grs_qty, grs_amt,rtn_qty, rtn_amt, (grs_amt-net_amt-rtn_amt) as disc_amt
FROM         sttwk1a_stc_2024
UNION ALL
SELECT     branch_id, sp_id, custd_id, prod_id, sls_id, year, month, week, net_qty, net_amt,
 grs_qty, grs_amt,rtn_qty, rtn_amt, (grs_amt-net_amt-rtn_amt) as disc_amt
FROM         sttwk1a_stc_2023
) as b
							left outer join customerdist_1910a i on b.custd_id=i.kode_iap
    left outer join sls_slc r on b.branch_id=r.branch_id and b.sp_id=r.sp_id and b.sls_id=r.sls_id

	--select distinct year,week from sttwk1a_stc order by year,week
	-- select distinct year from  adventuresales_lower2019.dbo.stt_crm_weekly_fly 
 





GO

