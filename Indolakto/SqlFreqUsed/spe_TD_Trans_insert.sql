CREATE   proc spe_TD_Trans_insert as
select a.*
from temp_td_trans_GroupBy a
left join td_trans b with (nolock)
	on a.distributor = b.distributor and
	a.tgl_trans = b.tgl_trans and
	a.product_id_distributor = b.product_id_distributor and
	a.outlet_id = b. outlet_id  and
	a.Product_id_principal = b.Product_id_principal and
	a.document_number = b.document_number and
	a.salesman_id = b.salesman_id and
	a.trans_type = b.trans_type
where b.distributor is null
and   a.tgl_trans <= getdate()