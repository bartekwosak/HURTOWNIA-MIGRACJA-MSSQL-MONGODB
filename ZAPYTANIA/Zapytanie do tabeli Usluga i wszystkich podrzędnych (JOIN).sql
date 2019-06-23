USE FIRMA_BUDOWLANA

DECLARE @t1 DATETIME;
DECLARE @t2 DATETIME;

SET @t1 = GETDATE();
SELECT idUslugi, cenaNetto, stawkaVAT, kwotaVAT, cenaBrutto, stawkaPPE, kwotaPPE, iloscDniPlatnosci, satysfakcjaKlienta, Klient.nazwa,
TypUmowy.nazwa, TypUmowy.dlugoscGwarancji, RodzajObiektu.nazwa, 
TypEwidencjiSprzedazy.nazwa, TypProjektu.nazwa, RodzajUslugi.nazwa, Miesiac.wartosc, Miasto.nazwa,
TypPlatnosci.nazwa 
FROM UslugaFCT, TypUmowy, RodzajObiektu, TypEwidencjiSprzedazy, TypProjektu, RodzajUslugi, Miesiac, Miasto, TypPlatnosci, Klient
WHERE Klient.idKlienta = UslugaFCT.idKlienta_FK AND TypUmowy.idTypuUmowy = UslugaFCT.idTypuUmowy_FK AND RodzajObiektu.idRodzajuObiektu = UslugaFCT.idRodzajuObiektu_FK
AND TypEwidencjiSprzedazy.idTypuEwidencji = UslugaFCT.idTypuEwidencji_FK AND TypProjektu.idTypuProjektu = UslugaFCT.idTypuProjektu_FK AND RodzajUslugi.idRodzajuUslugi = UslugaFCT.idRodzajuUslugi_FK
AND Miesiac.idMiesiaca = UslugaFCT.idDaty_FK AND Miasto.idMiasta = UslugaFCT.idMiasta_FK AND TypPlatnosci.idTypuPlatnosci = UslugaFCT.idTypuPlatnosci_FK;
SET @t2 = GETDATE();
SELECT DATEDIFF(millisecond,@t1,@t2) AS elapsed_ms;