USE FIRMA_BUDOWLANA

-- TypSprzedawcy
SELECT 'TS' + CAST(TypSprzedawcy.idTypuSprzedawcy AS VARCHAR) as '_id', TypSprzedawcy.nazwa as 'nazwa', TypSprzedawcy.klasyfikacjaWielkosci as 'klasyfikacjaWielkosci'
FROM TypSprzedawcy
FOR JSON PATH;

--Sprzedawca
SELECT 'S' + CAST(Sprzedawca.idSprzedawcy AS VARCHAR) as '_id', Sprzedawca.nazwa as 'nazwa', 'TS' + CAST(Sprzedawca.idTypuSprzedawcy_FK AS VARCHAR) AS 'typSprzedawcy'
FROM Sprzedawca
FOR JSON PATH;

--TypEwidencjiZakupu
SELECT 'TEZ' + CAST(TypEwidencjiZakupu.idTypuEwidencji AS VARCHAR) as '_id', TypEwidencjiZakupu.nazwa as 'nazwa'
FROM TypEwidencjiZakupu
FOR JSON PATH;

--TypPlatnosci
SELECT 'TP' + CAST(TypPlatnosci.idTypuPlatnosci AS VARCHAR) as '_id', TypPlatnosci.nazwa as 'nazwa' 
FROM TypPlatnosci
FOR JSON PATH;

--Panstwo
SELECT 'P' + CAST(Panstwo.idPanstwa AS VARCHAR) as '_id', Panstwo.nazwa as 'nazwa', Panstwo.czlonkostwoUE as 'czlonkostwoUE'
FROM Panstwo
FOR JSON PATH;

--Region
SELECT 'R' + CAST(Region.idRegionu AS VARCHAR) as '_id', Region.nazwa as 'nazwa', 'P' + CAST(Region.idPanstwa_FK AS VARCHAR) AS 'panstwo'
FROM Region
FOR JSON PATH;

--Miasto
SELECT 'M' + CAST(Miasto.idMiasta AS VARCHAR) as '_id', Miasto.nazwa as 'nazwa', 'R' + CAST(Miasto.idRegionu_FK AS VARCHAR) AS 'region'
FROM Miasto
FOR JSON PATH;

--TypTowaru
SELECT 'TT' + CAST(TypTowaru.idTypuTowaru AS VARCHAR) as '_id', TypTowaru.nazwa as 'nazwa'
FROM TypTowaru
FOR JSON PATH;

--Rok
SELECT 'ROK' + CAST(Rok.idRoku AS VARCHAR) as '_id', Rok.wartosc as 'wartosc'
FROM Rok
FOR JSON PATH;

--Kwartal
SELECT 'KW' + CAST(Kwartal.idKwartalu AS VARCHAR) as '_id', Kwartal.wartosc as 'wartosc', 'ROK' + CAST(Kwartal.idRoku_FK AS VARCHAR) AS 'rok'
FROM Kwartal
FOR JSON PATH;

--Miesiac
SELECT 'MC' + CAST(Miesiac.idMiesiaca AS VARCHAR) as '_id', Miesiac.wartosc as 'wartosc', 'KW' + CAST(Miesiac.idKwartalu_FK AS VARCHAR) AS 'kwartal'
FROM Miesiac
FOR JSON PATH;

--ZakupFCT
SELECT 'Z' + CAST(ZakupFCT.idZakupu AS VARCHAR) as '_id', ZakupFCT.cenaNetto as 'cenaNetto', ZakupFCT.stawkaVAT as 'stawkaVAT', ZakupFCT.kwotaVAT as 'kwotaVAT', ZakupFCT.cenaBrutto 'cenaBrutto',
'S' + CAST(ZakupFCT.idSprzedawcy_FK AS VARCHAR) AS 'sprzedawca',
'M' + CAST(ZakupFCT.idMiasta_FK AS VARCHAR) AS 'miasto',
'MC' + CAST(ZakupFCT.idDaty_FK AS VARCHAR) AS 'data',
'TP' + CAST(ZakupFCT.idTypuPlatnosci_FK AS VARCHAR) AS 'typPlatnosci',
'TEZ' + CAST(ZakupFCT.idTypuEwidencji_FK AS VARCHAR) AS 'typEwidencjiZakupu',
'TT' + CAST(ZakupFCT.idTypuTowaru_FK AS VARCHAR) AS 'typTowaru'
FROM ZakupFCT
FOR JSON PATH;

--RodzinaObiektu
SELECT 'RODI' + CAST(RodzinaObiektu.idRodzinyObiektu AS VARCHAR) as '_id', RodzinaObiektu.nazwa as 'nazwa'
FROM RodzinaObiektu
FOR JSON PATH;

--RodzajObiektu
SELECT 'RODZ' + CAST(RodzajObiektu.idRodzajuObiektu AS VARCHAR) as '_id', RodzajObiektu.nazwa as 'nazwa', 
'RODI' + CAST(RodzajObiektu.idRodzinyObiektu_FK AS VARCHAR) AS 'rodzinaObiektu'
FROM RodzajObiektu
FOR JSON PATH;

--SekcjaUslugi
SELECT 'SU' + CAST(SekcjaUslugi.idSekcjiUslugi AS VARCHAR) as '_id', SekcjaUslugi.nazwa as 'nazwa'
FROM SekcjaUslugi
FOR JSON PATH;

--RodzajUslugi
SELECT 'RU' + CAST(RodzajUslugi.idRodzajuUslugi AS VARCHAR) as '_id', RodzajUslugi.nazwa as 'nazwa',
'SU' + CAST(RodzajUslugi.idSekcjiUslugi_FK AS VARCHAR) AS 'sekcjaUslugi'
FROM RodzajUslugi
FOR JSON PATH;

--TypUmowy
SELECT 'TU' + CAST(TypUmowy.idTypuUmowy AS VARCHAR) as '_id', TypUmowy.nazwa as 'nazwa', TypUmowy.dlugoscGwarancji as 'dlugoscGwarancji', 
TypUmowy.zakupMaterialow as 'zakupMaterialow'
FROM TypUmowy
FOR JSON PATH;

--TypProjektu
SELECT 'TPP' + CAST(TypProjektu.idTypuProjektu AS VARCHAR) as '_id', TypProjektu.nazwa as 'nazwa'
FROM TypProjektu
FOR JSON PATH;

--TypKlienta
SELECT 'TK' + CAST(TypKlienta.idTypuKlienta AS VARCHAR) as '_id', TypKlienta.nazwa as 'nazwa'
FROM TypKlienta
FOR JSON PATH;

--GrupaKlienteli
SELECT 'GK' + CAST(GrupaKlienteli.idGrupyKlienteli AS VARCHAR) as '_id', GrupaKlienteli.nazwa as 'nazwa'
FROM GrupaKlienteli
FOR JSON PATH;

--Klient
SELECT 'K' + CAST(Klient.idKlienta AS VARCHAR) as '_id', Klient.nazwa as 'nazwa',
'GK' + CAST(Klient.idGrupyKlienteli_FK AS VARCHAR) AS 'grupaKlienteli',
'TK' + CAST(Klient.idTypuKlienta_FK AS VARCHAR) AS 'typKlienta'
FROM Klient
FOR JSON PATH;

--TypEwidencjiSprzedazy
SELECT 'TES' + CAST(TypEwidencjiSprzedazy.idTypuEwidencji AS VARCHAR) as '_id', TypEwidencjiSprzedazy.nazwa as 'nazwa'
FROM TypEwidencjiSprzedazy
FOR JSON PATH;

--UslugaFCT
SELECT UslugaFCT.idUslugi as '_id', UslugaFCT.cenaNetto as 'cenaNetto', UslugaFCT.stawkaVAT as 'stawkaVAT',
UslugaFCT.kwotaVAT as 'kwotaVAT', UslugaFCT.cenaBrutto as 'cenaBrutto', UslugaFCT.stawkaPPE as 'stawkaPPE', UslugaFCT.kwotaPPE as 'kwotaPPE',
'K' + CAST(UslugaFCT.idKlienta_FK AS VARCHAR) AS 'klient',
'TU' + CAST(UslugaFCT.idTypuUmowy_FK AS VARCHAR) AS 'typUmowy',
'RODZ' + CAST(UslugaFCT.idRodzajuObiektu_FK AS VARCHAR) AS 'rodzajObiektu',
'TES' + CAST(UslugaFCT.idTypuEwidencji_FK AS VARCHAR) AS 'typEwidencjiSprzedazy',
'TPP' + CAST(UslugaFCT.idTypuProjektu_FK AS VARCHAR) AS 'typProjektu',
'RU' + CAST(UslugaFCT.idRodzajuUslugi_FK AS VARCHAR) AS 'rodzajUslugi',
'MC' + CAST(UslugaFCT.idDaty_FK AS VARCHAR) AS 'data',
'M' + CAST(UslugaFCT.idMiasta_FK AS VARCHAR) AS 'miasto',
'TP' + CAST(UslugaFCT.idTypuPlatnosci_FK AS VARCHAR) AS 'typPlatnosci'
FROM UslugaFCT
FOR JSON PATH;