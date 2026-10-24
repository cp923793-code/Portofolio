USE [AdventureSales]
 
GO

/****** Object:  Table [dbo].[ICE_Sell_In_tmp]    Script Date: 18/04/2025 05:39:07 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[ICE_Sell_In_tmp](
	[Status] [nvarchar](255) NULL,
	[Year] [float] NULL,
	[Month] [float] NULL,
	[ITEM] [nvarchar](255) NULL,
	[Branch] [nvarchar](255) NULL,
	[DC] [nvarchar](255) NULL,
	[RecQty] [float] NULL,
	[RtnQty] [float] NULL,
	[NetQty] [float] NULL,
	[RecAmt] [float] NULL,
	[RtnAmt] [float] NULL,
	[NetAmt] [float] NULL
) ON [PRIMARY]
GO

