USE AdventureSales
GO
/****** Object:  View [dbo].[v_MotoristSTT]    Script Date: 09/18/2024 19:50:46 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- select *from sttmotorist
alter VIEW [dbo].[v_MotoristSTT]
AS
SELECT     a.region,a.branch_name,a.year, a.month, a.week, 'KIDS' AS prod_grp, sum(net_qty) as net_qty,sum(net_amt) as net_amt
FROM         adventuresales_lower2019.dbo.SttMotorist AS a 
WHERE     (psub_id LIKE 'kid%') 
GROUP BY a.region,a.branch_name,a.year, a.month, a.week

UNION ALL
SELECT     a.region,a.branch_name,a.year, a.month, a.week, 'SCI' AS prod_grp, sum(net_qty) as net_qty,sum(net_amt) as net_amt
FROM         adventuresales_lower2019.dbo.SttMotorist AS a
WHERE     (psub_id LIKE 'sci%')
GROUP BY a.region,a.branch_name,a.year, a.month, a.week

UNION ALL
SELECT     a.region,a.branch_name,a.year, a.month, a.week, 'U190' AS prod_grp, sum(net_qty) as net_qty,sum(net_amt) as net_amt
FROM         adventuresales_lower2019.dbo.SttMotorist AS a 
WHERE     (psub_id LIKE 'U%190%')  
GROUP BY a.region,a.branch_name,a.year, a.month, a.week

UNION ALL
SELECT     a.region,a.branch_name,a.year, a.month, a.week, psub_id AS prod_grp, sum(net_qty) as net_qty,sum(net_amt) as net_amt
FROM         adventuresales_lower2019.dbo.SttMotorist AS a 
WHERE     (psub_id LIKE 'lab%')  or (psub_id LIKE 'pouc%') or (psub_id LIKE 'tet%')  
 GROUP BY a.region,a.branch_name,a.year, a.month, a.week,psub_id
UNION ALL
SELECT     a.region,a.branch_name,a.year, a.month, a.week, psub_id1 AS prod_grp, sum(net_qty) as net_qty,sum(net_amt) as net_amt
FROM         adventuresales_lower2019.dbo.SttMotorist AS a 
WHERE     (psub_id LIKE 'sb%')  
 GROUP BY a.region,a.branch_name,a.year, a.month, a.week,psub_id1
UNION ALL
SELECT     a.region,a.branch_name,a.year, a.month, a.week, 'STC' AS prod_grp, sum(net_qty) as net_qty,sum(net_amt) as net_amt
FROM         adventuresales_lower2019.dbo.SttMotorist AS a 
WHERE     (psub_id LIKE 'stc%')  
 GROUP BY a.region,a.branch_name,a.year, a.month, a.week

--select *from adventuresales_lower2019.dbo.SttMotorist where psub_id like 'stc%'
/*
insert into v_motoristSTT_tbl
SELECT     a.region,a.branch_name,a.year, a.month, a.week, 'STC' AS prod_grp, sum(net_qty) as net_qty,sum(net_amt) as net_amt
FROM         adventuresales_lower2019.dbo.SttMotorist AS a 
WHERE     (psub_id LIKE 'stc%')  
 GROUP BY a.region,a.branch_name,a.year, a.month, a.week
*/