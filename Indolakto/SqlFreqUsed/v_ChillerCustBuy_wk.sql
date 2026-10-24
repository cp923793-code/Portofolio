USE [AdventureSales]
GO

/****** Object:  View [dbo].[v_ChillerCustBuy_wk]    Script Date: 07/11/2024 12:29:04 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

ALTER VIEW [dbo].[v_ChillerCustBuy_wk]
AS
SELECT     a.year, a.month, a.week, 'U115' AS prod_grp, COUNT(DISTINCT a.custd_id) AS CustBuy
FROM         dbo.sttwk1a_Liq AS a LEFT OUTER JOIN
                      dbo.product AS b ON a.prod_id = b.prod_id inner join
 dbo.chillertoko_1_2_3  AS c on a.custd_id=c.kode_iap
WHERE     (b.psub_id LIKE 'kid%') AND (a.net_qty > 0) AND (c.DISPLAY = 'chiller') AND (c.crm = 'N') AND (c.notrn21 = 'N') 

GROUP BY a.year, a.month, a.week
UNION ALL
SELECT     a.year, a.month, a.week, 'SCI' AS prod_grp, COUNT(DISTINCT a.custd_id) AS CustBuy
FROM         dbo.sttwk1a_Liq AS a LEFT OUTER JOIN
                      dbo.product AS b ON a.prod_id = b.prod_id inner join
 dbo.chillertoko_1_2_3  AS c on a.custd_id=c.kode_iap
WHERE     (b.psub_id LIKE 'sci%') and prod_name like '%19%' AND (a.net_qty > 0) AND (c.DISPLAY = 'chiller') AND (c.crm = 'N') AND (c.notrn21 = 'N') 

GROUP BY a.year, a.month, a.week
UNION ALL
SELECT     a.year, a.month, a.week, 'U190' AS prod_grp, COUNT(DISTINCT a.custd_id) AS CustBuy
FROM         dbo.sttwk1a_Liq AS a LEFT OUTER JOIN
                      dbo.product AS b ON a.prod_id = b.prod_id inner join
 dbo.chillertoko_1_2_3  AS c on a.custd_id=c.kode_iap
 WHERE     (b.psub_id LIKE 'U%190%') AND (a.net_qty > 0) AND (c.DISPLAY = 'chiller') AND (c.crm = 'N') AND (c.notrn21 = 'N') 
GROUP BY a.year, a.month, a.week
union all
SELECT     a.year, a.month, a.week, 'LAB70'  AS prod_grp, COUNT(DISTINCT a.custd_id) AS CustBuy
FROM         dbo.sttwk1a_mk AS a LEFT OUTER JOIN
                      dbo.product AS b ON a.prod_id = b.prod_id inner join
 dbo.chillertoko_1_2_3  AS c on a.custd_id=c.kode_iap
WHERE     (b.psub_id LIKE 'LAB70%') AND (a.net_qty > 0) AND (c.DISPLAY = 'chiller') AND (c.crm = 'N') AND (c.notrn21 = 'N') 
GROUP BY a.year, a.month, a.week
union all
SELECT     a.year, a.month, a.week, 'LAB130'  AS prod_grp, COUNT(DISTINCT a.custd_id) AS CustBuy
FROM         dbo.sttwk1a_mk AS a LEFT OUTER JOIN
                      dbo.product AS b ON a.prod_id = b.prod_id inner join
 dbo.chillertoko_1_2_3  AS c on a.custd_id=c.kode_iap
WHERE     (b.psub_id LIKE 'LAB130%') AND (a.net_qty > 0) AND (c.DISPLAY = 'chiller') AND (c.crm = 'N') AND (c.notrn21 = 'N') 
GROUP BY a.year, a.month, a.week
union all
SELECT     a.year, a.month, a.week, 'POUCH'  AS prod_grp, COUNT(DISTINCT a.custd_id) AS CustBuy
FROM         dbo.sttwk1a_mk AS a LEFT OUTER JOIN
                      dbo.product AS b ON a.prod_id = b.prod_id inner join
 dbo.chillertoko_1_2_3  AS c on a.custd_id=c.kode_iap
WHERE     (b.psub_id LIKE 'POUCH%') AND (a.net_qty > 0) AND (c.DISPLAY = 'chiller') AND (c.crm = 'N') AND (c.notrn21 = 'N') 
GROUP BY a.year, a.month, a.week
union all
SELECT     a.year, a.month, a.week, 'TETRA'  AS prod_grp, COUNT(DISTINCT a.custd_id) AS CustBuy
FROM         dbo.sttwk1a_mk AS a LEFT OUTER JOIN
                      dbo.product AS b ON a.prod_id = b.prod_id inner join
 dbo.chillertoko_1_2_3  AS c on a.custd_id=c.kode_iap
WHERE     (b.psub_id LIKE 'TETRA%') AND (a.net_qty > 0) AND (c.DISPLAY = 'chiller') AND (c.crm = 'N') AND (c.notrn21 = 'N') 

GROUP BY a.year, a.month, a.week

GO

