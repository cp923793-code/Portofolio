CREATE TABLE discount_b_2022a(
	custd_id varchar(50) NOT NULL,
	prod_id char(20) NOT NULL,
	wk char(2) NOT NULL,
	yr char(4) NULL,
	branch_id varchar(15) NULL,
	sp_id varchar(15) NULL,
	mth varchar(2) NULL,
	disc_b_amt numeric(38, 2) NULL,
	sls_id varchar(20) NULL
);

 
CREATE TABLE discount_PotTunai_2022a(
	custd_id varchar(50) NOT NULL,
	prod_id char(20) NOT NULL,
	week char(2) NOT NULL,
	year char(4) NULL,
	branch_id varchar(15) NULL,
	sp_id varchar(15) NULL,
	month varchar(2) NULL,
	disc_pottunai numeric(38, 2) NULL,
	sls_id varchar(20) NULL
) ;

drop table discount_b_2022a
