USE [AdventureSales]
GO
/****** Object:  StoredProcedure [dbo].[sp_CreateKidProdRepeat_FvMths]    Script Date: 03/06/2025 16:21:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
create PROCEDURE [dbo].[sp_CreateKidProdRepeat_FvMths]  -- 1 minute
	-- Add the parameters for the stored procedure here
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

drop table adventuresales_lower2019.dbo.v_Outlet_KidProd_Qtr_tbl  -- select * from v_Outlet_KidProd_Qtr_tbl
select * into adventuresales_lower2019.dbo.v_Outlet_KidProd_Qtr_tbl
 from v_Outlet_KidProd_FvMths 
 
drop table adventuresales_lower2019.dbo.v_Outlet_KidProd_STT_Qtr_tbl  -- select sum(net_qty) from v_Outlet_KidProd_STT_Qtr_tbl
select * into adventuresales_lower2019.dbo.v_Outlet_KidProd_STT_Qtr_tbl
 from v_Outlet_KidProd_STT_FvMths  -- select sum(net_qty) from v_Outlet_KidProd_STT_FvMths

-- select *into qtrtbl4 from qtrtbl1
-- select sum(net_qty) from uhtoth.dbo.sttwk1a_Kid
-- select distinct udf1  from uhtoth.dbo.sttwk1a_Kid a left outer join product_svr55 b on a.prod_id=b.prod_id and udf1='Kid' 

drop table adventuresales_lower2019.dbo.v_Outlet_KidProd_Qtr_Rpt_tbl_a
select a.*,b.net_qty,b.net_amt into adventuresales_lower2019.dbo.v_Outlet_KidProd_Qtr_Rpt_tbl_a
 from adventuresales_lower2019.dbo.v_Outlet_KidProd_Qtr_tbl a 
 inner join adventuresales_lower2019.dbo.v_Outlet_KidProd_STT_Qtr_tbl b on a.custd_id=b.custd_id
 and a.year=b.year and a.FvMth=b.qtr  and a.psub_id=b.psub_id
 
END
/*
select distinct sp_id,week from Complete_2Years_Wk_Report_bySubChannel_All_Dtl_StockPoint where isnull(channel,'')=''
select * from v_Outlet_KidProd_STT_Qtr_tbl a
 where exists
(select 1 from
(select custd_id,year,qtr,count(*) as cnt from v_Outlet_KidProd_STT_Qtr_tbl
 group by custd_id,year,qtr having count(*)>1)  as b
 where a.custd_id=b.custd_id and a.year=b.year and a.qtr=b.qtr)
*/
--select *from sales.dbo.product where text_id like 'CEC%' order by text_id