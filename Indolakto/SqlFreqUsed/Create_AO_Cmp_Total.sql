alter PROCEDURE [dbo].[Create_AO_Cmp_Total]  AS
--only ao total and group
--AO Calc..no return
--select *from ActiveOutletTotal_Cmp order by year_num,month_num 
--select *into ActiveOutletTotal_Cmp_bak from ActiveOutletTotal_Cmp
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

exec Update_Indomarco_DW_TotalCmp

GO
