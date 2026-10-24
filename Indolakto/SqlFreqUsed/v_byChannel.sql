SELECT        region, branch_id, branch_name, year, channel, sub_channel, 
  prodgrp, psub_id, psub_id1, product,
 sum(net_qty) as net_qty, sum(net_amt) as net_amt
 
FROM            Complete_2years_Wk_Report_bySubChannel_All_Dtl_StockPoint_Yr
 group by region, branch_id, branch_name, year,  channel, sub_channel, 
  prodgrp, psub_id, psub_id1, product