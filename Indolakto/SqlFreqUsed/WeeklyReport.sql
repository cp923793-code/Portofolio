USE [DMS_DDI]
GO
/****** Object:  Table [dbo].[WeeklyReport]    Script Date: 05/23/2025 15:02:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[WeeklyReport](
	[DistCity] [varchar](50) NULL,
	[year] [int] NOT NULL,
	[type] [varchar](50) NOT NULL,
	[product] [varchar](50) NOT NULL,
	[mtdcolumn] [varchar](50) NOT NULL,
	[week] [char](5) NOT NULL,
	[qty] [int] NULL,
	[cycle] [int] NOT NULL,
	[distcode] [varchar](50) NOT NULL,
 CONSTRAINT [PK_WeeklyReport] PRIMARY KEY CLUSTERED 
(
	[year] ASC,
	[type] ASC,
	[product] ASC,
	[mtdcolumn] ASC,
	[week] ASC,
	[cycle] ASC,
	[distcode] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF