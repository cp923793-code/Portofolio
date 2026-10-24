connect target sys/&1;
 
run
{
set command id  to 'PDB$SEED';
RESTORE FOREIGN DATAFILE  2 FORMAT 'C:\Oracle\oradata\ADVENTURESALES\pdbseed\SYSTEM01.DBF',4 FORMAT 'C:\Oracle\oradata\ADVENTURESALES\pdbseed\SYSAUX01.DBF',9 FORMAT 'C:\Oracle\oradata\ADVENTURESALES\pdbseed\UNDOTBS01.DBF' FROM BACKUPSET  'C:\Oracle\dbhomeXE\assistants\dbca\templates\pdbseed.dfb' ;
}
exit;
