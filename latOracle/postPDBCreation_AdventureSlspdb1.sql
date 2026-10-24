SET VERIFY OFF
connect "SYS"/"&&sysPassword" as SYSDBA
alter session set container="AdventureSlspdb1";
set echo on
spool C:\latOracle\postPDBCreation.log append
CREATE SMALLFILE TABLESPACE "USERS" LOGGING  DATAFILE  'C:\Oracle\oradata\ADVENTURESALES\AdventureSlspdb1\users01.dbf' SIZE 5M REUSE AUTOEXTEND ON NEXT  1280K MAXSIZE UNLIMITED  EXTENT MANAGEMENT LOCAL  SEGMENT SPACE MANAGEMENT  AUTO;
ALTER DATABASE DEFAULT TABLESPACE "USERS";
host C:\Oracle\dbhomeXE\OPatch\datapatch.bat -skip_upgrade_check -db AdventureSls -pdbs AdventureSlspdb1;
connect "SYS"/"&&sysPassword" as SYSDBA
select property_value from database_properties where property_name='LOCAL_UNDO_ENABLED';
connect "SYS"/"&&sysPassword" as SYSDBA
alter session set container="AdventureSlspdb1";
set echo on
spool C:\latOracle\postPDBCreation.log append
connect "SYS"/"&&sysPassword" as SYSDBA
alter session set container="AdventureSlspdb1";
set echo on
spool C:\latOracle\postPDBCreation.log append
select TABLESPACE_NAME from cdb_tablespaces a,dba_pdbs b where a.con_id=b.con_id and UPPER(b.pdb_name)=UPPER('AdventureSlspdb1');
connect "SYS"/"&&sysPassword" as SYSDBA
alter session set container="AdventureSlspdb1";
set echo on
spool C:\latOracle\postPDBCreation.log append
Select count(*) from dba_registry where comp_id = 'DV' and status='VALID';
alter session set container=CDB$ROOT;
