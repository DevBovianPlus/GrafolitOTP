update Grafolit55SI.dbo.tHE_OrderItem set _oc = 'yyy' where acKey = '2002500000016'
update Grafolit55SI.dbo.tHE_OrderItem set _oc = 'bbb' where acKey = '2002500000014'
update Grafolit55SI.dbo.tHE_OrderItem set _oc = 'bbb' where acKey = '2002500000005'
update Grafolit55SI.dbo.tHE_OrderItem set _oc = 'mmm' where acKey = '2002500000020'

select * from SeznamPozicijOdprtihNarocilnicGledeNaDobavitelja('FEDRIGONI S.P.A.              ')

SELECT * FROM Grafolit55SI.dbo.tHE_Order AS G
      JOIN Grafolit55SI.dbo.tHE_OrderItem AS P
            ON G.acKey = P.acKey
WHERE
      1=1 
	  --and G.acDocType IN ('0250') 
	  AND (G.acStatus IN (' ', '1', '2')) AND (G.adDate >= '20150101') AND acConsignee = 'FEDRIGONI S.P.A.              '
  order by G.adTimeIns desc

SELECT * FROM Grafolit55SI.dbo.tHE_Order AS G
WHERE
      1=1 
	  --and G.acDocType IN ('0250') 
	  AND acConsignee = 'FEDRIGONI S.P.A.              '
	  order by adTimeIns desc

select * from Relacija

select _oc from Grafolit55SI.dbo.tHE_OrderItem
select _oc from Grafolit55SI.dbo.tHE_SetItem