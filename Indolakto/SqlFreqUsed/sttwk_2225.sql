USE [AdventureSales]
GO

/****** Object:  Table [dbo].[STTWK_2225]    Script Date: 08/12/2025 16:51:36 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[STTWK_2225](
	[branch_id] [nvarchar](max) NULL,
	[sp_id] [nvarchar](max) NULL,
	[custd_id] [nvarchar](max) NULL,
	[prod_id] [nvarchar](max) NULL,
	[sls_id] [nvarchar](max) NULL,
	[year] [decimal](4, 0) NULL,
	[month] [nvarchar](max) NULL,
	[week] [decimal](2, 0) NULL,
	[net_qty] [decimal](12, 4) NULL,
	[net_amt] [decimal](18, 4) NULL,
	[grs_qty] [decimal](12, 4) NULL,
	[grs_amt] [decimal](18, 4) NULL,
	[rtn_qty] [decimal](10, 2) NULL,
	[rtn_amt] [decimal](15, 2) NULL,
	[year_week_int] [decimal](9, 0) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO

