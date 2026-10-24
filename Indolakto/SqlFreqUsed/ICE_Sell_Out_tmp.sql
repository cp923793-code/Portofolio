USE [AdventureSales]
 
GO

/****** Object:  Table [dbo].[ICE_Sell_Out_tmp]    Script Date: 18/04/2025 05:36:16 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[ICE_Sell_Out_tmp](
	[Status] [nvarchar](255) NULL,
	[Year] [float] NULL,
	[Month] [float] NULL,
	[ITEM] [nvarchar](255) NULL,
	[Branch] [nvarchar](255) NULL,
	[DC] [nvarchar](255) NULL,
	[QTY] [float] NULL,
	[IDR] [float] NULL
) ON [PRIMARY]
GO

