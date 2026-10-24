CREATE          proc spe_TD_Trans_GroupBy_insert as

select 
	a.Distributor,
	convert( datetime,
	right(tgl_trans, 2) +      					-- Untuk convert ke type datetime dari data tanggal yang tidak standard
        dbo.lpad(substring(tgl_trans, charindex('/',tgl_trans)+1, charindex('/',tgl_Trans,charindex('/',tgl_trans)+1)-charindex('/',tgl_trans)-1),2,'0') +  
	dbo.lpad(substring(tgl_trans, 1, charindex('/',tgl_trans)-1), 2,'0'), 112) as Tgl_Trans,
	a.Product_ID_Distributor,
	coalesce(a.Outlet_ID, ' N/A') as Outlet_ID,
	coalesce(a.Product_ID_Principal, ' N/A') as Product_Id_Principal ,
--	coalesce(a.Document_Number, ' N/A') as Document_Number,
	coalesce(a.document_number, 					-- updated by Beta, August 12, 2010
	  cast((							-- to provide null Document_Number
	  coalesce
	  ((case 
	    when a.outlet_id = char(32) 
	      then dbo.beta_replace_char_to_int_2(a.outlet_id)
	      else a.outlet_id
	    end), 'N/A') +				
	  cast(dbo.lpad(day(convert( datetime,
		right(tgl_trans, 2) +     
	        dbo.lpad(substring(tgl_trans, charindex('/',tgl_trans)+1, charindex('/',tgl_Trans,charindex('/',tgl_trans)+1)-charindex('/',tgl_trans)-1),2,'0') +  
		dbo.lpad(substring(tgl_trans, 1, charindex('/',tgl_trans)-1), 2,'0'), 112)),2,'0') as varchar) +
	  cast(dbo.lpad(month(convert( datetime,
		right(tgl_trans, 2) +     
	        dbo.lpad(substring(tgl_trans, charindex('/',tgl_trans)+1, charindex('/',tgl_Trans,charindex('/',tgl_trans)+1)-charindex('/',tgl_trans)-1),2,'0') +  
		dbo.lpad(substring(tgl_trans, 1, charindex('/',tgl_trans)-1), 2,'0'), 112)),2,'0') as varchar) +
	  cast(right(year(convert( datetime,
		right(tgl_trans, 2) +     
	        dbo.lpad(substring(tgl_trans, charindex('/',tgl_trans)+1, charindex('/',tgl_Trans,charindex('/',tgl_trans)+1)-charindex('/',tgl_trans)-1),2,'0') +  
		dbo.lpad(substring(tgl_trans, 1, charindex('/',tgl_trans)-1), 2,'0'), 112)),2) as varchar) 
	  ) as varchar))as Document_Number,
	coalesce(a.Salesman_ID, ' N/A') as Salesman_ID,
	a.Trans_Type,
	sum(a.Quantity_Carton) as Quantity_Carton,
	min(a.Unit_Of_Measure) as Unit_Of_Measure,
	sum(a.Quantity_PCS) as Quantity_PCS,
	min(a.Unit_Of_Measure_1) as Unit_Of_Measure_1,
	sum(a.Quantity_Others) as Quantity_Others,
	min(a.Unit_Of_Measure_2) as Unit_Of_Measure_2,
	sum(a.Gross_Sales) as Gross_Sales,
	sum(a.Tax_Amount) as Tax_Amount,
	sum(a.Discount_Percent) as Discount_Percent,
	sum(a.Discount_Amount) as Discount_Amount,
	sum(a.Discount_Promo_1) as Discount_Promo_1,
	sum(a.Discount_Promo_2) as Discount_Promo_2,
	sum(a.Discount_Promo_3) as Discount_Promo_3,
	sum(a.Net_Sales) as Net_Sales,
	min(a.Outlet_Name) as Outlet_Name,
	min(a.Outlet_Address) as Outlet_Address,
	min(a.Outlet_City) as Outlet_City,
	min(a.Outlet_SubCity) as Outlet_SubCity,
	min(a.Outlet_Type) as Outlet_Type,
	min(a.Salesman_Name) as Salesman_Name,
	min(a.Distributor_Name) as Distributor_Name,
	min(a.Region_Distributor) as Region_Distributor,
	min(a.Sub_Region) as Sub_Region,
	min(a.Area) as Area,
	min(a.Sub_Area) as Sub_Area,
	min(a.Product_Name_Distributor) as Product_Name_Distributor,
	min(a.Product_Name_Principal) as Product_Name_Principal,
	min(a.Flavor) as Flavor,
	min(a.Family) as Family,
	min(a.Packet_Size) as Packet_Size,
	min(a.FileName) as Filename

from temp_td_trans a
group by
	a.Distributor,
	convert( datetime,
	right(tgl_trans, 2) +
        dbo.lpad(substring(tgl_trans, charindex('/',tgl_trans)+1, charindex('/',tgl_Trans,charindex('/',tgl_trans)+1)-charindex('/',tgl_trans)-1),2,'0') +  
	dbo.lpad(substring(tgl_trans, 1, charindex('/',tgl_trans)-1), 2,'0'), 112),
	a.Product_ID_Distributor,
	a.Outlet_ID,
	a.Product_ID_Principal,
--	a.Document_Number,
	coalesce(a.document_number, 					-- updated by Beta, August 12, 2010
	  cast((							-- to provide null Document_Number
	  coalesce
	  ((case 
	    when a.outlet_id = char(32) 
	      then dbo.beta_replace_char_to_int_2(a.outlet_id)
	      else a.outlet_id
	    end), 'N/A') +				
	  cast(dbo.lpad(day(convert( datetime,
		right(tgl_trans, 2) +     
	        dbo.lpad(substring(tgl_trans, charindex('/',tgl_trans)+1, charindex('/',tgl_Trans,charindex('/',tgl_trans)+1)-charindex('/',tgl_trans)-1),2,'0') +  
		dbo.lpad(substring(tgl_trans, 1, charindex('/',tgl_trans)-1), 2,'0'), 112)),2,'0') as varchar) +
	  cast(dbo.lpad(month(convert( datetime,
		right(tgl_trans, 2) +     
	        dbo.lpad(substring(tgl_trans, charindex('/',tgl_trans)+1, charindex('/',tgl_Trans,charindex('/',tgl_trans)+1)-charindex('/',tgl_trans)-1),2,'0') +  
		dbo.lpad(substring(tgl_trans, 1, charindex('/',tgl_trans)-1), 2,'0'), 112)),2,'0') as varchar) +
	  cast(right(year(convert( datetime,
		right(tgl_trans, 2) +     
	        dbo.lpad(substring(tgl_trans, charindex('/',tgl_trans)+1, charindex('/',tgl_Trans,charindex('/',tgl_trans)+1)-charindex('/',tgl_trans)-1),2,'0') +  
		dbo.lpad(substring(tgl_trans, 1, charindex('/',tgl_trans)-1), 2,'0'), 112)),2) as varchar) 
	  ) as varchar)),
	a.Salesman_ID,
	a.Trans_Type









GO