USE adventuresales
GO
/****** Object:  View [dbo].[sttwk1a_Liq]    Script Date: 11/07/2024 12:34:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER VIEW [dbo].[sttwk1a_Liq]
AS
SELECT     branch_id, sp_id, custd_id, prod_id, sls_id, year, month, week, net_qty, net_amt, grs_qty, grs_amt, rtn_qty, rtn_amt, prod_id
FROM         dbo.v_sttwk1a_sci
UNION ALL
SELECT     branch_id, sp_id, custd_id, prod_id, sls_id, year, month, week, net_qty, net_amt, grs_qty, grs_amt, rtn_qty, rtn_amt, prod_id
FROM         dbo.sttwk1a_uht

-- select distinct year,week from v_sttwk1a_sci order by year,week