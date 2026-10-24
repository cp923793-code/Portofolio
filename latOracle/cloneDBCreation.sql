SET VERIFY OFF
connect "SYS"/"&&sysPassword" as SYSDBA
set echo on
spool C:\latOracle\cloneDBCreation.log append
exec dbms_backup_restore.zerodbid(0);
shutdown immediate;
startup nomount pfile="C:\latOracle\initAdventureSlsTemp.ora";
Create controlfile reuse set database "Adventur"
MAXINSTANCES 8
MAXLOGHISTORY 1
MAXLOGFILES 16
MAXLOGMEMBERS 3
MAXDATAFILES 1024
Datafile 
'&&file0',
'&&file1',
'&&file2',
'&&file3'
LOGFILE GROUP 1 ('C:\Oracle\oradata\ADVENTURESALES\redo01.log') SIZE 200M,
GROUP 2 ('C:\Oracle\oradata\ADVENTURESALES\redo02.log') SIZE 200M,
GROUP 3 ('C:\Oracle\oradata\ADVENTURESALES\redo03.log') SIZE 200M RESETLOGS;
alter system enable restricted session;
alter database "Adventur" open resetlogs;
DECLARE 
cursor cur_services is 
select name from dba_services where name like 'xe%'; 
BEGIN 
 for i in cur_services loop 
 dbms_service.delete_service(i.name); 
 end loop; 
END; 
/
alter database rename global_name to "Adventur";
ALTER TABLESPACE TEMP ADD TEMPFILE 'C:\Oracle\oradata\ADVENTURESALES\TEMP01.DBF' SIZE 20480K REUSE AUTOEXTEND ON NEXT 640K MAXSIZE UNLIMITED;
var dblink NUMBER;
BEGIN SELECT COUNT(*) INTO :DBLINK FROM v$dblink WHERE DB_LINK='DBMS_CLRDBLINK'; IF :DBLINKS > 0 THEN EXECUTE IMMEDIATE 'DROP PUBLIC DATABASE LINK DBMS_CLRDBLINK'; END IF; END;
/
select tablespace_name from dba_tablespaces where tablespace_name='USERS';
ALTER PROFILE default LIMIT PASSWORD_VERIFY_FUNCTION null;
alter user sys account unlock identified by "&&sysPassword";
connect "SYS"/"&&sysPassword" as SYSDBA
alter user system account unlock identified by "&&systemPassword";
host C:\Oracle\dbhomeXE\OPatch\datapatch.bat -skip_upgrade_check -db AdventureSls;
