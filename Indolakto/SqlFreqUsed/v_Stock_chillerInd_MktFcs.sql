  
create VIEW [dbo].[v_Stock_chillerInd_MktFcs]    
AS   
select b.region,b.branch_id,b.branch_name,depo,a.sp_id,c.sp_name,a.prod_id,d.psub_id,d.udf1 as psub_id1,text_id,
 date,site_id,ending_qty
 from adventurestock.dbo.stock a left outer join branch b on a.branch_id=b.branch_id
 left outer join stockpoint c on a.sp_id=c.sp_id
 left outer join product_svr55 d on a.prod_id=d.prod_id 
 inner join v_Sp_chillerInd_MktFcs g on a.sp_id=g.sp_id
 where date>((select top 1  date from adventurestock.dbo.stock  where date>(select begdate from adventuresales.dbo.begmonth)  order by date desc)-5)
  and d.udf1 in ('KIDS','STC189','UHT180','CE-370','IM-CAN','TS-500',
    'CE-SCH','TS-SCH','IM-SCH','SCI','IM-POUCH','CE-POUCH')
  