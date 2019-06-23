USE FIRMA_BUDOWLANA

DECLARE @t1 DATETIME;
DECLARE @t2 DATETIME;

SET @t1 = GETDATE();
SELECT Sprzedawca.nazwa, TypTowaru.nazwa, Rok.wartosc, SUM(ZakupFCT.cenaNetto), SUM(ZakupFCT.kwotaVAT),
SUM(ZakupFCT.cenaBrutto), COUNT(ZakupFCT.idZakupu)
FROM ZakupFCT, Sprzedawca, TypTowaru, Rok, Kwartal, Miesiac
WHERE Sprzedawca.idSprzedawcy = ZakupFCT.idSprzedawcy_FK AND TypTowaru.idTypuTowaru = ZakupFCT.idTypuTowaru_FK AND
Rok.idRoku = Kwartal.idRoku_FK AND Kwartal.idKwartalu = Miesiac.idKwartalu_FK AND Miesiac.idMiesiaca = ZakupFCT.idDaty_FK
GROUP BY Sprzedawca.nazwa, TypTowaru.nazwa, Rok.wartosc
ORDER BY COUNT(ZakupFCT.idZakupu), SUM(ZakupFCT.cenaNetto);
SET @t2 = GETDATE();
SELECT DATEDIFF(millisecond,@t1,@t2) AS elapsed_ms;