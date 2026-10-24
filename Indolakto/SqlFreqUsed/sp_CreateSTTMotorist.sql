USE [sales_bak]
GO
/****** Object:  StoredProcedure [dbo].[sp_CreateSTTMotorist_NoDrop]    Script Date: 09/18/2024 19:43:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create PROCEDURE [dbo].[sp_CreateSTTMotorist]

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
    declare @week as smallint; 
set @week=(select cwk from begmonth);
    declare @month as smallint; 
set @month=(select mth from begmonth);
    declare @year as smallint; 
set @year=(select yr_num from begmonth);
	SET NOCOUNT ON;
--select distinct year,week from sales2.dbo.SttMotorist order by year,week
delete from  sales2.dbo.SttMotorist where year>=@year and week>=@week
insert into sales2.dbo.SttMotorist
select a.*,b.sls_type,c.type_outlet,d.region,d.branch_name, 
 e.psub_id,f.psub_id1 
 from sttwk1a1_24 a
 left outer join slsman b on 
  rtrim(a.branch_id)+ '/'+rtrim(a.sp_id)+'/'+rtrim(a.sls_id)  =b.sls_id_full
 left outer join customerdist_1910a c on a.custd_id=c.custd_id
 left outer join branch d on a.branch_id=d.branch_id
 left outer join product e on a.prod_id=e.prod_id
 left outer join prodcat f on e.text_id=f.psub_id
 where sls_type='motorist' and year>=@year and week>=@week

/*
drop table v_MtrCbWk_tbl 
select * into v_MtrCbWk_tbl 
 from v_MtrCBWk

drop table v_MtrCbMt_tbl 
select * into v_MtrCbMt_tbl 
 from v_MtrCBMt

drop table v_MtrCbRs_tbl 
select * into v_MtrCbRs_tbl 
 from v_MtrCBRs
*/
delete from  v_MotoristSTT_tbl where year>=@year and week>=@week
insert into v_MotoristSTT_tbl 
select * 
 from v_MotoristSTT where year>=@year and week>=@week

END

--exec sp_Createsales2.dbo.SttMotorist_NoDrop
--select distinct year,week from  v_MotoristSTT_tbl order by year,week