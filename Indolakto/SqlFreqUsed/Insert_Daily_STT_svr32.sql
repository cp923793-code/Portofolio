USE [AdventureSales]
GO
/****** Object:  StoredProcedure [dbo].[Insert_TD_STTDaily]    Script Date: 02/01/2025 14:55:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--USE [AdventureSales]

create PROCEDURE [dbo].[Insert_Daily_STT]
	-- Add the parameters for the stored procedure here
 
AS
BEGIN
-- upload UpdDaily.csv first into UpdDaily

exec Insert_TD_STTDaily

end