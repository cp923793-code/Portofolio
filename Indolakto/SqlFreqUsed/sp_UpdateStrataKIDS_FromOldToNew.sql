
create PROCEDURE [dbo].[sp_UpdateStrataKIDS_FromOldToNew]
AS
BEGIN
insert into adventuresales_lower2019.dbo.v_KIDS_slsId_Strata_2_sum_tbl_mrg_ChlInd_MktFcs
SELECT region, branch_id, branch_name, year, month, week, channel, sub_channel, sp_name, sp_id, prodgrp, 
 depo, RetWhs, '1) < 1 ctn' as strata, crm, chiller, sls_id, sls_type, mkt, mktname,
 sum(net_qty) as net_qty, sum(net_amt) as net_amt, sum(grs_qty) as grs_qty, sum(grs_amt) as grs_amt,
   sum(rtn_qty) as rtn_qty, sum(rtn_amt) as rtn_amt, sum(grs_amt-net_amt-rtn_amt) as disc_amt,
 sum(disc_b) as disc_B,sum(disc_potTunai) as disc_potTunai
FROM   adventuresales_lower2019.dbo.v_KIDS_slsId_Strata_2_sum_tbl_mrg_ChlInd_MktFcs
 where strata in ('1a) < 0.25 ctn','1) 0.25 ctn - 1 ctn')
 group by region, branch_id, branch_name, year, month, week, channel, sub_channel, sp_name, sp_id, prodgrp, 
 depo, RetWhs,crm, chiller, sls_id, sls_type, mkt, mktname

 end