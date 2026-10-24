USE [adventureSales]
GO
/****** Object:  Table [dbo].[AOP_Pct]    Script Date: 02/26/2025 11:29:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AOP_Pct](
	[Year] [smallint] NOT NULL,
	[Mth] [smallint] NOT NULL,
	[Week] [smallint] NOT NULL,
	[Pct] [numeric](5, 2) NULL,
 CONSTRAINT [PK_AOP_Pct] PRIMARY KEY CLUSTERED 
(
	[Year] ASC,
	[Mth] ASC,
	[Week] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
-- select *from aop_pct