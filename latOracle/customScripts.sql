SET VERIFY OFF
set echo on
spool C:\latOracle\customScripts.log append
connect "SYS"/"&&sysPassword" as SYSDBA
@CreateDatabase;
connect "SYS"/"&&sysPassword" as SYSDBA
@C:\latOracle\;
spool off
exit;
