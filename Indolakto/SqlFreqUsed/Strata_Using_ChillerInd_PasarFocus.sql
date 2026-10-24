select count(*) from customerdist_1910a where chiller='Y'
select count(*) from chiller_independen a
 where exists (select 1 from customerdist_1910a b where a.custd_id=b.kode_iap)

select custd_id,count(*) from chiller_independen group by custd_id having count(*)>1