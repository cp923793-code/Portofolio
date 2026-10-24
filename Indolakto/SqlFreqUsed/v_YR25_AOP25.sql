USE [AdventureSales]
GO

/****** Object:  View [dbo].[v_YR25_AOP25]    Script Date: 6/26/2025 1:54:33 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


--select *from qtrtbl

ALTER VIEW [dbo].[v_YR25_AOP25]    
AS    
  -- select *from v_yr24_aop24
    -- select *from AOP25_Psub_id1
   -- select * into rrwk_aop25 from rrwk_aop24 
  -- select * into AOP25_Psub_id1 from LE_Psub_id1
   --truncate table rrwk_aop25
   -- select *from rrwk_aop25
   --truncate table aop25_PSub_Id1
   -- select *from aop25_psub_id1
  -- select 'KIDS      ' as ProdGrp,'CRM      ' as Type,209313 as RRWk into rrwk_aop24
  -- select *from rrwk_aop24
  /* insert into rrwk_aop24 values ('KIDS', 'Sls200', 86030)
     insert into rrwk_aop24 values ('KIDS', 'Reguler',  59494)
	 insert into rrwk_aop24 values ('KIDS', 'Canvass',   36737) 
	 select *into rrwk_aop2424 from rrwk_aop24 where ProdGrp='KIDS'

	 select *from rrwk_aop24 order by prodgrp

	 insert into rrwk_aop25
	 select prodgrp,type,qty/52 from aop25_psub_id1

	 	 insert into rrwk_aop24  
	 select 'SCI' as prodgrp, type, RRwk from rrwk_aop24 where ProdGrp='KIDS'

	 update rrwk_aop24 set rrwk=209313 where type='CRM' and prodgrp='KIDS'
	 update rrwk_aop24 set rrwk=86330 where type='Sls200' and prodgrp='KIDS'
	 update rrwk_aop24 set rrwk=55494 where type='Reguler' and prodgrp='KIDS'
	 update rrwk_aop24 set rrwk=36737 where type='Canvass' and prodgrp='KIDS'

	 	 update rrwk_aop24 set rrwk=3189 where type='CRM' and prodgrp='UHT180'
	 update rrwk_aop24 set rrwk=5530 where type='Sls200' and prodgrp='UHT180'
	 update rrwk_aop24 set rrwk=12333 where type='Reguler' and prodgrp='UHT180'
	 update rrwk_aop24 set rrwk=2949 where type='Canvass' and prodgrp='UHT180'

	 	 update rrwk_aop24 set rrwk=72250 where type='CRM' and prodgrp='SCI'
	 update rrwk_aop24 set rrwk=33750 where type='Sls200' and prodgrp='SCI'
	 update rrwk_aop24 set rrwk=31000 where type='Reguler' and prodgrp='SCI'
	 update rrwk_aop24 set rrwk=18750 where type='Canvass' and prodgrp='SCI'

	 	 update rrwk_aop24 set rrwk= 22287 where type='CRM' and prodgrp='CE-370'
	 update rrwk_aop24 set rrwk=1500 where type='Sls200' and prodgrp='CE-370'
	 update rrwk_aop24 set rrwk=10200 where type='Reguler' and prodgrp='CE-370'
	 update rrwk_aop24 set rrwk=8710 where type='Canvass' and prodgrp='CE-370'

	  update rrwk_aop24 set rrwk= 38859 where type='CRM' and prodgrp='TS-500'
	 update rrwk_aop24 set rrwk=2179 where type='Sls200' and prodgrp='TS-500'
	 update rrwk_aop24 set rrwk=25007 where type='Reguler' and prodgrp='TS-500'
	 update rrwk_aop24 set rrwk=5293 where type='Canvass' and prodgrp='TS-500'

	  update rrwk_aop24 set rrwk= 9007 where type='CRM' and prodgrp='IM-CAN'
	 update rrwk_aop24 set rrwk=1528 where type='Sls200' and prodgrp='IM-CAN'
	 update rrwk_aop24 set rrwk=7134 where type='Reguler' and prodgrp='IM-CAN'
	 update rrwk_aop24 set rrwk=1331 where type='Canvass' and prodgrp='IM-CAN'

	 	  update rrwk_aop24 set rrwk= 36287 where type='CRM' and prodgrp='CE-SCH'
	 update rrwk_aop24 set rrwk=10407 where type='Sls200' and prodgrp='CE-SCH'
	 update rrwk_aop24 set rrwk=23298 where type='Reguler' and prodgrp='CE-SCH'
	 update rrwk_aop24 set rrwk=7690 where type='Canvass' and prodgrp='CE-SCH'

	  update rrwk_aop24 set rrwk= 51337 where type='CRM' and prodgrp='IM-SCH'
	 update rrwk_aop24 set rrwk=17861 where type='Sls200' and prodgrp='IM-SCH'
	 update rrwk_aop24 set rrwk=34951 where type='Reguler' and prodgrp='IM-SCH'
	 update rrwk_aop24 set rrwk=8837 where type='Canvass' and prodgrp='IM-SCH'

	 select *from qtrpct_aop

	 update qtrpct_aop set pct=18.8 where prodgrp='UHT180' and qtr=1
	  update qtrpct_aop set pct=24 where prodgrp='UHT180' and qtr=2
	   update qtrpct_aop set pct=27 where prodgrp='UHT180' and qtr=3
     update qtrpct_aop set pct=30.2 where prodgrp='UHT180' and qtr=4

	  update qtrpct_aop set pct=25.26 where prodgrp='SCI' and qtr=1
	  update qtrpct_aop set pct=24.57 where prodgrp='SCI' and qtr=2
	  update qtrpct_aop set pct=24.91 where prodgrp='SCI' and qtr=3
      update qtrpct_aop set pct=25.26 where prodgrp='SCI' and qtr=4
	 select sum(pct) from qtrpct_aop where prodgrp='UHT180'

	 insert  into qtrpct_aop
	 select 'CE-370' as ProdGrp, Qtr, Pct from qtrpct_aop where ProdGrp='KIDS'

    update qtrpct_aop set pct=32.26 where prodgrp='CE-370' and qtr=1
    update qtrpct_aop set pct=23.42 where prodgrp='CE-370' and qtr=2
    update qtrpct_aop set pct=21.08 where prodgrp='CE-370' and qtr=3
    update qtrpct_aop set pct=23.24 where prodgrp='CE-370' and qtr=4

		 insert  into qtrpct_aop
	 select 'TS-500' as ProdGrp, Qtr, Pct from qtrpct_aop where ProdGrp='KIDS'

	    update qtrpct_aop set pct=26.00 where prodgrp='TS-500' and qtr=1
    update qtrpct_aop set pct=24.00 where prodgrp='TS-500' and qtr=2
    update qtrpct_aop set pct=24.00 where prodgrp='TS-500' and qtr=3
    update qtrpct_aop set pct=26.00 where prodgrp='TS-500' and qtr=4

			 insert  into qtrpct_aop
	 select 'IM-CAN' as ProdGrp, Qtr, Pct from qtrpct_aop where ProdGrp='KIDS'

	    update qtrpct_aop set pct=30.26 where prodgrp='IM-CAN' and qtr=1
    update qtrpct_aop set pct=23.03 where prodgrp='IM-CAN' and qtr=2
    update qtrpct_aop set pct=22.37 where prodgrp='IM-CAN' and qtr=3
    update qtrpct_aop set pct=24.34 where prodgrp='IM-CAN' and qtr=4

				 insert  into qtrpct_aop
	 select 'CE-SCH' as ProdGrp, Qtr, Pct from qtrpct_aop where ProdGrp='KIDS'

	    update qtrpct_aop set pct=27.00 where prodgrp='CE-SCH' and qtr=1
    update qtrpct_aop set pct=23.50 where prodgrp='CE-SCH' and qtr=2
    update qtrpct_aop set pct=24.00 where prodgrp='CE-SCH' and qtr=3
    update qtrpct_aop set pct=25.50 where prodgrp='CE-SCH' and qtr=4


					 insert  into qtrpct_aop
	 select 'IM-SCH' as ProdGrp, Qtr, Pct from qtrpct_aop where ProdGrp='KIDS'

	    update qtrpct_aop set pct=27.00 where prodgrp='IM-SCH' and qtr=1
    update qtrpct_aop set pct=23.50 where prodgrp='IM-SCH' and qtr=2
    update qtrpct_aop set pct=24.00 where prodgrp='IM-SCH' and qtr=3
    update qtrpct_aop set pct=25.50 where prodgrp='IM-SCH' and qtr=4

	select prodgrp,sum(pct) from qtrpct_aop group by prodgrp

	 	 	 insert into rrwk_aop24  
	 --select 'CE-370' as prodgrp, type, RRwk from rrwk_aop24 where ProdGrp='KIDS'
	 --select 'CE-SCH' as prodgrp, type, RRwk from rrwk_aop24 where ProdGrp='KIDS'
	 --select 'IM-CAN' as prodgrp, type, RRwk from rrwk_aop24 where ProdGrp='KIDS'
	 --select 'IM-SCH' as prodgrp, type, RRwk from rrwk_aop24 where ProdGrp='KIDS'
	 select 'TS-500' as prodgrp, type, RRwk from rrwk_aop24 where ProdGrp='KIDS'

	 	 	 insert into rrwk_aop24  
	 select 'SCI' as prodgrp, type, RRwk from rrwk_aop24 where ProdGrp='KIDS'
*/

-- select *from v_YR24_AOP24
-- select *from rrwk_aop24

/*   
    drop table  rrwk_aop25
	 --insert into rrwk_aop25
	 select prodgrp,type,qty/52 as rrwk into rrwk_aop25 from aop25_psub_id1
*/
-- run above please
select Type,ProdGrp,2025 as Year,RRwk*52 as net_qty
 from rrwk_aop25
 -- order by prodgrp
 --select sum(net_qty) from v_YR24_AOP24
 -- select *from rrwk_aop24 select *from rrwk_aop 
  -- select *from rrwk_aop 












GO

