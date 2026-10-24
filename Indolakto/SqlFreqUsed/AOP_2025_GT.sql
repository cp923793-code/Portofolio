USE [AdventureSales]
GO
/****** Object:  Table [dbo].[AOP_2025_GT]    Script Date: 02/26/2025 10:15:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[AOP_2025_GT](
	[PSub_Id] [varchar](30) NULL,
	[Year] [smallint] NULL,
	[Mth] [smallint] NULL,
	[sub_channel] [varchar](50) NULL,
	[Net_qty] [numeric](13, 2) NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF

-- select *from aop_2025_gt