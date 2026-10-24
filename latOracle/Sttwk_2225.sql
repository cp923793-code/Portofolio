
CREATE TABLE STTWK_2225 (
    branch_id      VARCHAR2(20)   NULL,
    sp_id          VARCHAR2(15)   NULL,
    custd_id       VARCHAR2(30)   NULL,
    prod_id        VARCHAR2(20)   NULL,
    sls_id         VARCHAR2(20)   NULL,
    -- Use NUMBER for all numeric types in Oracle
    yr             NUMBER(4, 0)   NULL,
    mnth           VARCHAR2(20)   NULL,
    wk             NUMBER(2, 0)   NULL,
    net_qty        NUMBER(12, 2)  NULL,
    net_amt        NUMBER(14, 2)  NULL,
    grs_qty        NUMBER(12, 2)  NULL,
    grs_amt        NUMBER(14, 2)  NULL,
    rtn_qty        NUMBER(10, 2)  NULL,
    rtn_amt        NUMBER(12, 2)  NULL,
    year_week_int  NUMBER(9, 0)   NULL
);

--drop table stockpoint
select count(*) from sttwk_2225
--truncate table sttwk_2225
 
 SELECT 
    segment_name AS "Table Name",
    segment_type AS "Object Type",
    ROUND(SUM(bytes) / 1024 / 1024 / 1024, 9) AS "Size (GB)"
FROM 
    dba_segments
WHERE 
  owner = 'SYSTEM' and bytes>100000 and  segment_type = 'TABLE'
GROUP BY 
    segment_name, segment_type 
order by segment_name  ;

SELECT file_name AS "Physical File Location", 
       tablespace_name AS "Tablespace Name"
FROM dba_data_files
ORDER BY tablespace_name;