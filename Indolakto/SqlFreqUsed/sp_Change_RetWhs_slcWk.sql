USE [AdventureSales]
GO
/****** Object:  StoredProcedure [dbo].[sp_Create_STT_CB_Strata_SKM_Sch_Fly_23_24_Monthly]    Script Date: 07/03/2025 11:56:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
alter PROCEDURE [dbo].[sp_Change_RetWhs_slcWk]

AS
BEGIN
   declare @week as smallint;
set @week=(select cwk from begmonth);
   declare @mth as smallint;
set @mth=(select mth from begmonth);
   declare @year as smallint;
set @year=(select yr_num from begmonth);
-- select *from strataClass order by strata

--select distinct strata,retwhs from adventuresales_lower2019.dbo.v_U180_Yr_slsId_Strata_sum_tbl_mrg  order by strata
-- all uht180 yearly
  update adventuresales_lower2019.dbo.v_U180_Yr_slsId_Strata_sum_tbl_mrg-- weekly sachet
set
  RetWhs=b.RetWhs
from
  adventuresales_lower2019.dbo.v_U180_Yr_slsId_Strata_sum_tbl_mrg a
  inner join strataClass b  on a.Strata=b.strata
     where year=@year --and week>=@week

--select distinct strata,retwhs from adventuresales_lower2019.dbo.STT_Strata_U180_withCB_Mth_23_24  order by strata
-- all uht180 monthly
  update adventuresales_lower2019.dbo.STT_Strata_U180_withCB_Mth_23_24-- weekly sachet
set
  RetWhs=b.RetWhs
from
  adventuresales_lower2019.dbo.STT_Strata_U180_withCB_Mth_23_24 a
  inner join strataClass b  on a.Strata=b.strata
     where year=@year and month>=@mth

--select distinct strata,retwhs from adventuresales_lower2019.dbo.v_U180a_Strata_sum_tbl_mrg  order by strata
-- all uht180 weekly
  update adventuresales_lower2019.dbo.v_U180a_Strata_sum_tbl_mrg-- weekly sachet
set
  RetWhs=b.RetWhs
from
  adventuresales_lower2019.dbo.v_U180a_Strata_sum_tbl_mrg a
  inner join strataClass b  on a.Strata=b.strata
     where year=@year and week>=@week
 

-- all sachet weekly (sachet)
  update adventuresales_lower2019.dbo.v_SCM_Sch_fly_Wk_Strata -- weekly sachet
set
  RetWhs=b.RetWhs
from
  adventuresales_lower2019.dbo.v_SCM_Sch_fly_Wk_Strata a
  inner join strataClass b  on a.Strata=b.strata
   where year=@year and week>=@week
-- skm flav weekly (imc,imp)

update adventuresales_lower2019.dbo.v_SCMb_Flav_Wk_Strata_sum_tbl_mrg -- weekly sachet
set
  RetWhs=b.RetWhs
from
  adventuresales_lower2019.dbo.v_SCMb_Flav_Wk_Strata_sum_tbl_mrg a
  inner join strataClass b  on a.Strata=b.strata
   where year=@year and week>=@week
  -- scm weekly by group product (im-sch, dll)
    update adventuresales_lower2019.dbo.v_SCMb_Strata_sum_tbl_mrg -- weekly sachet
set
  RetWhs=b.RetWhs
from
  adventuresales_lower2019.dbo.v_SCMb_Strata_sum_tbl_mrg a
  inner join strataClass b  on a.Strata=b.strata
   where year=@year and week>=@week
  /*
  select distinct strata from adventuresales_lower2019.dbo.v_SCMb_Strata_sum_tbl_mrg a
   where not exists
   (select 1 from strataClass b where a.strata=b.strata)
  */

  -- scm monthly by group product (im-sch, dll)
  -- v_SCMb_Strata_sum_tbl_mrg 
  update adventuresales_lower2019.dbo.v_SCMb_mth_Strata_sum_tbl_mrg -- monthly sachet 
set
  RetWhs=b.RetWhs
from
  adventuresales_lower2019.dbo.v_SCMb_mth_Strata_sum_tbl_mrg a
  inner join strataClass b  on a.Strata=b.strata
    where year=@year and month>=@mth
-- kids monthly
  update adventuresales_lower2019.dbo.v_KIDSa_slsId_Mth_Strata_2_sum_tbl_mrg -- weekly sachet
set
  RetWhs=b.RetWhs
from
  adventuresales_lower2019.dbo.v_KIDSa_slsId_Mth_Strata_2_sum_tbl_mrg a
  inner join strataClass b  on a.Strata=b.strata
   where year=@year and month>=@mth
  --- kids weekly
  update adventuresales_lower2019.dbo.v_KIDS_slsId_Strata_2_sum_tbl_mrg -- weekly kids
set
  RetWhs=b.RetWhs
from
  adventuresales_lower2019.dbo.v_KIDS_slsId_Strata_2_sum_tbl_mrg a
  inner join strataClass b  on a.Strata=b.strata
    where year=@year and week>=@week
-- kids yearly
  update adventuresales_lower2019.dbo.v_kids_Yr_slsId_Strata_sum_tbl_mrg -- weekly sachet
set
  RetWhs=b.RetWhs
from
  adventuresales_lower2019.dbo.v_kids_Yr_slsId_Strata_sum_tbl_mrg a
  inner join strataClass b  on a.Strata=b.strata
    where year=@year
  -- sci
    update adventuresales_lower2019.dbo.v_SCI_Stc_Mk_Wk_Strata_sum_tbl_mrg -- weekly sachet
set
  RetWhs=b.RetWhs
from
  adventuresales_lower2019.dbo.v_SCI_Stc_Mk_Wk_Strata_sum_tbl_mrg a
  inner join strataClass b  on a.Strata=b.strata
   where year=@year and week>=@week
  --- kids weekly by product
  update adventuresales_lower2019.dbo.v_KIDSa_Flav_slsId_wk_Strata_2_sum_tbl_mrg -- weekly sachet
set
  RetWhs=b.RetWhs
from
  adventuresales_lower2019.dbo.v_KIDSa_Flav_slsId_wk_Strata_2_sum_tbl_mrg  a
  inner join strataClass b  on a.Strata=b.strata
   where year=@year and week>=@week

-- select *from strataclass order by retwhs
-- select distinct retwhs,strata from adventuresales_lower2019.dbo.v_KIDSa_Flav_slsId_wk_Strata_2_sum_tbl_mrg where retwhs not in ('Retail','Whs','Semi Whs')
-- select distinct retwhs,strata from adventuresales_lower2019.dbo.v_SCI_Stc_Mk_Wk_Strata_sum_tbl_mrg where retwhs not in ('Retail','Whs','Semi Whs')
-- insert into strataClass values ('6) 100 ctn - 199 ctn','Whs')
-- insert into strataClass values ('7) =>200 ctn','Whs')
-- insert into strataClass values ('5) 51 ctn - 100 ctn','Whs')
-- insert into strataClass values ('6) > 100 ctn','Whs')
-- insert into strataClass values ('8) =>1000 ctn','Whs')
-- insert into strataClass values ('7) 500 ctn - 999 ctn','Whs')
-- insert into strataClass values ('6) 200 ctn - 499 ctn','Whs')
-- insert into strataClass values ('3a) 3 ctn - 5 ctn','Retail')
-- insert into strataClass values ('2) 1 ctn - 2 ctn','Retail')
-- insert into strataClass values ('1) 0.25 ctn - 1 ctn','Retail')
-- insert into strataClass values ('1a) < 0.25 ctn','Retail')
-- insert into strataClass values ('5) 51 ctn - 100 ctn','Whs')
-- insert into strataClass values ('5) =>51 ctn','Whs')
-- insert into strataClass values ('5) 51 ctn - 199 ctn','Whs')
-- insert into strataClass values ('6) > 100 ctn','Whs')
-- insert into strataClass values ('9) =>50 ctn','Whs')
-- insert into strataClass values ('1) 0.3 ctn - 1 ctn','Retail')
-- insert into strataClass values ('1) 0.3 ctn - 1 ctn','Retail')
-- insert into strataClass values ('1) 0.3 ctn - 1 ctn','Retail')
-- select distinct retwhs from adventuresales_lower2019.dbo.v_SCMb_mth_Strata_sum_tbl_mrg
-- truncate table reprocesssp  insert into reprocesssp values ('5224/032',10)  -- select *from reprocesssp
-- insert into reprocesssp select distinct sp_id,week from sttwk_2025a a where not exists (select 1 from stockpoint b where a.sp_id=b.sp_id) 
--  select distinct sp_id,week from sttwk_2025a a where not exists (select 1 from Complete_2years_Wk_Report_bySubChannel_All_Dtl_StockPoint b where a.sp_id=b.sp_id) 
-- delete from Complete_2years_Wk_Report_bySubChannel_All_Dtl_StockPoint where isnull(sp_id,'')=''
-- select *from   customerdistributorlist where [customer name] like '%family mart%' and branch_id like '5200%'

END