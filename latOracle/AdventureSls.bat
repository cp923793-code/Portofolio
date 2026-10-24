mkdir C:\latOracle
if %ERRORLEVEL% == 0 ( C:\Oracle\dbhomeXE\bin\oradim.exe -ACL -setperm diag -USER ORA_OraDB21Home1_SVCACCTS -OBJTYPE dir -OBJPATH C:\latOracle -RECURSE false ) 
mkdir C:\Oracle
if %ERRORLEVEL% == 0 ( C:\Oracle\dbhomeXE\bin\oradim.exe -ACL -setperm diag -USER ORA_OraDB21Home1_SVCACCTS -OBJTYPE dir -OBJPATH C:\Oracle -RECURSE false ) 
mkdir C:\Oracle\admin\AdventureSales\adump
if %ERRORLEVEL% == 0 ( C:\Oracle\dbhomeXE\bin\oradim.exe -ACL -setperm diag -USER ORA_OraDB21Home1_SVCACCTS -OBJTYPE dir -OBJPATH C:\Oracle\admin\AdventureSales\adump -RECURSE false ) 
mkdir C:\Oracle\admin\AdventureSales\dpdump
if %ERRORLEVEL% == 0 ( C:\Oracle\dbhomeXE\bin\oradim.exe -ACL -setperm diag -USER ORA_OraDB21Home1_SVCACCTS -OBJTYPE dir -OBJPATH C:\Oracle\admin\AdventureSales\dpdump -RECURSE false ) 
mkdir C:\Oracle\admin\AdventureSales\pfile
if %ERRORLEVEL% == 0 ( C:\Oracle\dbhomeXE\bin\oradim.exe -ACL -setperm diag -USER ORA_OraDB21Home1_SVCACCTS -OBJTYPE dir -OBJPATH C:\Oracle\admin\AdventureSales\pfile -RECURSE false ) 
mkdir C:\Oracle\audit
if %ERRORLEVEL% == 0 ( C:\Oracle\dbhomeXE\bin\oradim.exe -ACL -setperm diag -USER ORA_OraDB21Home1_SVCACCTS -OBJTYPE dir -OBJPATH C:\Oracle\audit -RECURSE false ) 
mkdir C:\Oracle\database
if %ERRORLEVEL% == 0 ( C:\Oracle\dbhomeXE\bin\oradim.exe -ACL -setperm diag -USER ORA_OraDB21Home1_SVCACCTS -OBJTYPE dir -OBJPATH C:\Oracle\database -RECURSE false ) 
mkdir C:\Oracle\fast_recovery_area
if %ERRORLEVEL% == 0 ( C:\Oracle\dbhomeXE\bin\oradim.exe -ACL -setperm diag -USER ORA_OraDB21Home1_SVCACCTS -OBJTYPE dir -OBJPATH C:\Oracle\fast_recovery_area -RECURSE false ) 
mkdir C:\Oracle\fast_recovery_area\ADVENTURESALES
if %ERRORLEVEL% == 0 ( C:\Oracle\dbhomeXE\bin\oradim.exe -ACL -setperm diag -USER ORA_OraDB21Home1_SVCACCTS -OBJTYPE dir -OBJPATH C:\Oracle\fast_recovery_area\ADVENTURESALES -RECURSE false ) 
mkdir C:\Oracle\oradata\ADVENTURESALES
if %ERRORLEVEL% == 0 ( C:\Oracle\dbhomeXE\bin\oradim.exe -ACL -setperm diag -USER ORA_OraDB21Home1_SVCACCTS -OBJTYPE dir -OBJPATH C:\Oracle\oradata\ADVENTURESALES -RECURSE false ) 
mkdir C:\Oracle\oradata\ADVENTURESALES\AdventureSlspdb1
if %ERRORLEVEL% == 0 ( C:\Oracle\dbhomeXE\bin\oradim.exe -ACL -setperm diag -USER ORA_OraDB21Home1_SVCACCTS -OBJTYPE dir -OBJPATH C:\Oracle\oradata\ADVENTURESALES\AdventureSlspdb1 -RECURSE false ) 
mkdir C:\Oracle\oradata\ADVENTURESALES\pdbseed
if %ERRORLEVEL% == 0 ( C:\Oracle\dbhomeXE\bin\oradim.exe -ACL -setperm diag -USER ORA_OraDB21Home1_SVCACCTS -OBJTYPE dir -OBJPATH C:\Oracle\oradata\ADVENTURESALES\pdbseed -RECURSE false ) 
set PERL5LIB=%ORACLE_HOME%/rdbms/admin;%PERL5LIB%
set ORACLE_SID=AdventureSls
set PATH=%ORACLE_HOME%\bin;%ORACLE_HOME%\perl\bin;%PATH%
C:\Oracle\dbhomeXE\bin\oradim.exe -new -sid ADVENTURESLS -startmode manual -spfile 
C:\Oracle\dbhomeXE\bin\oradim.exe -edit -sid ADVENTURESLS -startmode auto -srvcstart system 
C:\Oracle\dbhomeXE\bin\sqlplus /nolog @C:\latOracle\AdventureSls.sql
