SET VERIFY OFF
connect "SYS"/"&&sysPassword" as SYSDBA
set echo on
spool C:\latOracle\plugDatabase.log append
spool C:\latOracle\plugDatabase.log append
host mkdir C:\Oracle\oradata\ADVENTURESALES\pdbseed;
host mkdir C:\Oracle\oradata\ADVENTURESALES\pdbseed;
host mkdir C:\Oracle\oradata\ADVENTURESALES\pdbseed;
host mkdir C:\Oracle\oradata\ADVENTURESALES\pdbseed;
alter system  set "_catalog_foreign_restore"=TRUE;
alter system  set "_restore_create_directory"=TRUE;
host C:\Oracle\dbhomeXE\bin\rman @C:\latOracle\rmanPDBRestoreDatafiles.sql &&sysPassword;
column pdbfile0 NEW_VALUE pdbfile0;
select dc.name pdbfile0 from v$datafile_copy dc, v$rman_status rs where dc.name is not null and dc.status = 'A' and file# = 2 and rs.recid = dc.rman_status_recid and rs.stamp =dc.rman_status_stamp and rs.command_id = 'PDB$SEED';
column pdbfile1 NEW_VALUE pdbfile1;
select dc.name pdbfile1 from v$datafile_copy dc, v$rman_status rs where dc.name is not null and dc.status = 'A' and file# = 4 and rs.recid = dc.rman_status_recid and rs.stamp =dc.rman_status_stamp and rs.command_id = 'PDB$SEED';
column pdbfile2 NEW_VALUE pdbfile2;
select dc.name pdbfile2 from v$datafile_copy dc, v$rman_status rs where dc.name is not null and dc.status = 'A' and file# = 9 and rs.recid = dc.rman_status_recid and rs.stamp =dc.rman_status_stamp and rs.command_id = 'PDB$SEED';
host C:\Oracle\dbhomeXE\bin\rman @C:\latOracle\rmanPDBCleanUpDatafiles.sql &&sysPassword;
alter system  set "_catalog_foreign_restore"=FALSE;
alter system  set "_restore_create_directory"=FALSE;
alter session set "_oracle_script"=TRUE;
CREATE PLUGGABLE DATABASE "PDB$SEED" AS CLONE  USING 'C:\Oracle\dbhomeXE\assistants\dbca\templates\pdbseed.xml'  source_file_name_convert = ('C:\ORADATA\XE\PDBSEED\SYSTEM01.DBF','&&pdbfile0',
'C:\ORADATA\XE\PDBSEED\SYSAUX01.DBF','&&pdbfile1',
'C:\ORADATA\XE\PDBSEED\UNDOTBS01.DBF','&&pdbfile2',
'C:\ORADATA\XE\PDBSEED\TEMP01.DBF','C:\Oracle\oradata\ADVENTURESALES\pdbseed\temp012025-11-23_17-54-32-216-PM.dbf') NOCOPY  STORAGE ( MAXSIZE UNLIMITED MAX_SHARED_TEMP_SIZE UNLIMITED);
select name from v$containers where upper(name) = 'PDB$SEED';
alter session set "_oracle_script"=true;
alter pluggable database "PDB$SEED" open restricted;
connect "SYS"/"&&sysPassword" as SYSDBA
shutdown immediate;
connect "SYS"/"&&sysPassword" as SYSDBA
startup restrict pfile="C:\latOracle\initAdventureSlsTemp.ora";
select sid, program, serial#, username from v$session;
alter database character set INTERNAL_CONVERT AL32UTF8;
alter database national character set INTERNAL_CONVERT AL16UTF16;
alter system disable restricted session;
connect "SYS"/"&&sysPassword" as SYSDBA
connect "SYS"/"&&sysPassword" as SYSDBA
alter session set "_oracle_script"=TRUE;
alter session set container=cdb$root;
alter pluggable database PDB$SEED CLOSE IMMEDIATE;
alter pluggable database PDB$SEED OPEN RESTRICTED;
DECLARE 
cdb_root_timezone VARCHAR(6); 
alter_statement VARCHAR(80); 
BEGIN 
 select dbtimezone into cdb_root_timezone from dual; 
 execute immediate 'alter session set container=PDB$SEED'; 
 alter_statement:='alter pluggable database pdb$seed set time_zone='''|| cdb_root_timezone ||''''; 
 execute immediate alter_statement; 
END; 
/
alter session set container=cdb$root;
alter session set "_oracle_script"=TRUE;
alter pluggable database PDB$SEED CLOSE IMMEDIATE;
alter pluggable database PDB$SEED OPEN restricted;
