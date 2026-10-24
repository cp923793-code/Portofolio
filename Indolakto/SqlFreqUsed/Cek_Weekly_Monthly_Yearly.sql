select distinct udf1,product,prod_name from custmanprod.dbo.product

select distinct udf1,product,prod_name from sales.dbo.product
select distinct udf1,product,prod_name from widjakb001.basetable.dbo.product_svr55

select * from  widjakb001.basetable.dbo.product_svr55 order by text_id


select * into sales.dbo.product_bak_250722 from sales.dbo.product
truncate table sales.dbo.product

insert into widjakb001.basetable.dbo.product_svr55
select * from custmanprod.dbo.product

select year,week,sum(net_qty) from sttwk_2024d.dbo.sttwk group by year,week
 order by year,week

select year,week,sum(net_qty) from sttwk_2024 group by year,week
 order by year,week

use sales
select year,month,sum(net_qty) from sttmt_2023.dbo.sttmt group by year,month
 order by year,month

select year,month,sum(net_qty) from sttmt_2024.dbo.sttmt group by year,month
 order by year,month

select year,month,week,sum(net_qty) from sttwk_tmp.dbo.sttmttmp   
 group by year,month,week
 order by year,month,week

select year,month,week,sum(net_qty) from sttwk_2024d.dbo.sttwk
 group by year,month,week
 order by year,month,week

select year,month,week,sum(net_qty) from sttwk_tmp.dbo.sttmttmp
 group by year,month,week
 order by year,month,week

select year,month,week,sum(net_qty) from sttwk_tmp.dbo.sttwktmp1
 group by year,month,week
 order by year,month,week
-- truncate table sttwk_tmp.dbo.sttwktmp1
-- insert into sttwk_tmp.dbo.sttmttmp select *from   sttwk_tmp.dbo.sttwktmp1
-- delete from sttwk_2024d.dbo.sttwk where week in (48,49)
-- insert into sttwk_2024d.dbo.sttwk select *from sttwk_tmp.dbo.sttmttmp

select year,month,week,sum(net_qty) from sttwk_tmp.dbo.sttmttmp
 group by year,month,week
 order by year,month,week

select year,month,week,sum(net_qty) from sttwk_2024d.dbo.sttwk where week>47
 group by year,month,week
 order by year,month,week
 
insert  into sttmt_2024.dbo.sttmt
select branch_id,sp_id,custd_id,prod_id,sls_id,year,month,sum(net_qty) as net_qty,sum(net_amt) as net_amt
 ,sum(grs_qty) as grs_qty,sum(grs_amt) as grs_amt,sum(rtn_qty) as rtn_qty,sum(rtn_amt) as rtn_amt
from sttwk_tmp.dbo.sttmttmp
 group by branch_id,sp_id,custd_id,prod_id,sls_id,year,month

insert  into sttmt_2024b.dbo.sttmt
select *from sttmt_2024a.dbo.sttmt where month=6

SELECT     branch_id, sp_id, custd_id, prod_id, sls_id, year, sum(net_qty) as net_qty, sum(net_amt) as net_amt
into sttyr2.dbo.sttyr_23
 FROM         sttmt_2023.dbo.sttmt 
 group by branch_id, sp_id, custd_id, prod_id, sls_id, year

insert into widjakb001.adventuresales.dbo.sttyr_20
select * from sttyr1.dbo.sttyr_20

insert into widjakb001.adventuresales.dbo.sttyr_21
select * from sttyr1.dbo.sttyr_21

insert into widjakb001.adventuresales.dbo.sttyr_22
select * from sttyr1.dbo.sttyr_22

insert into widjakb001.adventuresales.dbo.sttyr_25_yoy
select * from sttyr_25_yoy  