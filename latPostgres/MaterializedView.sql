CREATE MATERIALIZED VIEW sales_summary_by_week AS
SELECT
    year,
    week,
    sum(net_qty) AS net_qty
FROM
    sttwk
GROUP BY
    year,
    week
ORDER BY
    year,
    week;
