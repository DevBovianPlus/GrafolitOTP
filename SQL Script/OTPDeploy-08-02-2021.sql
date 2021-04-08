

ALTER FUNCTION [dbo].[SeznamNepovezanihFaktur]()
RETURNS TABLE 
AS
RETURN 
SELECT      LEFT(G.acKey, 2) + '-' + SUBSTRING(G.acKey, 3, 3) + '-' + RIGHT(G.acKey, 6) AS Kljuc,
			G.acKey,
            G.adDate AS Datum,
            G.acCurrency AS Valuta,
            G.acReceiver AS Kupec,
            acPrsn3 AS Prevzemnik,
			sum(MI.anQty) as Kolicina,			
			G.anValue as ZnesekFakture
FROM Grafolit55SI.dbo.tHE_Move G
	  left join Grafolit55SI.dbo.tHE_MoveItem MI
			on MI.acKey = G.acKey
      LEFT JOIN Grafolit55SI.dbo._epos_GTLink GT
            ON G.ackey = GT.LinkKljuc
WHERE G.acDocType IN ('3600', '3900', '3910', '3920', '3930', '3960')
      AND GT.LinkKljuc IS NULL 
and Year(G.adDate) = 2020 and Month(G.adDate) = 12 and Day(G.adDate) > 1
group by LEFT(G.acKey, 2) + '-' + SUBSTRING(G.acKey, 3, 3) + '-' + RIGHT(G.acKey, 6), G.acKey, G.adDate, G.acCurrency, G.acReceiver, acPrsn3, G.anValue





