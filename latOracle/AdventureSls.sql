set verify off
ACCEPT sysPassword CHAR PROMPT 'Enter new password for SYS: ' HIDE
ACCEPT systemPassword CHAR PROMPT 'Enter new password for SYSTEM: ' HIDE
ACCEPT pdbAdminPassword CHAR PROMPT 'Enter new password for PDBADMIN: ' HIDE
host C:\Oracle\dbhomeXE\bin\orapwd.exe file=C:\Oracle\database\PWDAdventureSls.ora force=y format=12
@C:\latOracle\CloneRmanRestore.sql
@C:\latOracle\cloneDBCreation.sql
@C:\latOracle\plug_PDBSeed.sql
@C:\latOracle\postScripts.sql
@C:\latOracle\lockAccount.sql
@C:\latOracle\postDBCreation.sql
@C:\latOracle\PDBCreation.sql
@C:\latOracle\plug_AdventureSlspdb1.sql
@C:\latOracle\postPDBCreation_AdventureSlspdb1.sql
@C:\latOracle\customScripts.sql
