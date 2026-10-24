SET VERIFY OFF
spool C:\latOracle\postDBCreation.log append
host C:\Oracle\dbhomeXE\OPatch\datapatch.bat -skip_upgrade_check -db AdventureSls;
connect "SYS"/"&&sysPassword" as SYSDBA
set echo on
create spfile='C:\Oracle\database\spfileAdventureSls.ora' FROM pfile='C:\latOracle\init.ora';
connect "SYS"/"&&sysPassword" as SYSDBA
host "C:\Oracle\dbhomeXE\perl\bin\perl.exe" C:\Oracle\dbhomeXE\rdbms\admin\catcon.pl -n 1 -l C:\latOracle -v  -b utlrp  -U "SYS"/"&&sysPassword" C:\Oracle\dbhomeXE\rdbms\admin\utlrp.sql;
select comp_id, status from dba_registry;
execute dbms_swrf_internal.cleanup_database(cleanup_local => FALSE);
commit;
shutdown immediate;
connect "SYS"/"&&sysPassword" as SYSDBA
startup ;
spool off
