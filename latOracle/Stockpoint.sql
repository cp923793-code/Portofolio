
CREATE TABLE stockpoint(
	sp_id char(15) NOT NULL,
	sp_name char(30) NULL,
	branch_id char(15) NOT NULL,
	depo char(25) NULL,
	status char(1) NULL,
	address_1 char(100) NULL,
	address_2 char(35) NULL,
	city char(35) NULL,
	kabupaten char(35) NULL,
	provinsi char(25) NULL,
	postcode char(6) NULL,
	telp char(20) NULL,
	udf1 char(20) NULL,
	udf2 char(20) NULL,
	udf3 char(20) NULL,
	branch_pic char(25) NULL,
	sp_pic char(25) NULL
);
--drop table stockpoint
select *from branch
select *from stockpoint
select distinct branch_id, branch_name from branch where branch_id like '520%' order by branch_id

