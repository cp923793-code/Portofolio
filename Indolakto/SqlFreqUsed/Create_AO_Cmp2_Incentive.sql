CREATE PROCEDURE [dbo].[Create_AO_Cmp2_Incentive]  AS
--only ao total and group
--AO Calc..no return
if object_id ('dbo.ActiveOutletTotal_Cmp','U') is not null
drop table dbo.ActiveOutletTotal_Cmp
select * into ActiveOutletTotal_cmp from v_activeoutlettotal
 where year_num>2014
update ActiveOutletTotal_Cmp set who_ret='Wholesaler'
 where outlet_type in ('grosir big','grosir small','grosir pareto','grosir medium')

update ActiveOutletTotal_Cmp set who_ret='Retail'
 where outlet_type not like '%mtka%' and outlet_type not in ('grosir big','grosir small','grosir pareto','grosir medium','MTI Supermarket','MTI Minimarket')

update ActiveOutletTotal_Cmp set who_ret='MTKA'
 where outlet_type  like '%mtka%' 

update ActiveOutletTotal_Cmp set who_ret='MTI'
 where outlet_type  like '%mti%' 

update ActiveOutletTotal_Cmp
 set otyp='HS'
 where outlet_type in ('MTKA Hyper','MTKA Super')

update ActiveOutletTotal_Cmp
 set otyp='MM'
 where outlet_type = 'MTKA Minimarket'

update ActiveOutletTotal_Cmp
 set otyp='MTI'
 where outlet_type like '%MTI%'

update ActiveOutletTotal_Cmp
 set otyp='Proxy'
 where outlet_type not like '%MTKA%' and who_ret not like '%mti%'

update ActiveOutletTotal_Cmp 
set dummyarea=distributor_area where isnull(distributor_area,'')<>''
update ActiveOutletTotal_Cmp 
 set dummyarea='CENTRAL & SOUTH SUMATERA' where distributor_city
 not in ('ASLAB','DELI SERDANG','TAPANULI','SIANTAR','ACEH','KISARAN')
 AND distributor_area='SUMATERA'
update ActiveOutletTotal_Cmp 
 set dummyarea='NORTH SUMATERA' where distributor_city
 in ('ASLAB','DELI SERDANG','TAPANULI','SIANTAR','ACEH','KISARAN')
 AND distributor_area='SUMATERA'

update ActiveOutletTotal_Cmp
 set dummyarea='CENTRAL JAVA' where distributor_depo='DIRECT SALES CENTRAL JAVA'
update ActiveOutletTotal_Cmp
 set dummyarea='EAST JAVA' where distributor_depo='DIRECT SALES EAST JAVA'
update ActiveOutletTotal_Cmp
 set dummyarea='WEST JAVA' where distributor_depo='DIRECT SALES WEST JAVA'
update ActiveOutletTotal_Cmp
 set dummyarea='CENTRAL & SOUTH SUMATERA' where distributor_depo
 in ('DIRECT SALES LAMPUNG','DIRECT SALES PALEMBANG')
 update ActiveOutletTotal_Cmp
 set dummyarea='JAKARTA' where distributor_depo='JAKARTA MODERN'


if object_id ('dbo.ActiveOutletGroup_Cmp','U') is not null
drop table dbo.ActiveOutletGroup_Cmp
select * into ActiveOutletGroup_Cmp from v_ActiveOutletGroup
 where year_num>2014

update ActiveOutletGroup_Cmp set who_ret='Wholesaler'
 where outlet_type in ('grosir big','grosir small','grosir pareto','grosir medium')

update ActiveOutletGroup_Cmp set who_ret='Retail'
 where outlet_type not like '%mtka%' and outlet_type not in ('grosir big','grosir small','grosir pareto','grosir medium','MTI Supermarket','MTI Minimarket')

update ActiveOutletGroup_Cmp set who_ret='MTKA'
 where outlet_type  like '%mtka%' 

update ActiveOutletGroup_Cmp set who_ret='MTI'
 where outlet_type  like '%mti%' 

update ActiveOutletGroup_Cmp
 set otyp='HS'
 where outlet_type in ('MTKA Hyper','MTKA Super')

update ActiveOutletGroup_Cmp
 set otyp='MM'
 where outlet_type = 'MTKA Minimarket'

update ActiveOutletGroup_Cmp
 set otyp='MTI'
 where outlet_type like '%MTI%'

update ActiveOutletGroup_Cmp
 set otyp='Proxy'
 where outlet_type not like '%MTKA%' and who_ret not like '%mti%'

update ActiveOutletGroup_Cmp 
set dummyarea=distributor_area where isnull(distributor_area,'')<>''
update ActiveOutletGroup_Cmp 
 set dummyarea='CENTRAL & SOUTH SUMATERA' where distributor_city
 not in ('ASLAB','DELI SERDANG','TAPANULI','SIANTAR','ACEH','KISARAN')
 AND distributor_area='SUMATERA'
update ActiveOutletGroup_Cmp 
 set dummyarea='NORTH SUMATERA' where distributor_city
 in ('ASLAB','DELI SERDANG','TAPANULI','SIANTAR','ACEH','KISARAN')
 AND distributor_area='SUMATERA'

update ActiveOutletGroup_Cmp
 set dummyarea='CENTRAL JAVA' where distributor_depo='DIRECT SALES CENTRAL JAVA'
update ActiveOutletGroup_Cmp
 set dummyarea='EAST JAVA' where distributor_depo='DIRECT SALES EAST JAVA'
update ActiveOutletGroup_Cmp
 set dummyarea='WEST JAVA' where distributor_depo='DIRECT SALES WEST JAVA'
update ActiveOutletGroup_Cmp
 set dummyarea='CENTRAL & SOUTH SUMATERA' where distributor_depo
 in ('DIRECT SALES LAMPUNG','DIRECT SALES PALEMBANG')
 update ActiveOutletGroup_Cmp
 set dummyarea='JAKARTA' where distributor_depo='JAKARTA MODERN'

update activeoutletgroup_cmp set quarter=1 
 where month_num in (1,2,3)
update activeoutletgroup_cmp set quarter=2 
 where month_num in (4,5,6)
update activeoutletgroup_cmp set quarter=3
 where month_num in (7,8,9)
update activeoutletgroup_cmp set quarter=4
 where month_num in (10,11,12)


exec update_Indomarco_dW


 update ActiveOutletTOTAL_cmp
 set distbranch='MITRA SUKSES ABADI' WHERE DISTBRANCH='BINTANG MAS ANUGRAH MAKMUR(BANGKA)'
 update ActiveOutletTOTAL_cmp
 set distbranch='MAXIM SENTOSA' WHERE DISTBRANCH='PD. WIRA SATRIA'

drop table dbo.ActiveOutletTotal_Cmp_brn
Select seqarea,distributor_area,Distbranch,year_num,month_num,indo,sum(act_outlet) as ao,max(seqrpt) as seqrpt
 into ActiveOutletTotal_cmp_brn
 from ActiveOutletTotal_cmp where  isnull(seqarea,0)<>0 and year_num>2011
 group by seqarea,distributor_area,Distbranch,year_num,month_num,indo

 update ActiveOutletTOTAL_cmp_brn
 set distributor_area='OUTER ISLAND',seqarea=8 WHERE DISTBRANCH='INDO PRIMA, CV'
 


/* temporarily not used..for group flavor, use sp Create_AO_GrpFlv instead

if object_id ('dbo.ActiveOutletGrpFlv_Cmp','U') is not null
drop table dbo.ActiveOutletGrpFlv_Cmp
select * into ActiveOutletGrpFlv_Cmp from v_ActiveOutletGrpFlv

update ActiveOutletGrpFlv_Cmp set who_ret='Wholesaler'
 where outlet_type in ('grosir big','grosir small','grosir pareto','grosir medium')

update ActiveOutletGrpFlv_Cmp set who_ret='Retail'
 where outlet_type not like '%mtka%' and outlet_type not in ('grosir big','grosir small','grosir pareto','grosir medium','MTI Supermarket','MTI Minimarket')

update ActiveOutletGrpFlv_Cmp set who_ret='MTKA'
 where outlet_type  like '%mtka%' 

update ActiveOutletGrpFlv_Cmp set who_ret='MTI'
 where outlet_type  like '%mti%' 

update ActiveOutletGrpFlv_Cmp
 set otyp='HS'
 where outlet_type in ('MTKA Hyper','MTKA Super')

update ActiveOutletGrpFlv_Cmp
 set otyp='MM'
 where outlet_type = 'MTKA Minimarket'

update ActiveOutletGrpFlv_Cmp
 set otyp='MTI'
 where outlet_type like '%MTI%'

update ActiveOutletGrpFlv_Cmp
 set otyp='Proxy'
 where outlet_type not like '%MTKA%' and who_ret not like '%mti%'

update ActiveOutletGrpFlv_Cmp 
set dummyarea=distributor_area where isnull(distributor_area,'')<>''
update ActiveOutletGrpFlv_Cmp 
 set dummyarea='CENTRAL & SOUTH SUMATERA' where distributor_city
 not in ('ASLAB','DELI SERDANG','TAPANULI','SIANTAR','ACEH','KISARAN')
 AND distributor_area='SUMATERA'
update ActiveOutletGrpFlv_Cmp 
 set dummyarea='NORTH SUMATERA' where distributor_city
 in ('ASLAB','DELI SERDANG','TAPANULI','SIANTAR','ACEH','KISARAN')
 AND distributor_area='SUMATERA'

update ActiveOutletGrpFlv_Cmp
 set dummyarea='CENTRAL JAVA' where distributor_depo='DIRECT SALES CENTRAL JAVA'
update ActiveOutletGrpFlv_Cmp
 set dummyarea='EAST JAVA' where distributor_depo='DIRECT SALES EAST JAVA'
update ActiveOutletGrpFlv_Cmp
 set dummyarea='WEST JAVA' where distributor_depo='DIRECT SALES WEST JAVA'
update ActiveOutletGrpFlv_Cmp
 set dummyarea='CENTRAL & SOUTH SUMATERA' where distributor_depo
 in ('DIRECT SALES LAMPUNG','DIRECT SALES PALEMBANG')
 update ActiveOutletGrpFlv_Cmp
 set dummyarea='JAKARTA' where distributor_depo='JAKARTA MODERN'


if object_id ('dbo.ActiveOutletGroup_Tiger','U') is not null
drop table dbo.ActiveOutletGroup_Tiger
select * into ActiveOutletGroup_Tiger from v_ActiveOutletGroup_Tiger


--if object_id ('dbo.ActiveOutletGroup_Tiger_Wk','U') is not null
--drop table dbo.ActiveOutletGroup_Tiger_Wk
--select * into ActiveOutletGroup_Tiger from v_ActiveOutletGroup_Tiger_Weekly

*/
GO
