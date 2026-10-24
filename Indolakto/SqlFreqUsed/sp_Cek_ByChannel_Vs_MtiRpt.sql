alter PROCEDURE [dbo].[sp_Cek_ByChannel_Vs_MtiRpt]
	-- Please run each sp one by one..by opening it first


AS
BEGIN
truncate table reprocesssp1
insert into reprocesssp1  
select a.sp_id from 
(select sp_id,sum([net amount]) as net_amt from stt_mti_all_tbl_fix_prod
 where year=2024
 group by sp_id ) as a left outer join

 (select sp_id,sum(net_amt) as net_amt from Complete_2years_Wk_Report_bySubChannel_All_Dtl_StockPoint
 where year=2024 and sub_channel='MTI'
 group by sp_id ) as b on a.sp_id=b.sp_id
 where a.net_amt<>b.net_amt
 end