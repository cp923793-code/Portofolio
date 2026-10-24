use ILO
-- insert monthly premium
GO
/****** Object:  StoredProcedure [dbo].[sp_CreateChillerIndependenOutlet_2yrs]    Script Date: 24/01/2025 17:42:46 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- drop procedure sp_CreateWeeklyReport_Dtl_StockPoint_MktName_DiscB_NoDrop
create PROCEDURE [dbo].[sp_Insert_SellOut_SellIn_Srv_Idm]  AS
Begin
exec sp_InsertMonthlySell_Prem_Idm
--ILO
drop table idm_ilo_tmp
--select * into idm_ilo_tmp from idm_ilo_1516
--select * from ILO_Sell_Out_tmp
select * into idm_ilo_tmp from ILO_Sell_Out_tmp -- mumu problem

-- sell out
-- select distinct year,month from ilo_mt order by year desc,month desc
insert into ILO_MT
select 'INDOMARET' as acc,'INDOLAKTO' as Div,left(rtrim(status),50),[year],[month],left(rtrim(item),80),rtrim(branch),rtrim(dc),sum(qty) as qty,sum(idr) as idr
 from idm_ilo_tmp  -- drop table idm_ilo_tmp
 group by status,[year],[month],item,branch,dc
-- select *from ilo_mt where year=2022 and month=6
--select distinct depo from sales.dbo.stockpoint where branch_id='5200/5214'

--Sell_In ILO
--runcate table ilo_mt_sell_in
--select * into ILO_MT_Sell_In from ILO_MT for create table
drop table idm_ilo_tmp
select * into idm_ilo_tmp from ILO_Sell_In_tmp

-- Sell in
insert into ILO_MT_Sell_In
select 'INDOMARET' as acc,'INDOLAKTO' as Div,left(rtrim(status),50),[year],[month],left(rtrim(item),80),rtrim(branch),rtrim(dc),
 sum(Recqty) as Recqty,sum(Rtnqty) as Rtnqty,sum(netqty) as netqty,sum(Recamt) as Recamt,sum(Rtnamt) as Rtnamt,sum(netamt) as netamt
 from idm_ilo_tmp
 group by status,[year],[month],item,branch,dc

insert into ilo_mt
select *from
(select keyacc,division,status,year,month,item,branch,dc,sum(netqty) as netqty, sum(netamt) as netamt
 from ilo_mt_sell_in
 group by keyacc,division,status,year,month,item,branch,dc) as a
 where not exists
 (select 1 from ilo_mt b where a.keyacc=b.keyacc and a.division=b.division and a.status=b.status
   and a.year=b.year and a.month=b.month and a.item=b.item and a.branch=b.branch and a.dc=b.dc)


---delete from ilo_mt_sell_in where year=2018 and month between 1 and 4 and keyacc='INDOMARET' and division='INDOLAKTO'  


/*
--IKSM

drop table idm_ilo_tmp
select * into idm_ilo_tmp from iksm_Sell_out_tmp
--select *from idm_ilo_tmp
delete from idm_ilo_tmp where isnull(status,'')=''

--select *from idm_ilo_tmp
-- delete from ilo_mt where division='indokuat' and year=2022 and month=10 and status='Sell Out'
insert into ILO_MT
select 'INDOMARET' as acc,'INDOKUAT' as Div,left(rtrim(status),50),[year],[month],left(rtrim(item),80),rtrim(branch),rtrim(dc),sum(qty) as qty,sum(idr) as idr
 from idm_ilo_tmp
 group by status,[year],[month],item,branch,dc

--Sell_In IKSM

drop table idm_ilo_tmp
select * into idm_ilo_tmp from iksm_Sell_In_tmp
--select *from idm_ilo_tmp

insert into ILO_MT_Sell_In
select 'INDOMARET' as acc,'INDOKUAT' as Div,left(rtrim(status),50),[year],[month],left(rtrim(item),80),rtrim(branch),rtrim(dc),
 sum(Recqty) as Recqty,sum(Rtnqty) as Rtnqty,sum(netqty) as netqty,sum(Recamt) as Recamt,sum(Rtnamt) as Rtnamt,sum(netamt) as netamt
 from idm_ilo_tmp
 group by status,[year],[month],item,branch,dc

*/

--ICE Cream


drop table idm_ilo_tmp
--select *from idm_ilo_tmp
select * into idm_ilo_tmp from ice_sell_out_tmp

insert into ILO_MT
select 'INDOMARET' as acc,'INDOESKRIM' as Div,left(rtrim(status),50),[year],[month],left(rtrim(item),80),rtrim(branch),rtrim(dc),sum(qty) as qty,sum(idr) as idr
 from idm_ilo_tmp
 group by status,[year],[month],item,branch,dc


--Sell_In Ice Cream
--select *from idm_ilo_tmp
--delete from idm_ilo_tmp where isnull(year,0)=0
drop table idm_ilo_tmp
select * into idm_ilo_tmp from ice_sell_in_tmp

--delete from idm_ilo_tmp
-- where isnull(branch,'')=''

--select *from ILO_MT_Sell_In where year=2022 and month=6

insert into ILO_MT_Sell_In
 select * from 
(select 'INDOMARET' as Keyacc,'INDOESKRIM' as Division,left(rtrim(status),50) as Status,[year],[month],left(rtrim(item),80) as item,
 rtrim(branch) as branch,rtrim(dc) as dc,
 sum(Recqty) as Recqty,sum(Rtnqty) as Rtnqty,sum(netqty) as netqty,sum(Recamt) as Recamt,sum(Rtnamt) as Rtnamt,sum(netamt) as netamt
 from idm_ilo_tmp
 group by status,[year],[month],item,branch,dc) as a
 where not exists
 (select 1 from ilo_mt_sell_in b where a.keyacc=b.keyacc and a.division=b.division and a.status=b.status
   and a.year=b.year and a.month=b.month and a.item=b.item and a.branch=b.branch and a.dc=b.dc)

--delete from ilo_mt_sell_in
-- where status='Sell In' and year=2021 and month=8 and division='indoeskrim'


--DELETE from ilo_mt where division='INDOESKRIM' and status='Sell In' and year=2020 and month in (11)
--delete from ilo_mt_sell_in where division='INDOESKRIM' and status='Sell In' and year=2018 and month in (2,3,4)
insert into ilo_mt
select *from
(select keyacc,division,status,year,month,item,branch,dc,sum(netqty) as netqty, sum(netamt) as netamt
 from ilo_mt_sell_in
 group by keyacc,division,status,year,month,item,branch,dc) as a
 where not exists
 (select 1 from ilo_mt b where a.keyacc=b.keyacc and a.division=b.division and a.status=b.status
   and a.year=b.year and a.month=b.month and a.item=b.item and a.branch=b.branch and a.dc=b.dc)


---ini dia 
--select *from ilo_SrvLvl_tmp
update ilo_SrvLvl_tmp set brand='IM'
--drop table idmsrvlvl 
insert into idmsrvlvl 
 select *,'INDOMARET' from ilo_SrvLvl_tmp

--select *from idm_ilo_2021_10_S$
delete from ilo_srvLvl_tmp where isnull(year,'')=''

update iksm_srvlvl_tmp set brand='MK'

-- select *from idmsrvlvl where year=2022 and month=6 and brand='MK'
insert into idmsrvlvl 
 select *,'INDOMARET' from  iksm_srvlvl_tmp


---DC Fix Space

update idm_ilo_tmp set dc=ltrim(dc)
--select distinct rtrim(ltrim(DC)) from ilo_mt order by rtrim(ltrim(dc))
update ilo_mt set dc=ltrim(dc)

update srvlvl_IM_mk set dc=ltrim(dc)

update ilo_mt_sell_in set dc=ltrim(dc)

update idmsrvlvl set dc=ltrim(dc)

-------------- DLL if needed only
--truncate table mt_product
Select *from mt_product where isnull(kode_sub,'')='' or namaproduct like '%545%'
insert into mt_product
select distinct item as NamaProduct, ' ' as kode_sub, ' ' as product, ' ' as prodgrp,' ' as prod_sub,'' as PLU --into MT_Product
   from ilo_mt a
 where not exists
(select 1 from mt_product b where a.item=b.namaproduct)

insert into mt_product
select distinct item as NamaProduct, ' ' as kode_sub, ' ' as product, ' ' as prodgrp,' ' as prod_sub,'' as PLU --into MT_Product
   from idmsrvlvl a
 where not exists
(select 1 from mt_product b where a.item=b.namaproduct)

select distinct item from idmsrvlvl a
 where not exists
 (select 1 from mt_product b where a.item=b.namaproduct)


select distinct item from idmsrvlvl a
 where not exists
 (select 1 from mt_product b where a.item=b.product)

--cek new product
select *from mt_product where isnull(kode_sub,'')='' or kode_sub like 'IM%' or namaproduct like '%ice%' or namaproduct like 'cap en%'
 order by namaproduct

update mt_product set product=namaproduct where isnull(product,'')=''
select *from mt_product where product like '%)'
update mt_product set product=replace(product,right(product,11),'') where product like  '%)'

update idmsrvlvl set item='INDOMILK, SUSU CAIR UHT FULL CREAM / VANILLA TPK 190mL'
 where item='INDOMILK, SUSU CAIR UHT FULL CREAM / VANILLA TPK 1'

update idmsrvlvl set item='INDOMILK, SUSU CAIR UHT GOOD TO GO CHOCO AVOCADO TPK 250mL'
 where item='INDOMILK, SUSU CAIR UHT GOOD TO GO CHOCO AVOCADO T'

update idmsrvlvl set item='INDOMILK, SUSU CAIR UHT CHOCOLATE JAVA CRIOLLO TPK 190mL'
 where item='INDOMILK, SUSU CAIR UHT CHOCOLATE JAVA CRIOLLO TPK'

update idmsrvlvl set item='INDOMILK, SUSU CAIR UHT GOOD TO GO BANANA BERRY TPK 250mL'
 where item='INDOMILK, SUSU CAIR UHT GOOD TO GO BANANA BERRY TP'

select *from sales.dbo.product where psub_id='STC189'
select *from MT_Product WHERE ISNULL(PRODGRP,'')=''
select *from MT_Product WHERE namaproduct like '%steril%'
select distinct prodgrp from mt_product
--KODE GROOUP PRODUCT
update mt_product set prodgrp='YOGHURT'
 where namaproduct like '%YOG%' and isnull(prodgrp,'')=''
update mt_product set prodgrp='SKM'
 where namaproduct like '%KENTAL%' and isnull(prodgrp,'')=''
update mt_product set prodgrp='STC'
 where namaproduct like '%steril%' and isnull(prodgrp,'')=''
update mt_product set prodgrp='SCI'
 where namaproduct like '%CAIR%' and isnull(prodgrp,'')=''
update mt_product set prodgrp='UHT'
 where namaproduct like '%UHT%'	and isnull(prodgrp,'')=''
update mt_product set prodgrp='UHT'
 where namaproduct like '%UHT%'	and prodgrp='SCI'
update mt_product set prodgrp='UHT'
 where namaproduct like '%950M%' and isnull(prodgrp,'')=''
update mt_product set prodgrp='UHT'
 where namaproduct like '%250%' and isnull(prodgrp,'')=''
update mt_product set prodgrp='POWDER'
 where namaproduct like '%BUBUK%'	and isnull(prodgrp,'')=''
update mt_product set prodgrp='PLM'
 where namaproduct like '%PLM%' and isnull(prodgrp,'')=''
update mt_product set prodgrp='BTR'
 where namaproduct like '%BUTTER%' and isnull(prodgrp,'')=''
update mt_product set prodgrp='Milkuat' 
 where namaproduct like '%MILKUAT%' and isnull(prodgrp,'')=''
update mt_product set prodgrp='ICE'
 where namaproduct like '%ESKRIM%' and isnull(prodgrp,'')=''
update mt_product set prodgrp='ICE'
 where namaproduct like '%ICE CREAM%' and isnull(prodgrp,'')=''
update mt_product set prodgrp='ICE'
 where namaproduct like '%ESPES%' and isnull(prodgrp,'')=''
update mt_product set prodgrp='ICE'
 where namaproduct like '%NUSANTA%' and isnull(prodgrp,'')=''

---KODE SUB GROUP PRODUCT
select *from MT_Product WHERE ISNULL(kode_sub,'')=''
select distinct kode_sub from mt_product order by kode_sub
select *from MT_Product WHERE PRODGRP='Milkuat' and isnull(kode_sub,'')=''
select *from MT_Product WHERE PRODGRP='Milkuat' and isnull(kode_sub,'')<>''
select *from MT_Product WHERE kode_sub='Bottle 180'
select *from MT_Product WHERE kode_sub='UHT180'
select *from MT_Product WHERE kode_sub='BULK ICE'
select distinct kode_sub from mt_product
update mt_product set kode_sub='YOG-POUCH'
 where namaproduct like '%kids yogurt%'  -- please see description of the product first
update mt_product set kode_sub='Bottle 180'
 where namaproduct like '%180m%'
update mt_product set kode_sub='UHT180'
 where namaproduct like '%180m%' and prodgrp='UHT'
update mt_product set kode_sub='STC 189'
 where namaproduct like '%steril%'
update mt_product set kode_sub='Bottle 130'
 where namaproduct like '%130m%'
update mt_product set kode_sub='Bottle 70'
 where namaproduct like '%70m%'
update mt_product set kode_sub='Tiger'
 where namaproduct like '%170m%' or namaproduct like '%tiger%' or namaproduct like '%95m%' or namaproduct like '%180m%'
update mt_product set kode_sub='Tetra'
 where namaproduct like '%Tetra%' or namaproduct like '%125m%'
update mt_product set kode_sub='Pouch'
 where namaproduct like '%freezy%'
update mt_product set kode_sub='Energ'
 where namaproduct like '%350%'
update mt_product set kode_sub='Yogurt'
 where namaproduct like '%yogurt%'

---skm
select *from MT_Product WHERE ISNULL(kode_sub,'')=''
select *from MT_Product WHERE PRODGRP='SKM' and isnull(kode_sub,'')=''
select *from MT_Product WHERE PRODGRP='SKM' and isnull(kode_sub,'')<>''
update mt_product set kode_sub='CE-SCH'
 where namaproduct like '%enak%' and namaproduct like '%37g%' and isnull(kode_sub,'')=''
update mt_product set kode_sub='CE-CAN'
 where namaproduct like '%enak%' and (namaproduct like '%KLG%' or namaproduct like '%tps%') and isnull(kode_sub,'')=''
update mt_product set kode_sub='IM-CAN'
 where namaproduct like '%indomilk%' and (namaproduct like '%KLG%' or namaproduct like '%tps%') 
   and isnull(kode_sub,'')=''
update mt_product set kode_sub='IM-SCH'
 where namaproduct like '%INDOMIL%' and namaproduct like '%PCK%'
update mt_product set kode_sub='KREMER-C'
 where namaproduct like '%KREMER%' and (namaproduct like '%KLG%' or namaproduct like '%tps%')
update mt_product set kode_sub='TS-CAN'
 where namaproduct like '%TIGA S%' and (namaproduct like '%KLG%' or namaproduct like '%tps%')
update mt_product set kode_sub='IM-SCH'
 where namaproduct like '%INDOMIL%' and namaproduct like '%PCK%'
update mt_product set kode_sub='IM-POUCH'
 where namaproduct like '%INDOMIL%' and namaproduct like '%PCH%'

---sci, UHT
select *from MT_Product WHERE ISNULL(kode_sub,'')=''
select *from MT_Product WHERE PRODGRP='SCI' and isnull(kode_sub,'')=''
select *from MT_Product WHERE PRODGRP='UHT' and isnull(kode_sub,'')=''
select *from MT_Product WHERE PRODGRP='SCI' and isnull(kode_sub,'')<>''
select *from MT_Product WHERE kode_sub='SCI190'
update mt_product set kode_sub='SCI190'
 where namaproduct like '%susu cair%' and namaproduct like '%190%' and isnull(kode_sub,'')=''
update mt_product set kode_sub='UHT190'
 where namaproduct like '%susu cair UHT%' and namaproduct like '%190%'
update mt_product set kode_sub='UHT180'
 where namaproduct like '%susu cair UHT%' and namaproduct like '%180%'
update mt_product set kode_sub='KIDS'
 where namaproduct like '%susu cair UHT%' and namaproduct like '%115%' and isnull(kode_sub,'')=''
update mt_product set kode_sub='UHTC200'
 where namaproduct like '%champ%'
update mt_product set kode_sub='UHT1LT'
 where namaproduct like '%1000m%'
update mt_product set kode_sub='UHT250'
 where namaproduct like '%250m%'
update mt_product set kode_sub='UHT1LT'
 where namaproduct like '%950m%'
update mt_product set kode_sub='IM-POUCH'
 where namaproduct like '%560%'

---powder
select *from MT_Product WHERE ISNULL(kode_sub,'')=''
select *from MT_Product WHERE PRODGRP='POWDER' and isnull(kode_sub,'')=''
select *from MT_Product WHERE PRODGRP='POWDER' and isnull(kode_sub,'')<>''
update mt_product set kode_sub='HI-CAL'
 where namaproduct like '%CALCI%'  
update mt_product set kode_sub='SBI'
 where namaproduct like '%INSTANT OME%'
update mt_product set kode_sub='SBC'
 where namaproduct like '%OMEGA-3 COK%'
update mt_product set kode_sub='SBB'
 where namaproduct like '%OMEGA-3 FUL%'
update mt_product set kode_sub='OBR'
 where namaproduct like '%ORCHID, BUTTER%'

---PLM
select *from MT_Product WHERE ISNULL(kode_sub,'')=''  or kode_sub like '%190%'
select *from MT_Product WHERE PRODGRP='PLM' and isnull(kode_sub,'')=''
select *from MT_Product WHERE PRODGRP='PLM' and isnull(kode_sub,'')<>''
update mt_product set kode_sub='PNF'
 where namaproduct like '%PLM LOW FAT%'  
update mt_product set kode_sub='P200'
 where namaproduct like '%PLM%' and namaproduct like '%200m%'
update mt_product set kode_sub='P950'
 where namaproduct like '%PLM%' and namaproduct like '%950m%'
update mt_product set kode_sub='SCI190',prodgrp='SCI'
 where namaproduct like '%190%' and isnull(prodgrp,'')=''

select *from MT_Product WHERE ISNULL(prod_sub,'')=''

---ice cream
select *from MT_Product WHERE ISNULL(kode_sub,'')='' order by namaproduct
select *from MT_Product WHERE PRODGRP='ICE' and isnull(kode_sub,'')=''
select *from MT_Product WHERE PRODGRP='ICE' and isnull(kode_sub,'')<>''
update mt_product set kode_sub='CHOC ROCKS'
 where namaproduct like '%CHOC%' AND namaproduct like '%ROCK%'
update mt_product set kode_sub='ESPESSIA'
 where namaproduct like '%ESPESSIA%' or namaproduct like '%ES POTONG%'--AND namaproduct like '%ROCK%'
update mt_product set kode_sub='KUL-KUL'
 where namaproduct like '%KUL-KUL%'
update mt_product set kode_sub='NUSANTARA'
 where namaproduct like '%NUSANTARA%'
update mt_product set kode_sub='TAM-TAM'
 where namaproduct like '%TAM-TAM%'
update mt_product set kode_sub='MAX'
 where namaproduct like '%ICE CREAM MAX%' and isnull(kode_sub,'')=''
update mt_product set kode_sub='ROCKS BAR'
 where namaproduct like '%ICE CREAM ROCKS%'
update mt_product set kode_sub='GIFT'
 where namaproduct like '%HADIAH%' and isnull(kode_sub,'')=''
update mt_product set kode_sub='BULK ICE'
 where namaproduct like '%BULK ICE CREAM%' and isnull(kode_sub,'')=''
update mt_product set kode_sub='BULK ICE'
 where namaproduct like '%EBR 8LT%' and isnull(kode_sub,'')=''

--NamaProduct to product..then make the same for duplicate product (eg 375 to 380)
--update mt_product set product=namaproduct where isnull(product,'')=''


select *from ilo_mt where item='CAP ENAK, SUSU KENTAL MANIS COKLAT KLG 375g' and year=2017 and month=1 and dc='DC BALI'
select *from ilo_prod_matid order by nama_prod
/*
select status,[year],[month],item,branch,dc,count(*) as cnt
 from idm_ilo
 group by status,[year],[month],item,branch,dc
 having count(*)>1


select status,[year],[month],item,branch,dc,count(*) as cnt
 from ilo_mt
 group by status,[year],[month],item,branch,dc
 having count(*)>1
*/



end