SET VERIFY OFF
connect "SYS"/"&&sysPassword" as SYSDBA
set echo on
spool C:\latOracle\postScripts.log append
disconnect;
connect "SYSTEM"/"&&systemPassword"
disconnect;
connect "SYS"/"&&sysPassword" as SYSDBA
host "C:\Oracle\dbhomeXE\perl\bin\perl.exe" C:\Oracle\dbhomeXE\rdbms\admin\catcon.pl -n 1 -l C:\latOracle -v  -b dbmssml  -U "SYS"/"&&sysPassword" C:\Oracle\dbhomeXE\rdbms\admin\dbmssml.sql;
host "C:\Oracle\dbhomeXE\perl\bin\perl.exe" C:\Oracle\dbhomeXE\rdbms\admin\catcon.pl -n 1 -l C:\latOracle -v  -b dbmsclr  -U "SYS"/"&&sysPassword" C:\Oracle\dbhomeXE\rdbms\admin\dbmsclr.plb;
alter session set "_oracle_script"=TRUE;
execute dbms_datapump_utl.create_default_dir;
commit;
alter session set "_oracle_script"=FALSE;
connect "SYS"/"&&sysPassword" as SYSDBA
host "C:\Oracle\dbhomeXE\perl\bin\perl.exe" C:\Oracle\dbhomeXE\rdbms\admin\catcon.pl -n 1 -l C:\latOracle -v  -b ordlib  -U "SYS"/"&&sysPassword" C:\Oracle\dbhomeXE\ord\im\admin\ordlib.sql;
connect "SYS"/"&&sysPassword" as SYSDBA
create or replace directory XMLDIR as 'C:\Oracle\dbhomeXE\rdbms\xml';
create or replace directory XSDDIR as 'C:\Oracle\dbhomeXE\rdbms\xml\schema';
@C:\Oracle\dbhomeXE\rdbms/admin/utlfixdirs.sql;
connect "SYS"/"&&sysPassword" as SYSDBA
connect "SYS"/"&&sysPassword" as SYSDBA
@C:\Oracle\dbhomeXE\rdbms\admin\execocm.sql;
execute dbms_qopatch.replace_logscrpt_dirs;
host "C:\Oracle\dbhomeXE\perl\bin\perl.exe" C:\Oracle\dbhomeXE\rdbms\admin\catcon.pl -n 1 -l C:\latOracle -v  -b execemx  -U "SYS"/"&&sysPassword" C:\Oracle\dbhomeXE\rdbms\admin\execemx.sql;
spool off
connect "SYS"/"&&sysPassword" as SYSDBA
set echo on
spool C:\latOracle\postDBCreation.log append
