USE FIRMA_BUDOWLANA

--Zapytanie zwracaj�ce dokumenty kolekcji Sprzedawca

SELECT 'S' + CAST(Sprzedawca.idSprzedawcy AS VARCHAR) as '_id', Sprzedawca.nazwa as 'nazwa', TypSprzedawcy.nazwa as 'typSprzedawcy', TypSprzedawcy.klasyfikacjaWielkosci as 'klasyfikacjaWielkosci'
FROM Sprzedawca, TypSprzedawcy
WHERE TypSprzedawcy.idTypuSprzedawcy = Sprzedawca.idTypuSprzedawcy_FK
ORDER BY Sprzedawca.idSprzedawcy
FOR JSON PATH;

--Zapytanie zwracaj�ce dokumenty kolekcji TypTowaru

SELECT 'TT' + CAST(TypTowaru.idTypuTowaru AS VARCHAR) AS '_id', TypTowaru.nazwa AS 'nazwa' 
FROM TypTowaru
ORDER BY TypTowaru.idTypuTowaru
FOR JSON PATH;

--Zapytanie zwracaj�ce dokumenty kolekcji Lokalizacja

SELECT 'M' + CAST(Miasto.idMiasta AS VARCHAR) AS '_id', Miasto.nazwa AS 'miasto', Region.nazwa AS 'region', Panstwo.nazwa AS 'panstwo', Panstwo.czlonkostwoUE AS 'panstwoUE'
FROM Miasto, Region, Panstwo
WHERE Panstwo.idPanstwa = Region.idPanstwa_FK AND Region.idRegionu = Miasto.idRegionu_FK
ORDER BY Miasto.idMiasta
FOR JSON PATH;

--Zapytanie zwracaj�ce dokumenty kolekcji Czas

SELECT 'MC' + CAST(Miesiac.idMiesiaca AS VARCHAR) AS '_id', Miesiac.wartosc AS 'miesiac', Kwartal.wartosc AS 'kwartal', Rok.wartosc AS 'rok'
FROM Miesiac, Kwartal, Rok
WHERE Rok.idRoku = Kwartal.idRoku_FK AND Kwartal.idKwartalu = Miesiac.idKwartalu_FK
ORDER BY Miesiac.idMiesiaca
FOR JSON PATH;

--Zapytanie zwracaj�ce dokumenty kolekcji Zakup

SELECT z.idZakupu AS '_id', z.cenaNetto AS 'cenaNetto', z.stawkaVAT AS 'stawkaVAT', z.kwotaVAT AS 'kwotaVAT', z.cenaBrutto as 'cenaBrutto',
'S' + CAST(z.idSprzedawcy_FK AS VARCHAR) AS 'sprzedawca',
'M' + CAST(z.idMiasta_FK AS VARCHAR) AS 'lokalizacja',
'MC' + CAST(z.idDaty_FK AS VARCHAR) AS 'czas',
TypPlatnosci = 
	(SELECT TypPlatnosci.idTypuPlatnosci as '_id', TypPlatnosci.nazwa AS 'nazwa' 
	FROM TypPlatnosci 
	WHERE TypPlatnosci.idTypuPlatnosci = z.idTypuPlatnosci_FK
	FOR JSON PATH,WITHOUT_ARRAY_WRAPPER),
TypEwidencjiZakupu = 
	(SELECT TypEwidencjiZakupu.idTypuEwidencji as '_id', TypEwidencjiZakupu.nazwa AS 'nazwa'
	FROM TypEwidencjiZakupu
	WHERE TypEwidencjiZakupu.idTypuEwidencji = z.idTypuEwidencji_FK
	FOR JSON PATH, WITHOUT_ARRAY_WRAPPER),
'TT' + CAST(z.idTypuTowaru_FK AS VARCHAR) AS 'typTowaru'
FROM ZakupFCT z
ORDER BY z.idZakupu
FOR JSON PATH;

--Zapytanie zwracaj�ce dokumenty kolekcji RodzajUs�ugi

SELECT 'RU' + CAST(RodzajUslugi.idRodzajuUslugi AS VARCHAR) as '_id', RodzajUslugi.nazwa as 'nazwa', SekcjaUslugi.nazwa as 'sekcjaUslugi'
FROM RodzajUslugi, SekcjaUslugi
WHERE SekcjaUslugi.idSekcjiUslugi = RodzajUslugi.idSekcjiUslugi_FK
FOR JSON PATH;

--Zapytanie zwracaj�ce dokumenty kolekcji RodzajObiektu

SELECT 'RO' + CAST(RodzajObiektu.idRodzajuObiektu AS VARCHAR) as '_id', RodzajObiektu.nazwa as 'nazwa', RodzinaObiektu.nazwa as 'rodzinaObiektu'
FROM RodzajObiektu, RodzinaObiektu
WHERE RodzinaObiektu.idRodzinyObiektu = RodzajObiektu.idRodzinyObiektu_FK
FOR JSON PATH;

--Zapytanie zwracaj�ce dokumenty kolekcji Klient

SELECT 'K' + CAST(Klient.idKlienta AS VARCHAR) as '_id', Klient.nazwa as 'nazwa', GrupaKlienteli.nazwa as 'grupaKlienteli', TypKlienta.nazwa as 'typKlienta'
FROM Klient, GrupaKlienteli, TypKlienta
WHERE GrupaKlienteli.idGrupyKlienteli = Klient.idGrupyKlienteli_FK AND TypKlienta.idTypuKlienta = Klient.idTypuKlienta_FK
FOR JSON PATH;

--Zapytanie zwracaj�ce dokumenty kolekcji Us�uga

SELECT u.idUslugi as '_id', u.cenaNetto as 'cenaNetto', u.stawkaVAT as 'stawkaVAT', u.kwotaVAT as 'kwotaVAT', u.cenaBrutto as 'cenaBrutto',
u.stawkaPPE as 'stawkaPPE', u.kwotaPPE as 'kwotaPPE', u.iloscDniPlatnosci as 'iloscDniPlatnosci', u.satysfakcjaKlienta as 'satysfakcjaKlienta',
'K' + CAST(u.idKlienta_FK AS VARCHAR) AS 'klient',
TypUmowy = 
	(SELECT TypUmowy.idTypuUmowy as '_id', TypUmowy.nazwa as 'nazwa', TypUmowy.dlugoscGwarancji as 'dlugoscGwarancji', TypUmowy.zakupMaterialow as 'zakupMaterialow'
	FROM TypUmowy
	WHERE TypUmowy.idTypuUmowy = u.idTypuUmowy_FK
	FOR JSON PATH, WITHOUT_ARRAY_WRAPPER),
'RO' + CAST(u.idRodzajuObiektu_FK AS VARCHAR) AS 'obiekt',
TypEwidencjiSprzedazy = 
	(SELECT TypEwidencjiSprzedazy.idTypuEwidencji as '_id', TypEwidencjiSprzedazy.nazwa AS 'nazwa'
	FROM TypEwidencjiSprzedazy
	WHERE TypEwidencjiSprzedazy.idTypuEwidencji = u.idTypuEwidencji_FK
	FOR JSON PATH, WITHOUT_ARRAY_WRAPPER),
TypProjektu = 
	(SELECT TypProjektu.idTypuProjektu as '_id', TypProjektu.nazwa as 'nazwa'
	FROM TypProjektu
	WHERE TypProjektu.idTypuProjektu = u.idTypuProjektu_FK
	FOR JSON PATH, WITHOUT_ARRAY_WRAPPER),
'RU' + CAST(u.idRodzajuUslugi_FK AS VARCHAR) AS 'rodzajUslugi',
'MC' + CAST(u.idDaty_FK AS VARCHAR) AS 'czas',
'M' + CAST(u.idMiasta_FK AS VARCHAR) AS 'lokalizacja',
TypPlatnosci = 
	(SELECT TypPlatnosci.idTypuPlatnosci as '_id', TypPlatnosci.nazwa AS 'nazwa' 
	FROM TypPlatnosci 
	WHERE TypPlatnosci.idTypuPlatnosci = u.idTypuPlatnosci_FK
	FOR JSON PATH,WITHOUT_ARRAY_WRAPPER)
FROM UslugaFCT u
ORDER BY u.idUslugi
FOR JSON PATH;


--SELECT COUNT(*) FROM UslugaFCT;
--SELECT COUNT(*) FROM ZakupFCT;

-- Poradnik formatowania uzyskanych JSONów:

-- Otwieramy JSON w SSMS, Ctrl+H (zamieniamy kolejno)
-- "{ na {
-- }" na }
-- \" na "
-- I tyle.



