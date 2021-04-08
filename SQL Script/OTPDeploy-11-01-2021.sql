CREATE TABLE OdpoklicKupec(
	OdpoklicKupecID int IDENTITY(1,1) NOT NULL,
	RazpisPozicijaID int,
	RelacijaID int NULL,
	StatusID int NOT NULL,
	StevilkaNarocilnica varchar(200) NULL,
	CenaPrevoza decimal(18, 3) NULL,
	KolicinaSkupno decimal(18, 3) NOT NULL,
	Opis varchar(5000) NULL,
	SoferNaziv varchar(300) NULL,
	Registracija varchar(300) NULL,
	OdobritevKomentar varchar(5000) NULL,
	VrednostTransportaSk decimal (18, 3) NOT NULL,	
	ProcentTransportaSk decimal (18, 3) NOT NULL,	
	OdgovornaOseba varchar(5000) NULL,
	PodpisPrevoznikNaziv varchar(5000) NULL,
	tsIDOseba int NULL,
	ts datetime NULL CONSTRAINT DF_OdpoklicKupec_ts  DEFAULT (getdate()),	
	OdpoklicStevilkaKupec int NULL,
	UserID int NULL,
	RazlogOdobritveSistem varchar(4000) NULL,	
	ZbirnikTonID int NULL,
	IzdelanaNarocilnica bit NULL,
	NarocilnicaXML varchar(max) NULL,
	PovezaneFaktureXML varchar(max) NULL,
	OdpoklicKupecStevilka int
 CONSTRAINT PK_OdpoklicKupec PRIMARY KEY CLUSTERED 
(OdpoklicKupecID ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO

GO

ALTER TABLE OdpoklicKupec  WITH CHECK ADD  CONSTRAINT [FK_OdpoklicKupec_StatusOdpoklica] FOREIGN KEY(StatusID)
REFERENCES StatusOdpoklica (StatusOdpoklicaID)
GO

ALTER TABLE OdpoklicKupec  WITH CHECK ADD  CONSTRAINT FK_OdpoklicKupec_ZbirnikTonID FOREIGN KEY(ZbirnikTonID)
REFERENCES ZbirnikTon (ZbirnikTonID)
GO
ALTER TABLE OdpoklicKupec CHECK CONSTRAINT FK_OdpoklicKupec_ZbirnikTonID
GO

ALTER TABLE OdpoklicKupec  WITH CHECK ADD  CONSTRAINT FK_Relacija_OdpoklicKupec FOREIGN KEY(RelacijaID)
REFERENCES Relacija (RelacijaID)
GO

ALTER TABLE OdpoklicKupec  WITH CHECK ADD  CONSTRAINT FK_Odpoklic_RazpisPozicija FOREIGN KEY(RazpisPozicijaID)
REFERENCES RazpisPozicija(RazpisPozicijaID)
GO

ALTER TABLE OdpoklicKupec CHECK CONSTRAINT FK_Stranka_OdpoklicKupec
GO

ALTER TABLE OdpoklicKupec  WITH CHECK ADD  CONSTRAINT FK_KupecUserID FOREIGN KEY(UserID)
REFERENCES Osebe_OTP(idOsebe)
GO

ALTER TABLE OdpoklicKupec CHECK CONSTRAINT FK_KupecUserID
GO


CREATE TABLE OdpoklicKupecPozicija(
	OdpoklicKupecPozicijaID int IDENTITY(1,1) NOT NULL,
	OdpoklicKupecID int NOT NULL,
	TipVnosa int,
	Kljuc varchar(300) NULL,
	DatumVnosa datetime NULL,
	Valuta varchar(10) NULL,
	Kupec varchar(2500) NULL,
	Prevzemnik varchar(2500) NULL,
	Kolicina decimal (18, 3) NOT NULL,	
	Vrednost decimal(18,3),
	ZaporednaStevilka int,
	VrednostTransporta decimal (18, 3) NOT NULL,	
	OdpoklicKupecStevilka int,
	ProcentTransporta decimal (18, 3) NOT NULL,	
	tsIDOseba int NULL,
	ts datetime NULL CONSTRAINT DF_OdpoklicKupecPozicija_ts  DEFAULT (getdate()),	
 CONSTRAINT PK_OdpoklicKupecPozicija PRIMARY KEY CLUSTERED 
(
	OdpoklicKupecPozicijaID ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO

ALTER TABLE OdpoklicKupecPozicija  WITH CHECK ADD  CONSTRAINT FK_OdpoklicKupecPozicija_Odpoklic FOREIGN KEY(OdpoklicKupecID)
REFERENCES OdpoklicKupec (OdpoklicKupecID)
ON DELETE CASCADE
GO

ALTER TABLE [dbo].[OdpoklicPozicija] CHECK CONSTRAINT [FK_OdpoklicPozicija_Odpoklic]
GO

USE [GrafolitOTP_Prod1]
GO
/****** Object:  UserDefinedFunction [dbo].[SeznamNepovezanihFaktur]    Script Date: 13. 01. 2021 08:51:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE FUNCTION SeznamNepovezanihFaktur()
RETURNS TABLE 
AS
RETURN 
SELECT      LEFT(G.acKey, 2) + '-' + SUBSTRING(G.acKey, 3, 3) + '-' + RIGHT(G.acKey, 6) AS Kljuc,
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
group by LEFT(G.acKey, 2) + '-' + SUBSTRING(G.acKey, 3, 3) + '-' + RIGHT(G.acKey, 6), G.adDate, G.acCurrency, G.acReceiver, acPrsn3, G.anValue





