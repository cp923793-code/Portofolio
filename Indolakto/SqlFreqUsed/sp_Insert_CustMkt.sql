USE [AdventureSales]
GO
/****** Object:  StoredProcedure [dbo].[sp_Insert_CustMkt1]    Script Date: 10/21/2024 15:39:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create PROCEDURE [dbo].[sp_Insert_CustMkt]
AS
BEGIN
 --select *into CustMktTmp from CustMkt
 --select * from MktMst
 


delete from CustMktTmp where mkt_name like '%not assigned%'

-- insert new market
insert into mktmst
select distinct branch_id,mkt_name,mkt_id
 from custmkttmp a
 where not exists
 (select 1 from mktmst b where a.mkt_id=b.mkt_id)
 order by mkt_id

-- insert new customer
insert into custmkt
select distinct branch_id,sp_id,custd_id,mkt_id
 from custmkttmp a
 where not exists (select 1 from custmkt b where a.mkt_id=b.mkt_id)
 order by mkt_id
 

--into server 10 first
/*
select *from custmkt
select distinct mktname from custmktmst

select *from custmktmst where branch_id='5200/5202'
select *from custmkttmp where branch_id='5200/5202'

select *into custmkttmp_1 from custmkttmp

select *from custmkt
select * from CustMktTmp a
 where not exists
(select 1 from custmktmst b where a.custd_id=b.custd_id)

select a.*,b.MktName as bname,c.mktname as cname from CustMktTmp a
 inner join CustMktMst b on a.custd_id=b.custd_id
 left outer join mktmst c on a.mkt_id=(c.branch_id+'/'+c.mkt_id)
 where mktname like ''%''%''

*/


END

--select *into CustMktMst from MktMst where branch_id='xxx'