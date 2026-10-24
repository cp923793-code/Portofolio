      /*
		      SELECT * from Complete_2years_Wk_Report_bySubChannel_All_Dtl_StockPoint   
		      where branch_name like 'JAKARTA 1%' and year=2022 and week=1 and sp_id like '5209/010%'
		        and text_id like 'CEC37%'
		       order by psub_id,text_id,retwhs
		       
		       -----
		       
select text_id,count(*) from(
SELECT * from Complete_2years_Wk_Report_bySubChannel_All_Dtl_StockPoint   
		      where branch_name like 'JAKARTA 1%' and year=2022 and week=1 and sp_id like '5209/010%'
		       order by psub_id,text_id,retwhs 
    ) as a
    group by text_id order by text_id
      
      -----
            SELECT count(*) from Complete_2years_Wk_Report_bySubChannel_All_Dtl_StockPoint   
      where branch_name like 'JAKARTA 1%' and year=2022 and week=1
      */
      
  