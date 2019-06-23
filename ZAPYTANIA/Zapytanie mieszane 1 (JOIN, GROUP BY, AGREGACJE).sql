USE FIRMA_BUDOWLANA

DECLARE @t1 DATETIME;
DECLARE @t2 DATETIME;

SET @t1 = GETDATE();
SELECT Klient.nazwa, RodzajUslugi.nazwa, Rok.wartosc, SUM(cenaNetto), SUM(cenaBrutto)
FROM Klient, RodzajUslugi, Rok, UslugaFCT, Kwartal, Miesiac
WHERE Klient.idKlienta = UslugaFCT.idKlienta_FK AND RodzajUslugi.idRodzajuUslugi = UslugaFCT.idRodzajuUslugi_FK
AND Rok.idRoku = Kwartal.idRoku_FK AND Kwartal.idKwartalu = Miesiac.idKwartalu_FK AND Miesiac.idMiesiaca = UslugaFCT.idDaty_FK
GROUP BY Klient.nazwa, RodzajUslugi.nazwa, Rok.wartosc
ORDER BY SUM(cenaNetto), SUM(cenaBrutto);
SET @t2 = GETDATE();
SELECT DATEDIFF(millisecond,@t1,@t2) AS elapsed_ms;