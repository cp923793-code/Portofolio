connect target sys/&1;
 
CATALOG START WITH   'C:\Oracle\dbhomeXE\assistants\dbca\templates\\XE_Seed_Database.dfb'  NOPROMPT  ;

RUN
{
set newname for datafile 1 to  'C:\Oracle\oradata\ADVENTURESALES\SYSTEM01.DBF' ;
set newname for datafile 3 to  'C:\Oracle\oradata\ADVENTURESALES\SYSAUX01.DBF' ;
set newname for datafile 4 to  'C:\Oracle\oradata\ADVENTURESALES\UNDOTBS01.DBF' ;
set newname for datafile 7 to  'C:\Oracle\oradata\ADVENTURESALES\USERS01.DBF' ;
restore datafile 1;
restore datafile 3;
restore datafile 4;
restore datafile 7;
switch datafile all;
}
