SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

ALTER  VIEW dbo.v_ActiveOutletTotal
AS
SELECT     a.Distributor_Code, f.AreaDesc AS Distributor_Area, a.Distributor_City, d.DistBranch, a.Distributor_Depo, a.Outlet_type, a.year_num, a.month_num, a.month_name, 
                      a.KodePos, a.Kelurahan, a.outlet_motorist, a.Act_Outlet, a.Carton, a.Ton, a.Grossttl, e.SeqArea AS seqsubArea, e.AreaDesc, f.SeqArea, d.SeqRpt, 
                      '               ' AS Who_Ret, '       ' AS otyp, '                                    ' AS dummyarea, '                    ' AS indo, '                    ' AS WestEast
FROM         (SELECT     Distributor_Code, Distributor_Area, Distributor_City, Distributor_Depo, Outlet_type, year_num, month_num, month_name, KodePos, Kelurahan, 
                                              outlet_motorist, COUNT(DISTINCT Outlet_ID) AS Act_Outlet, SUM(CartonTtl) AS Carton, SUM(TonTtl) AS Ton, SUM(GrossTtl) AS Grossttl
                       FROM          dbo.v_Trans_Sum_Outlet_SKU_2010_2011
                       GROUP BY Distributor_Code, Distributor_Area, Distributor_City, Distributor_Depo, Outlet_type, year_num, month_num, month_name, KodePos, Kelurahan, 
                                              outlet_motorist) a LEFT OUTER JOIN
                      dbo.tr_distributor_rpt d ON a.Distributor_Code = d.DistCode LEFT OUTER JOIN
                      dbo.tr_area_rpt e ON d.AreaRpt = e.AreaCd LEFT OUTER JOIN
                      dbo.tr_area_rpt f ON e.PrntArea = f.AreaCd

GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

