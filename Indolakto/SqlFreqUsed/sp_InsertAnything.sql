use adventuresales
/*
 truncate table customerdist_1910_tmp
--select *from customerdist_1910_tmp
 truncate table sttwktmp1a
 select sum(net_qty) from sttwktmp1a
 truncate table discount_b_tmp
 truncate table discount_pottunai_tmp
 truncate table slsman_tmp
  truncate table upddaily
   truncate table sttwktmp2

 truncate table ilo_sell_out_tmp
 truncate table ilo_sell_in_tmp
 truncate table ice_sell_out_tmp
 truncate table ice_sell_in_tmp
 truncate table ilo_srvlvl_tmp
 
 select *from ilo_sell_out_tmp
 select *from ice_sell_out_tmp
 select *from ilo_sell_in_tmp
 select *from ice_sell_in_tmp
 select *from ilo_srvlvl_tmp

-- select *into ilo_mt_dy_tmp from ilo_mt_dy where year=2026
-- select *from mt_product
--  example insert with comma inside
delete from ilo_mt_dy where year=2025 and month=3
Insert into ilo_mt_dy (keyacc,division,status,year,month,item,branch,dc,qty,idr,dy)
values ('INDOMARET','INDOLAKTO','Sell Out',2025,3,'INDOMILK, SUSU KENTAL MANIS PUTIH PCK 6X37g (20013433)','AMB',' DC AMBON ADMINISTRA',31,240180.24,1)
*/

