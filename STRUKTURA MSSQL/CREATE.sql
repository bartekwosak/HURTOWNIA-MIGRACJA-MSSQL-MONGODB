USE [FIRMA_BUDOWLANA]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[GrupaKlienteli](
	[idGrupyKlienteli] [int] NOT NULL,
	[nazwa] [varchar](100) NOT NULL,
 CONSTRAINT [PK_GrupaKlienteli] PRIMARY KEY CLUSTERED 
(
	[idGrupyKlienteli] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Klient](
	[idKlienta] [int] NOT NULL,
	[nazwa] [varchar](200) NOT NULL,
	[idGrupyKlienteli_FK] [int] NOT NULL,
	[idTypuKlienta_FK] [int] NOT NULL,
 CONSTRAINT [PK_Klient] PRIMARY KEY CLUSTERED 
(
	[idKlienta] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Kwartal](
	[idKwartalu] [int] NOT NULL,
	[wartosc] [numeric](1, 0) NOT NULL,
	[idRoku_FK] [int] NOT NULL,
 CONSTRAINT [PK_Kwartał] PRIMARY KEY CLUSTERED 
(
	[idKwartalu] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Miasto](
	[idMiasta] [int] NOT NULL,
	[nazwa] [varchar](100) NOT NULL,
	[idRegionu_FK] [int] NOT NULL,
 CONSTRAINT [PK_Miasto] PRIMARY KEY CLUSTERED 
(
	[idMiasta] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Miesiac](
	[idMiesiaca] [int] NOT NULL,
	[wartosc] [numeric](2, 0) NOT NULL,
	[idKwartalu_FK] [int] NOT NULL,
 CONSTRAINT [PK_Miesiac] PRIMARY KEY CLUSTERED 
(
	[idMiesiaca] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Panstwo](
	[idPanstwa] [int] NOT NULL,
	[nazwa] [varchar](100) NOT NULL,
	[czlonkostwoUE] [numeric](1, 0) NOT NULL,
 CONSTRAINT [PK_Panstwo] PRIMARY KEY CLUSTERED 
(
	[idPanstwa] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Region](
	[idRegionu] [int] NOT NULL,
	[nazwa] [varchar](100) NOT NULL,
	[idPanstwa_FK] [int] NOT NULL,
 CONSTRAINT [PK_Powiat] PRIMARY KEY CLUSTERED 
(
	[idRegionu] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[RodzajObiektu](
	[idRodzajuObiektu] [int] NOT NULL,
	[nazwa] [varchar](100) NOT NULL,
	[idRodzinyObiektu_FK] [int] NOT NULL,
 CONSTRAINT [PK_RodzajObiektu] PRIMARY KEY CLUSTERED 
(
	[idRodzajuObiektu] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[RodzajUslugi](
	[idRodzajuUslugi] [int] NOT NULL,
	[nazwa] [varchar](200) NOT NULL,
	[idSekcjiUslugi_FK] [int] NOT NULL,
 CONSTRAINT [PK_RodzajUslugi] PRIMARY KEY CLUSTERED 
(
	[idRodzajuUslugi] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[RodzinaObiektu](
	[idRodzinyObiektu] [int] NOT NULL,
	[nazwa] [varchar](100) NOT NULL,
 CONSTRAINT [PK_RodzinaObiektu] PRIMARY KEY CLUSTERED 
(
	[idRodzinyObiektu] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Rok](
	[idRoku] [int] NOT NULL,
	[wartosc] [numeric](4, 0) NOT NULL,
 CONSTRAINT [PK_Rok] PRIMARY KEY CLUSTERED 
(
	[idRoku] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SekcjaUslugi](
	[idSekcjiUslugi] [int] NOT NULL,
	[nazwa] [varchar](200) NOT NULL,
 CONSTRAINT [PK_SekcjaUslugi] PRIMARY KEY CLUSTERED 
(
	[idSekcjiUslugi] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Sprzedawca](
	[idSprzedawcy] [int] NOT NULL,
	[nazwa] [varchar](100) NOT NULL,
	[idTypuSprzedawcy_FK] [int] NOT NULL,
 CONSTRAINT [PK_Sprzedawca] PRIMARY KEY CLUSTERED 
(
	[idSprzedawcy] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TypEwidencjiSprzedazy](
	[idTypuEwidencji] [int] NOT NULL,
	[nazwa] [varchar](100) NOT NULL,
 CONSTRAINT [PK_TypEwidencjiSprzedazy] PRIMARY KEY CLUSTERED 
(
	[idTypuEwidencji] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TypEwidencjiZakupu](
	[idTypuEwidencji] [int] NOT NULL,
	[nazwa] [varchar](100) NOT NULL,
 CONSTRAINT [PK_TypEwidencjiZakupu] PRIMARY KEY CLUSTERED 
(
	[idTypuEwidencji] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TypKlienta](
	[idTypuKlienta] [int] NOT NULL,
	[nazwa] [varchar](100) NOT NULL,
 CONSTRAINT [PK_TypKlienta] PRIMARY KEY CLUSTERED 
(
	[idTypuKlienta] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TypPlatnosci](
	[idTypuPlatnosci] [int] NOT NULL,
	[nazwa] [varchar](100) NOT NULL,
 CONSTRAINT [PK_TypPlatnosci] PRIMARY KEY CLUSTERED 
(
	[idTypuPlatnosci] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TypProjektu](
	[idTypuProjektu] [int] NOT NULL,
	[nazwa] [varchar](100) NOT NULL,
 CONSTRAINT [PK_TypProjektu] PRIMARY KEY CLUSTERED 
(
	[idTypuProjektu] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TypSprzedawcy](
	[idTypuSprzedawcy] [int] NOT NULL,
	[nazwa] [varchar](100) NOT NULL,
	[klasyfikacjaWielkosci] [varchar](100) NOT NULL,
 CONSTRAINT [PK_TypSprzedawcy] PRIMARY KEY CLUSTERED 
(
	[idTypuSprzedawcy] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TypTowaru](
	[idTypuTowaru] [int] NOT NULL,
	[nazwa] [varchar](100) NOT NULL,
 CONSTRAINT [PK_TypTowaru] PRIMARY KEY CLUSTERED 
(
	[idTypuTowaru] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TypUmowy](
	[idTypuUmowy] [int] NOT NULL,
	[nazwa] [varchar](100) NOT NULL,
	[dlugoscGwarancji] [numeric](4, 0) NOT NULL,
	[zakupMaterialow] [numeric](1, 0) NOT NULL,
 CONSTRAINT [PK_SzczegolyUmowy] PRIMARY KEY CLUSTERED 
(
	[idTypuUmowy] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[UslugaFCT](
	[idUslugi] [int] NOT NULL,
	[cenaNetto] [numeric](12, 2) NOT NULL,
	[stawkaVAT] [numeric](2, 0) NOT NULL,
	[kwotaVAT] [numeric](12, 2) NOT NULL,
	[cenaBrutto] [numeric](12, 2) NOT NULL,
	[stawkaPPE] [numeric](12, 2) NOT NULL,
	[kwotaPPE] [numeric](12, 2) NOT NULL,
	[iloscDniPlatnosci] [numeric](12, 2) NOT NULL,
	[satysfakcjaKlienta] [numeric](1, 0) NOT NULL,
	[idKlienta_FK] [int] NOT NULL,
	[idTypuUmowy_FK] [int] NOT NULL,
	[idRodzajuObiektu_FK] [int] NOT NULL,
	[idTypuEwidencji_FK] [int] NOT NULL,
	[idTypuProjektu_FK] [int] NOT NULL,
	[idRodzajuUslugi_FK] [int] NOT NULL,
	[idDaty_FK] [int] NOT NULL,
	[idMiasta_FK] [int] NOT NULL,
	[idTypuPlatnosci_FK] [int] NOT NULL,
 CONSTRAINT [PK_UslugaFCT] PRIMARY KEY CLUSTERED 
(
	[idUslugi] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ZakupFCT](
	[idZakupu] [int] NOT NULL,
	[cenaNetto] [numeric](12, 2) NOT NULL,
	[stawkaVAT] [numeric](12, 2) NOT NULL,
	[kwotaVAT] [numeric](12, 2) NOT NULL,
	[cenaBrutto] [numeric](12, 2) NOT NULL,
	[idSprzedawcy_FK] [int] NOT NULL,
	[idMiasta_FK] [int] NOT NULL,
	[idDaty_FK] [int] NOT NULL,
	[idTypuPlatnosci_FK] [int] NOT NULL,
	[idTypuEwidencji_FK] [int] NOT NULL,
	[idTypuTowaru_FK] [int] NOT NULL,
 CONSTRAINT [PK_Zakup] PRIMARY KEY CLUSTERED 
(
	[idZakupu] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Klient]  WITH NOCHECK ADD  CONSTRAINT [FK_Klient_GrupaKlienteli] FOREIGN KEY([idGrupyKlienteli_FK])
REFERENCES [dbo].[GrupaKlienteli] ([idGrupyKlienteli])
GO
ALTER TABLE [dbo].[Klient] CHECK CONSTRAINT [FK_Klient_GrupaKlienteli]
GO
ALTER TABLE [dbo].[Klient]  WITH NOCHECK ADD  CONSTRAINT [FK_Klient_Klient] FOREIGN KEY([idTypuKlienta_FK])
REFERENCES [dbo].[TypKlienta] ([idTypuKlienta])
GO
ALTER TABLE [dbo].[Klient] CHECK CONSTRAINT [FK_Klient_Klient]
GO
ALTER TABLE [dbo].[Kwartal]  WITH NOCHECK ADD  CONSTRAINT [FK_Kwartal_Rok] FOREIGN KEY([idRoku_FK])
REFERENCES [dbo].[Rok] ([idRoku])
GO
ALTER TABLE [dbo].[Kwartal] CHECK CONSTRAINT [FK_Kwartal_Rok]
GO
ALTER TABLE [dbo].[Miasto]  WITH NOCHECK ADD  CONSTRAINT [FK_Miasto_Region] FOREIGN KEY([idRegionu_FK])
REFERENCES [dbo].[Region] ([idRegionu])
GO
ALTER TABLE [dbo].[Miasto] CHECK CONSTRAINT [FK_Miasto_Region]
GO
ALTER TABLE [dbo].[Miesiac]  WITH NOCHECK ADD  CONSTRAINT [FK_Miesiac_Kwartal] FOREIGN KEY([idKwartalu_FK])
REFERENCES [dbo].[Kwartal] ([idKwartalu])
GO
ALTER TABLE [dbo].[Miesiac] CHECK CONSTRAINT [FK_Miesiac_Kwartal]
GO
ALTER TABLE [dbo].[Region]  WITH NOCHECK ADD  CONSTRAINT [FK_Region_Panstwo] FOREIGN KEY([idPanstwa_FK])
REFERENCES [dbo].[Panstwo] ([idPanstwa])
GO
ALTER TABLE [dbo].[Region] CHECK CONSTRAINT [FK_Region_Panstwo]
GO
ALTER TABLE [dbo].[RodzajObiektu]  WITH NOCHECK ADD  CONSTRAINT [FK_RodzajObiektu_RodzinaObiektu] FOREIGN KEY([idRodzinyObiektu_FK])
REFERENCES [dbo].[RodzinaObiektu] ([idRodzinyObiektu])
GO
ALTER TABLE [dbo].[RodzajObiektu] CHECK CONSTRAINT [FK_RodzajObiektu_RodzinaObiektu]
GO
ALTER TABLE [dbo].[RodzajUslugi]  WITH NOCHECK ADD  CONSTRAINT [FK_RodzajUslugi_RodzajUslugi] FOREIGN KEY([idSekcjiUslugi_FK])
REFERENCES [dbo].[SekcjaUslugi] ([idSekcjiUslugi])
GO
ALTER TABLE [dbo].[RodzajUslugi] CHECK CONSTRAINT [FK_RodzajUslugi_RodzajUslugi]
GO
ALTER TABLE [dbo].[Sprzedawca]  WITH NOCHECK ADD  CONSTRAINT [FK_Sprzedawca_TypSprzedawcy] FOREIGN KEY([idTypuSprzedawcy_FK])
REFERENCES [dbo].[TypSprzedawcy] ([idTypuSprzedawcy])
GO
ALTER TABLE [dbo].[Sprzedawca] CHECK CONSTRAINT [FK_Sprzedawca_TypSprzedawcy]
GO
ALTER TABLE [dbo].[UslugaFCT]  WITH NOCHECK ADD  CONSTRAINT [FK_UslugaFCT_Klient] FOREIGN KEY([idKlienta_FK])
REFERENCES [dbo].[Klient] ([idKlienta])
GO
ALTER TABLE [dbo].[UslugaFCT] CHECK CONSTRAINT [FK_UslugaFCT_Klient]
GO
ALTER TABLE [dbo].[UslugaFCT]  WITH NOCHECK ADD  CONSTRAINT [FK_UslugaFCT_Miasto] FOREIGN KEY([idMiasta_FK])
REFERENCES [dbo].[Miasto] ([idMiasta])
GO
ALTER TABLE [dbo].[UslugaFCT] CHECK CONSTRAINT [FK_UslugaFCT_Miasto]
GO
ALTER TABLE [dbo].[UslugaFCT]  WITH NOCHECK ADD  CONSTRAINT [FK_UslugaFCT_Miesiac] FOREIGN KEY([idDaty_FK])
REFERENCES [dbo].[Miesiac] ([idMiesiaca])
GO
ALTER TABLE [dbo].[UslugaFCT] CHECK CONSTRAINT [FK_UslugaFCT_Miesiac]
GO
ALTER TABLE [dbo].[UslugaFCT]  WITH NOCHECK ADD  CONSTRAINT [FK_UslugaFCT_RodzajObiektu] FOREIGN KEY([idRodzajuObiektu_FK])
REFERENCES [dbo].[RodzajObiektu] ([idRodzajuObiektu])
GO
ALTER TABLE [dbo].[UslugaFCT] CHECK CONSTRAINT [FK_UslugaFCT_RodzajObiektu]
GO
ALTER TABLE [dbo].[UslugaFCT]  WITH NOCHECK ADD  CONSTRAINT [FK_UslugaFCT_RodzajUslugi] FOREIGN KEY([idRodzajuUslugi_FK])
REFERENCES [dbo].[RodzajUslugi] ([idRodzajuUslugi])
GO
ALTER TABLE [dbo].[UslugaFCT] CHECK CONSTRAINT [FK_UslugaFCT_RodzajUslugi]
GO
ALTER TABLE [dbo].[UslugaFCT]  WITH NOCHECK ADD  CONSTRAINT [FK_UslugaFCT_TypEwidencjiSprzedazy] FOREIGN KEY([idTypuEwidencji_FK])
REFERENCES [dbo].[TypEwidencjiSprzedazy] ([idTypuEwidencji])
GO
ALTER TABLE [dbo].[UslugaFCT] CHECK CONSTRAINT [FK_UslugaFCT_TypEwidencjiSprzedazy]
GO
ALTER TABLE [dbo].[UslugaFCT]  WITH NOCHECK ADD  CONSTRAINT [FK_UslugaFCT_TypPlatnosci] FOREIGN KEY([idTypuPlatnosci_FK])
REFERENCES [dbo].[TypPlatnosci] ([idTypuPlatnosci])
GO
ALTER TABLE [dbo].[UslugaFCT] CHECK CONSTRAINT [FK_UslugaFCT_TypPlatnosci]
GO
ALTER TABLE [dbo].[UslugaFCT]  WITH NOCHECK ADD  CONSTRAINT [FK_UslugaFCT_TypProjektu] FOREIGN KEY([idTypuProjektu_FK])
REFERENCES [dbo].[TypProjektu] ([idTypuProjektu])
GO
ALTER TABLE [dbo].[UslugaFCT] CHECK CONSTRAINT [FK_UslugaFCT_TypProjektu]
GO
ALTER TABLE [dbo].[UslugaFCT]  WITH NOCHECK ADD  CONSTRAINT [FK_UslugaFCT_TypUmowy] FOREIGN KEY([idTypuUmowy_FK])
REFERENCES [dbo].[TypUmowy] ([idTypuUmowy])
GO
ALTER TABLE [dbo].[UslugaFCT] CHECK CONSTRAINT [FK_UslugaFCT_TypUmowy]
GO
ALTER TABLE [dbo].[ZakupFCT]  WITH NOCHECK ADD  CONSTRAINT [FK_Zakup_Miasto] FOREIGN KEY([idMiasta_FK])
REFERENCES [dbo].[Miasto] ([idMiasta])
GO
ALTER TABLE [dbo].[ZakupFCT] CHECK CONSTRAINT [FK_Zakup_Miasto]
GO
ALTER TABLE [dbo].[ZakupFCT]  WITH NOCHECK ADD  CONSTRAINT [FK_Zakup_Sprzedawca] FOREIGN KEY([idSprzedawcy_FK])
REFERENCES [dbo].[Sprzedawca] ([idSprzedawcy])
GO
ALTER TABLE [dbo].[ZakupFCT] CHECK CONSTRAINT [FK_Zakup_Sprzedawca]
GO
ALTER TABLE [dbo].[ZakupFCT]  WITH NOCHECK ADD  CONSTRAINT [FK_Zakup_TypPlatnosci] FOREIGN KEY([idTypuPlatnosci_FK])
REFERENCES [dbo].[TypPlatnosci] ([idTypuPlatnosci])
GO
ALTER TABLE [dbo].[ZakupFCT] CHECK CONSTRAINT [FK_Zakup_TypPlatnosci]
GO
ALTER TABLE [dbo].[ZakupFCT]  WITH NOCHECK ADD  CONSTRAINT [FK_ZakupFCT_Miesiac] FOREIGN KEY([idDaty_FK])
REFERENCES [dbo].[Miesiac] ([idMiesiaca])
GO
ALTER TABLE [dbo].[ZakupFCT] CHECK CONSTRAINT [FK_ZakupFCT_Miesiac]
GO
ALTER TABLE [dbo].[ZakupFCT]  WITH NOCHECK ADD  CONSTRAINT [FK_ZakupFCT_TypEwidencjiZakupu] FOREIGN KEY([idTypuEwidencji_FK])
REFERENCES [dbo].[TypEwidencjiZakupu] ([idTypuEwidencji])
GO
ALTER TABLE [dbo].[ZakupFCT] CHECK CONSTRAINT [FK_ZakupFCT_TypEwidencjiZakupu]
GO
ALTER TABLE [dbo].[ZakupFCT]  WITH NOCHECK ADD  CONSTRAINT [FK_ZakupFCT_TypTowaru] FOREIGN KEY([idTypuTowaru_FK])
REFERENCES [dbo].[TypTowaru] ([idTypuTowaru])
GO
ALTER TABLE [dbo].[ZakupFCT] CHECK CONSTRAINT [FK_ZakupFCT_TypTowaru]
GO
