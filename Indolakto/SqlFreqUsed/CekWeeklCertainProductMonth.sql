use sales
select sum(net_amt) from sttwk_2023a.dbo.sttwk a left outer join product b on a.prod_id=b.prod_id
 where udf1='CE-POUCH' and branch_id='5200/5203' and month=1