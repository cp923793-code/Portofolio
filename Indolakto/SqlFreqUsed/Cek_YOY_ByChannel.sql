---- sci
select  year,sum(net_amt) from sttyr_sci_yoy
 group by year order by year

 select year,psub_id1,sum(net_amt) 
  from Complete_2years_Wk_Report_bySubChannel_All_Dtl_StockPoint with(nolock)  
   where  week<=22 and psub_id like '%SCI%'
    group by year,psub_id1 order by  year


---- skm
select  year,sum(net_amt) from sttyr_skm_yoy
 group by year order by year

 select year,prodgrp,sum(net_amt) 
  from Complete_2years_Wk_Report_bySubChannel_All_Dtl_StockPoint with(nolock)  
   where  week<=22 and prodgrp like '%skm%'
    group by year,prodgrp order by  year
