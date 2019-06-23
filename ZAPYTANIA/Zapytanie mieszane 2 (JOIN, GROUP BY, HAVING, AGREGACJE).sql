USE FIRMA_BUDOWLANA

DECLARE @t1 DATETIME;
DECLARE @t2 DATETIME;

SET @t1 = GETDATE();
SELECT Klient.nazwa, TypUmowy.nazwa, Miasto.nazwa, SUM(cenaBrutto), SUM(cenaNetto), AVG(kwotaPPE), COUNT(UslugaFCT.idUslugi)
FROM UslugaFCT, Klient, TypUmowy, Miasto
WHERE Klient.idKlienta = UslugaFCT.idKlienta_FK AND TypUmowy.idTypuUmowy = UslugaFCT.idTypuUmowy_FK AND Miasto.idMiasta = UslugaFCT.idMiasta_FK
GROUP BY Klient.nazwa, TypUmowy.nazwa, Miasto.nazwa
HAVING COUNT(UslugaFCT.idUslugi) > 10
ORDER BY Klient.nazwa
SET @t2 = GETDATE();
SELECT DATEDIFF(millisecond,@t1,@t2) AS elapsed_ms;