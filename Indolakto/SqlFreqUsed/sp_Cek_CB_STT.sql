alter PROCEDURE [dbo].[sp_Cek_CB_STT]
AS
BEGIN
select year,month,count(distinct custd_id) as cnt
 from sttmt_kids_fly where net_qty>0 and year>=2024
  group by year,month order by year,month

  select year,month,sum(net_qty)
 from sttmt_kids_fly where  year>=2024
  group by year,month order by year,month

  select year,month,count(distinct custd_id) as cnt
 from 
 (select year,month,custd_id,sum(net_qty) as net_qty from sttwk1a1_sci 
   group by year,month,custd_id) as a 
 where net_qty>0 and year>=2024
  group by year,month order by year,month

   select year,month,sum(net_qty)
 from 
 (select year,month,custd_id,sum(net_qty) as net_qty from sttwk1a1_sci 
   group by year,month,custd_id) as a 
 where   year>=2024
  group by year,month order by year,month
   

end