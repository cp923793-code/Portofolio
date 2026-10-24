SET VERIFY OFF
connect "SYS"/"&&sysPassword" as SYSDBA
set echo on
spool C:\latOracle\plugDatabase1R.log append
spool C:\latOracle\plugDatabase1R.log append
host mkdir C:\Oracle\oradata\ADVENTURESALES\AdventureSlspdb1;
select d.name||'|'||t.name from v$datafile d,V$TABLESPACE t where d.con_id=2 and d.ts#=t.ts# and d.con_id=t.con_id;
select d.name||'|'||t.name from v$tempfile d,V$TABLESPACE t where d.con_id=2 and d.ts#=t.ts# and d.con_id=t.con_id;
CREATE PLUGGABLE DATABASE "AdventureSlspdb1" ADMIN USER PDBADMIN IDENTIFIED BY "&&pdbadminPassword" ROLES=(CONNECT)  file_name_convert=('C:\Oracle\oradata\ADVENTURESALES\pdbseed',
'C:\Oracle\oradata\ADVENTURESALES\AdventureSlspdb1')  STORAGE ( MAXSIZE UNLIMITED MAX_SHARED_TEMP_SIZE UNLIMITED);
select name from v$containers where upper(name) = 'ADVENTURESLSPDB1';
alter pluggable database "AdventureSlspdb1" open;
alter system register;
ALTER SESSION SET CONTAINER = "AdventureSlspdb1";
