USE FIRMA_BUDOWLANA

DECLARE @t1 DATETIME;
DECLARE @t2 DATETIME;

SET @t1 = GETDATE();
SELECT Miasto.nazwa, Region.nazwa, TypEwidencjiZakupu.nazwa, TypTowaru.nazwa, Kwartal.wartosc, Rok.wartosc,
COUNT(ZakupFCT.idZakupu), AVG(ZakupFCT.cenaNetto), AVG(ZakupFCT.cenaBrutto), SUM(ZakupFCT.kwotaVAT)
FROM Miasto, Region, TypEwidencjiZakupu, TypTowaru, Miesiac, Kwartal, Rok, ZakupFCT
WHERE Miasto.idMiasta = ZakupFCT.idMiasta_FK AND Region.idRegionu = Miasto.idRegionu_FK 
AND TypEwidencjiZakupu.idTypuEwidencji = ZakupFCT.idTypuEwidencji_FK
AND TypTowaru.idTypuTowaru = ZakupFCT.idTypuTowaru_FK AND Kwartal.idKwartalu = Miesiac.idKwartalu_FK 
AND Miesiac.idMiesiaca = ZakupFCT.idDaty_FK
AND Rok.idRoku = Kwartal.idRoku_FK
GROUP BY Miasto.nazwa, Region.nazwa, TypEwidencjiZakupu.nazwa, TypTowaru.nazwa, Kwartal.wartosc, Rok.wartosc
HAVING COUNT(ZakupFCT.idZakupu) > 10
ORDER BY Rok.wartosc, Kwartal.wartosc, Miasto.nazwa, Region.nazwa;
SET @t2 = GETDATE();
SELECT DATEDIFF(millisecond,@t1,@t2) AS elapsed_ms;