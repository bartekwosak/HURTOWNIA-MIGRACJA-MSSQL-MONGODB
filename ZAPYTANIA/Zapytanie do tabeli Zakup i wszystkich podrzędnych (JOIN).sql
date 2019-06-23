USE FIRMA_BUDOWLANA

DECLARE @t1 DATETIME;
DECLARE @t2 DATETIME;

SET @t1 = GETDATE();
SELECT ZakupFCT.idZakupu, ZakupFCT.cenaNetto, ZakupFCT.stawkaVAT, ZakupFCT.kwotaVAT, ZakupFCT.cenaBrutto,
Sprzedawca.nazwa, Miasto.nazwa, Miesiac.wartosc, Rok.wartosc, TypPlatnosci.nazwa, TypEwidencjiZakupu.nazwa, TypTowaru.nazwa
FROM ZakupFCT, Sprzedawca, Miasto, Miesiac, Rok, Kwartal, TypPlatnosci, TypEwidencjiZakupu, TypTowaru
WHERE ZakupFCT.idSprzedawcy_FK = Sprzedawca.idSprzedawcy AND ZakupFCT.idMiasta_FK = Miasto.idMiasta
AND Miesiac.idMiesiaca = ZakupFCT.idDaty_FK AND Miesiac.idKwartalu_FK = Kwartal.idKwartalu AND Kwartal.idRoku_FK = Rok.idRoku
AND TypPlatnosci.idTypuPlatnosci = ZakupFCT.idTypuPlatnosci_FK AND TypEwidencjiZakupu.idTypuEwidencji = ZakupFCT.idTypuEwidencji_FK
AND TypTowaru.idTypuTowaru = ZakupFCT.idTypuTowaru_FK
ORDER BY ZakupFCT.idZakupu;
SET @t2 = GETDATE();
SELECT DATEDIFF(millisecond,@t1,@t2) AS elapsed_ms;