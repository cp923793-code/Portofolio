-- it means, you must setup your partition from the start
ALTER TABLE Sttwk RENAME TO sttwk_old;
ALTER TABLE Sttwk_old RENAME TO sttwk;

ALTER TABLE sttwk
ADD COLUMN year_month TEXT GENERATED ALWAYS AS (year || LPAD(month, 2, '0')) STORED;
-- recreate table
CREATE TABLE sttwk(
	branch_id char(15) NOT NULL,
	sp_id varchar(50) NOT NULL,
	custd_id varchar(50) NOT NULL,
	prod_id char(20) NOT NULL,
	sls_id char(15) NOT NULL,
	year char(4) NOT NULL,
	month char(2) NOT NULL,
	week char(2) NOT NULL,
	net_qty numeric(12, 4) NULL,
	net_amt numeric(18, 4) NULL,
	grs_qty numeric(12, 4) NULL,
	grs_amt numeric(18, 4) NULL,
	rtn_qty numeric(10, 2) NULL,
	rtn_amt numeric(15, 2) NULL,
	year_month char(6)
)  PARTITION BY RANGE (year_month);
insert i
-- create child tables
--  SELECT distinct year_month FROM sttwk_202201;
CREATE TABLE sttwk_202201 PARTITION OF sttwk
  FOR VALUES From ('202201') to ('202202');
CREATE TABLE sttwk_202202 PARTITION OF sttwk
  FOR VALUES From ('202202') to ('202203');  
CREATE TABLE sttwk_202203 PARTITION OF sttwk
  FOR VALUES From ('202203') to ('202204');
CREATE TABLE sttwk_202204 PARTITION OF sttwk
  FOR VALUES From ('202204') to ('202205');    
CREATE TABLE sttwk_202205 PARTITION OF sttwk
  FOR VALUES From ('202205') to ('202206');
CREATE TABLE sttwk_202206 PARTITION OF sttwk
  FOR VALUES From ('202206') to ('202207');  
CREATE TABLE sttwk_202207 PARTITION OF sttwk
  FOR VALUES From ('202207') to ('202208');
CREATE TABLE sttwk_202208 PARTITION OF sttwk
  FOR VALUES From ('202208') to ('202209');      
CREATE TABLE sttwk_202209 PARTITION OF sttwk
  FOR VALUES From ('202209') to ('202210');
CREATE TABLE sttwk_202210 PARTITION OF sttwk
  FOR VALUES From ('202210') to ('202211');  
CREATE TABLE sttwk_202211 PARTITION OF sttwk
  FOR VALUES From ('202211') to ('202212');
CREATE TABLE sttwk_202212 PARTITION OF sttwk
  FOR VALUES From ('202212') to ('202213');      

CREATE TABLE sttwk_202301 PARTITION OF sttwk
  FOR VALUES From ('202301') to ('202302');
CREATE TABLE sttwk_202302 PARTITION OF sttwk
  FOR VALUES From ('202302') to ('202303');  
CREATE TABLE sttwk_202303 PARTITION OF sttwk
  FOR VALUES From ('202303') to ('202304');
CREATE TABLE sttwk_202304 PARTITION OF sttwk
  FOR VALUES From ('202304') to ('202305');    
CREATE TABLE sttwk_202305 PARTITION OF sttwk
  FOR VALUES From ('202305') to ('202306');
CREATE TABLE sttwk_202306 PARTITION OF sttwk
  FOR VALUES From ('202306') to ('202307');  
CREATE TABLE sttwk_202307 PARTITION OF sttwk
  FOR VALUES From ('202307') to ('202308');
CREATE TABLE sttwk_202308 PARTITION OF sttwk
  FOR VALUES From ('202308') to ('202309');      
CREATE TABLE sttwk_202309 PARTITION OF sttwk
  FOR VALUES From ('202309') to ('202310');
CREATE TABLE sttwk_202310 PARTITION OF sttwk
  FOR VALUES From ('202310') to ('202311');  
CREATE TABLE sttwk_202311 PARTITION OF sttwk
  FOR VALUES From ('202311') to ('202312');
CREATE TABLE sttwk_202312 PARTITION OF sttwk
  FOR VALUES From ('202312') to ('202313');     

CREATE TABLE sttwk_202401 PARTITION OF sttwk
  FOR VALUES From ('202401') to ('202402');
CREATE TABLE sttwk_202402 PARTITION OF sttwk
  FOR VALUES From ('202402') to ('202403');  
CREATE TABLE sttwk_202403 PARTITION OF sttwk
  FOR VALUES From ('202403') to ('202404');
CREATE TABLE sttwk_202404 PARTITION OF sttwk
  FOR VALUES From ('202404') to ('202405');    
CREATE TABLE sttwk_202405 PARTITION OF sttwk
  FOR VALUES From ('202405') to ('202406');
CREATE TABLE sttwk_202406 PARTITION OF sttwk
  FOR VALUES From ('202406') to ('202407');  
CREATE TABLE sttwk_202407 PARTITION OF sttwk
  FOR VALUES From ('202407') to ('202408');
CREATE TABLE sttwk_202408 PARTITION OF sttwk
  FOR VALUES From ('202408') to ('202409');      
CREATE TABLE sttwk_202409 PARTITION OF sttwk
  FOR VALUES From ('202409') to ('202410');
CREATE TABLE sttwk_202410 PARTITION OF sttwk
  FOR VALUES From ('202410') to ('202411');  
CREATE TABLE sttwk_202411 PARTITION OF sttwk
  FOR VALUES From ('202411') to ('202412');
CREATE TABLE sttwk_202412 PARTITION OF sttwk
  FOR VALUES From ('202412') to ('202413');     

CREATE TABLE sttwk_202501 PARTITION OF sttwk
  FOR VALUES From ('202501') to ('202502');
CREATE TABLE sttwk_202502 PARTITION OF sttwk
  FOR VALUES From ('202502') to ('202503');  
CREATE TABLE sttwk_202503 PARTITION OF sttwk
  FOR VALUES From ('202503') to ('202504');
CREATE TABLE sttwk_202504 PARTITION OF sttwk
  FOR VALUES From ('202504') to ('202505');    
CREATE TABLE sttwk_202505 PARTITION OF sttwk
  FOR VALUES From ('202505') to ('202506');
CREATE TABLE sttwk_202506 PARTITION OF sttwk
  FOR VALUES From ('202506') to ('202507');  
   SELECT distinct year_month FROM sttwk_202506;

insert into sttwk select *from sttwk_old  
drop table sttwk_old 

CREATE INDEX sttwk_year_month_week_idx ON sttwk (year_month,year,week);
--drop index sttwk_year_month_week_idx
CLUSTER sttwk USING sttwk_year_month_week_idx;  