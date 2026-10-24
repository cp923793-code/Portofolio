use AdventureSales
 --- market focus
 select branch_id,mktname,count(*) as cnt into mktmst_dbl
  from mktmst group by branch_id,mktname having count(*)>1

  select *from mktmst_dbl
    select *from custmkttmp
  select *from custmkt
    select *from mktmst

  select branch_id,mktname,'                            ' as mkt_id
   into mkt_focus from mktmst_dbl

  ---truncate table mkt_focus
  -- select *from mktmst
  select a.*,b.mktname from mkt_focus a left outer join mktmst b on a.mkt_id=b.mkt_id 
   where isnull (b.mktname,'')='' --or a.mktname<>b.mktname
    order by branch_id

	      select *from mktmst where mktname like '%pahing%' -- banyak
		  select *from mktmst where mktname like '%belas%'
		  select *from mktmst where mktname like '%pajung%'
		  select *from mktmst where mktname like '%gurem%'
		  select *from mktmst where mktname like '%raton%'  -- banyak
    select *from mktmst where mktname like '%balung%'
			  select *from mktmst where mktname like '%laran%' order by branch_id

  insert into mkt_focus
drop table PsrFocus_2024

  select *from custmkt
  select *from stockpoint where sp_name like '%banjarsari%'
  select a.* from mkt_focus a
   inner join mktmst_dbl b on a.branch_id=b.branch_id and a.mktname=b.mktname

   update mkt_focus set branch_id=ltrim(rtrim(branch_id))
      update mkt_focus set mktname=ltrim(rtrim(mktname))

	  select region,branch_name,depo,depo,depo, a.* from mktmst a
	   left outer join branch b on a.branch_id=b.branch_id
	   order by region,branch_name,depo,depo,depo,mktname

 
     select a.*,region,branch_name,depo,depo,depo from mkt_focus a 
	 left outer join branch b on a.branch_id=b.branch_id
  where not exists
   (select 1 from mktmst b where a.branch_id=b.branch_id and a.mktname=b.mktname)
  order by region,branch_id,mktname 

   delete from mkt_focus where isnull(mktname,'')=''

        select a.* from mkt_focus a
  where not exists
   (select 1 from mktmst_rpl b where a.branch_id=b.branch_id and a.mktname=b.mktname)

   select *from mktmst where mktname like '%banjarsari%'
   select *from mktmst_rpl where mktname like '%bunder%'

      select *from mktmst where mktname like '%larangan%'
   select *from mktmst_rpl where mktname like '%koja%'

         select *from mktmst where mktname like '%kuto%'
   select *from mktmst_rpl where mktname like '%kuto%'

            select *from mktmst where mktname like '%tanjung%'
   select *from mktmst_rpl where mktname like '%tanjung%'

   select *from mktmst where mktname like '%INPRES%'
      select *from mktmst where mktname like '%PD JAYA%'

