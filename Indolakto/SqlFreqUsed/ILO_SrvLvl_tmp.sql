USE [AdventureSales]
 
GO

/****** Object:  Table [dbo].[ILO_SrvLvl_tmp]    Script Date: 18/04/2025 05:42:46 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[ILO_SrvLvl_tmp](
	[Brand] [nvarchar](255) NULL,
	[Year] [float] NULL,
	[Month] [float] NULL,
	[ITEM] [nvarchar](255) NULL,
	[Branch] [nvarchar](255) NULL,
	[DC] [nvarchar](255) NULL,
	[QTY_PO] [float] NULL,
	[RP_PO] [float] NULL,
	[QTY_REAL] [float] NULL,
	[RP_REAL] [float] NULL,
	[S/L] [float] NULL
) ON [PRIMARY]
GO

