USE [AdventureSales]
GO

/****** Object:  Table [dbo].[UpdDaily]    Script Date: 10/04/2025 10:24:35 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[UpdDaily](
	[Distcode] [varchar](50) NULL,
	[trDate] [smalldatetime] NULL,
	[Type] [varchar](20) NULL,
	[Product] [varchar](50) NULL,
	[SubProd] [varchar](50) NULL,
	[Flavor] [varchar](50) NULL,
	[Qty] [decimal](9, 2) NULL
) ON [PRIMARY]
GO

-- select *from upddaily