USE FIRMA_BUDOWLANA


--Zapytanie zwracające dokumenty kolekcji Zakup

SELECT z.idZakupu AS '_id', z.cenaNetto AS 'cenaNetto', z.stawkaVAT AS 'stawkaVAT', z.kwotaVAT AS 'kwotaVAT', z.cenaBrutto as 'cenaBrutto',
Sprzedawca = 
	(SELECT Sprzedawca.idSprzedawcy as '_id', Sprzedawca.nazwa as 'nazwa', TypSprzedawcy.nazwa as 'typSprzedawcy', TypSprzedawcy.klasyfikacjaWielkosci as 'klasyfikacjaWielkosci'
	FROM Sprzedawca, TypSprzedawcy
	WHERE TypSprzedawcy.idTypuSprzedawcy = Sprzedawca.idTypuSprzedawcy_FK AND Sprzedawca.idSprzedawcy = z.idSprzedawcy_FK
	FOR JSON PATH, WITHOUT_ARRAY_WRAPPER),
Miasto =
	(SELECT Miasto.idMiasta AS '_id', Miasto.nazwa AS 'miasto', Region.nazwa AS 'region', Panstwo.nazwa AS 'panstwo', Panstwo.czlonkostwoUE AS 'panstwoUE'
	FROM Miasto, Region, Panstwo
	WHERE Panstwo.idPanstwa = Region.idPanstwa_FK AND Region.idRegionu = Miasto.idRegionu_FK AND Miasto.idMiasta = z.idMiasta_FK
	FOR JSON PATH, WITHOUT_ARRAY_WRAPPER),
Data =
	(SELECT Miesiac.idMiesiaca AS '_id', Miesiac.wartosc AS 'miesiac', Kwartal.wartosc AS 'kwartal', Rok.wartosc AS 'rok'
	FROM Miesiac, Kwartal, Rok
	WHERE Rok.idRoku = Kwartal.idRoku_FK AND Kwartal.idKwartalu = Miesiac.idKwartalu_FK AND Miesiac.idMiesiaca = z.idDaty_FK
	FOR JSON PATH, WITHOUT_ARRAY_WRAPPER),
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
TypTowaru =
	(SELECT TypTowaru.idTypuTowaru AS '_id', TypTowaru.nazwa AS 'nazwa' 
	FROM TypTowaru
	WHERE TypTowaru.idTypuTowaru = z.idTypuTowaru_FK
	FOR JSON PATH, WITHOUT_ARRAY_WRAPPER)
FROM ZakupFCT z
ORDER BY z.idZakupu
FOR JSON PATH;


--Zapytanie zwracające dokumenty kolekcji Usluga

SELECT u.idUslugi as '_id', u.cenaNetto as 'cenaNetto', u.stawkaVAT as 'stawkaVAT', u.kwotaVAT as 'kwotaVAT', u.cenaBrutto as 'cenaBrutto',
u.stawkaPPE as 'stawkaPPE', u.kwotaPPE as 'kwotaPPE', u.iloscDniPlatnosci as 'iloscDniPlatnosci', u.satysfakcjaKlienta as 'satysfakcjaKlienta',
Klient =
	(SELECT Klient.idKlienta as '_id', Klient.nazwa as 'nazwa', GrupaKlienteli.nazwa as 'grupaKlienteli', TypKlienta.nazwa as 'typKlienta'
	FROM Klient, GrupaKlienteli, TypKlienta
	WHERE GrupaKlienteli.idGrupyKlienteli = Klient.idGrupyKlienteli_FK AND TypKlienta.idTypuKlienta = Klient.idTypuKlienta_FK
		AND Klient.idKlienta = u.idKlienta_FK
	FOR JSON PATH, WITHOUT_ARRAY_WRAPPER),
TypUmowy = 
	(SELECT TypUmowy.idTypuUmowy as '_id', TypUmowy.nazwa as 'nazwa', TypUmowy.dlugoscGwarancji as 'dlugoscGwarancji', TypUmowy.zakupMaterialow as 'zakupMaterialow'
	FROM TypUmowy
	WHERE TypUmowy.idTypuUmowy = u.idTypuUmowy_FK
	FOR JSON PATH, WITHOUT_ARRAY_WRAPPER),
RodzajObiektu = 
	(SELECT RodzajObiektu.idRodzajuObiektu as '_id', RodzajObiektu.nazwa as 'nazwa', RodzinaObiektu.nazwa as 'rodzinaObiektu'
	FROM RodzajObiektu, RodzinaObiektu
	WHERE RodzinaObiektu.idRodzinyObiektu = RodzajObiektu.idRodzinyObiektu_FK AND RodzajObiektu.idRodzajuObiektu = u.idRodzajuObiektu_FK
	FOR JSON PATH, WITHOUT_ARRAY_WRAPPER),
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
RodzajUslugi = 
	(SELECT RodzajUslugi.idRodzajuUslugi as '_id', RodzajUslugi.nazwa as 'nazwa', SekcjaUslugi.nazwa as 'sekcjaUslugi'
	FROM RodzajUslugi, SekcjaUslugi
	WHERE SekcjaUslugi.idSekcjiUslugi = RodzajUslugi.idSekcjiUslugi_FK AND RodzajUslugi.idRodzajuUslugi = u.idRodzajuUslugi_FK
	FOR JSON PATH, WITHOUT_ARRAY_WRAPPER),
Data =
	(SELECT Miesiac.idMiesiaca AS '_id', Miesiac.wartosc AS 'miesiac', Kwartal.wartosc AS 'kwartal', Rok.wartosc AS 'rok'
	FROM Miesiac, Kwartal, Rok
	WHERE Rok.idRoku = Kwartal.idRoku_FK AND Kwartal.idKwartalu = Miesiac.idKwartalu_FK AND Miesiac.idMiesiaca = u.idDaty_FK
	FOR JSON PATH, WITHOUT_ARRAY_WRAPPER),
Miasto = 
	(SELECT Miasto.idMiasta AS '_id', Miasto.nazwa AS 'miasto', Region.nazwa AS 'region', Panstwo.nazwa AS 'panstwo', Panstwo.czlonkostwoUE AS 'panstwoUE'
	FROM Miasto, Region, Panstwo
	WHERE Panstwo.idPanstwa = Region.idPanstwa_FK AND Region.idRegionu = Miasto.idRegionu_FK AND Miasto.idMiasta = u.idMiasta_FK
	FOR JSON PATH, WITHOUT_ARRAY_WRAPPER), 
TypPlatnosci = 
	(SELECT TypPlatnosci.idTypuPlatnosci as '_id', TypPlatnosci.nazwa AS 'nazwa' 
	FROM TypPlatnosci 
	WHERE TypPlatnosci.idTypuPlatnosci = u.idTypuPlatnosci_FK
	FOR JSON PATH,WITHOUT_ARRAY_WRAPPER)
FROM UslugaFCT u
ORDER BY u.idUslugi
FOR JSON PATH;



