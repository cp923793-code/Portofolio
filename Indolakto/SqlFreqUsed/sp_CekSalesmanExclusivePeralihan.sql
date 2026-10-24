insert into slsexc.dbo.sttwk1c
select count(*) from  sttwk1c
 where branch_id in ('5200/5206','5200/5207','5200/5227')
  and year>2022

  select *from AdventureSales_lower2019.dbo.slsexc_chlprn6
   where sp_id_org like '5206%' order by sp_id_org,year,week

     select *from AdventureSales_lower2019.dbo.slsexc_chlprn6
   where sp_id_org like '5206%' and week >43 and year=2023  order by sp_id_org,year,week

   delete from AdventureSales_lower2019.dbo.slsexc_chlprn6 where sp_id_org='5206/002' and year=2024 and sls_id_org='S028'
    delete from AdventureSales_lower2019.dbo.slsexc_chlprn6 where sp_id_org='5206/002' and year=2023 and sls_id_org='S028' and week>43
	delete from AdventureSales_lower2019.dbo.slsexc_chlprn6 where sp_id_org='5206/004' and year=2023 and sls_id_org='S033' and week>43
	delete from AdventureSales_lower2019.dbo.slsexc_chlprn6 where sp_id_org='5206/032' and year=2023 and sls_id_org='S055' and week>43 and sls_type='Exclusive Non Noodle'
	delete from AdventureSales_lower2019.dbo.slsexc_chlprn6 where sp_id_org='5206/032' and year=2023 and sls_id_org='S055' and week in (45,52) 
	delete from AdventureSales_lower2019.dbo.slsexc_chlprn6 where sp_id_org='5206/032' and year=2023 and sls_id_org='S055' and week in (47,48)
	delete from AdventureSales_lower2019.dbo.slsexc_chlprn6 where sp_id_org='5206/032' and year=2023 and sls_id_org='S055' and week in (46,51)
	delete from AdventureSales_lower2019.dbo.slsexc_chlprn6 where sp_id_org='5206/032' and year=2023 and  week>43 and sls_type='Exclusive Non Noodle'
	  --delete from AdventureSales_lower2019.dbo.slsexc_chlprn6 where sp_id_org like '5206%' and year=2023   and week>43
	  --insert into AdventureSales_lower2019.dbo.slsexc_chlprn6 select *from slsexc_chlprn6 where sp_id_org like '5206%' and year=2023   and week>43
	  --insert into AdventureSales_lower2019.dbo.slsexc_chlprn6 select *from slsexc_chlprn6  where sp_id_org='5206/032' and year=2023 and sls_id_org='S055' and week>43
	  --insert into AdventureSales_lower2019.dbo.slsexc_chlprn6 select *from slsexc_chlprn6 where sp_id_org='5206/032' and year=2023 and sls_id_org='S055' and week in (46)
   select *from slsman_hst where (sls_name like '%ARDIAN%'or sls_id='S028') and sp_id like '5206%'
    order by sp_id,sls_id,year,week