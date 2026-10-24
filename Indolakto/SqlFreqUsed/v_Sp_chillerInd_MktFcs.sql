USE [AdventureSales]
GO

/****** Object:  View [dbo].[v_SP_STT25_AOP25]    Script Date: 6/3/2025 6:19:47 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO











--select *from qtrPct_AOP


ALTER VIEW [dbo].[v_Sp_chillerInd_MktFcs]    
AS    
  select distinct sp_id from
  (select distinct substring(custd_id,11,8) AS SP_ID from chiller_independen  
  union all
   select distinct substring(custd_ID,11,8) AS SP_ID FROM MKT_FOCUS_OUTLET
   ) AS A
 

GO

