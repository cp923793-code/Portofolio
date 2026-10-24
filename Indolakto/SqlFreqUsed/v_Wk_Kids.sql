USE [AdventureSales]
GO

/****** Object:  View [dbo].[v_Wk_Stc]    Script Date: 5/20/2025 9:43:58 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO






alter VIEW [dbo].[v_Wk_Kids]
AS
SELECT     year,month,week,custd_id,sum(net_qty) as net_qty,sum(net_amt) as net_amt
 from sttwk1a_kids  
  group by year,month,week,custd_id
 



GO

