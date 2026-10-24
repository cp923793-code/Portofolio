ALTER DATABASE [sttwk_2025a_par] SET RECOVERY SIMPLE;
GO
CHECKPOINT; -- Force data to disk
GO
DBCC SHRINKFILE (sttwk_2025a_par_log, 100);
GO
ALTER DATABASE [sttwk_2025a_par] SET RECOVERY FULL; -- Switch back if needed
-------------------------------------------------------------------------
-- do above if below fail to shrink

use sttwk_2025a_par
DBCC SHRINKFILE (sttwk_2025a_par_log, 0); -- Shrinks to the minimum possible size
use sttyr
DBCC SHRINKFILE (sttyr_log, 0); -- Shrinks to the minimum possib	
use oltp
DBCC SHRINKFILE (oltp_log, 0); -- Shrinks to the minimum possib	
use sttwk_2025a
DBCC SHRINKFILE (sttwk_2025a_log, 0); -- Shrinks to the minimum possib	
use sttwk_2024d
DBCC SHRINKFILE (sttwk_2024d_log, 0); -- Shrinks to the minimum possib	
use sttwk_2025b
DBCC SHRINKFILE (sttwk_2025b_log, 0); -- Shrinks to the minimum possib	
use sttwk_2017d
DBCC SHRINKFILE (sttwk_2017d_log, 0); -- Shrinks to the minimum possib	
use adventuresales
DBCC SHRINKFILE (adventuresales_log, 0); -- Shrinks to the minimum possib	


USE tempdb;
SELECT name, physical_name
FROM sys.database_files;

USE master;
ALTER DATABASE tempdb
REMOVE FILE temp2;