USE FIRMA_BUDOWLANA

SELECT idUslugi, cenaNetto, stawkaVAT, kwotaVAT, cenaBrutto, stawkaPPE, kwotaPPE, iloscDniPlatnosci, satysfakcjaKlienta, Klient.nazwa,
TypUmowy.nazwa, TypUmowy.dlugoscGwarancji, RodzajObiektu.nazwa, 
TypEwidencjiSprzedazy.nazwa, TypProjektu.nazwa, RodzajUslugi.nazwa, Miesiac.wartosc, Miasto.nazwa,
TypPlatnosci.nazwa 
FROM UslugaFCT, TypUmowy, RodzajObiektu, TypEwidencjiSprzedazy, TypProjektu, RodzajUslugi, Miesiac, Miasto, TypPlatnosci, Klient
WHERE Klient.idKlienta = UslugaFCT.idKlienta_FK AND TypUmowy.idTypuUmowy = UslugaFCT.idTypuUmowy_FK AND RodzajObiektu.idRodzajuObiektu = UslugaFCT.idRodzajuObiektu_FK
AND TypEwidencjiSprzedazy.idTypuEwidencji = UslugaFCT.idTypuEwidencji_FK AND TypProjektu.idTypuProjektu = UslugaFCT.idTypuProjektu_FK AND RodzajUslugi.idRodzajuUslugi = UslugaFCT.idRodzajuUslugi_FK
AND Miesiac.idMiesiaca = UslugaFCT.idDaty_FK AND Miasto.idMiasta = UslugaFCT.idMiasta_FK AND TypPlatnosci.idTypuPlatnosci = UslugaFCT.idTypuPlatnosci_FK;

db.getCollection("Usluga").find({}, 
    { 
        "_id" : "$_id", 
        "cenaNetto" : "$cenaNetto", 
        "stawkaVAT" : "$stawkaVAT", 
        "kwotaVAT" : "$kwotaVAT", 
        "cenaBrutto" : "$cenaBrutto", 
        "stawkaPPE" : "$stawkaPPE", 
        "kwotaPPE" : "$kwotaPPE", 
        "iloscDniPlatnosci" : "$iloscDniPlatnosci", 
        "satysfakcjaKlienta" : "$satysfakcjaKlienta", 
        "Klient.nazwa" : "$Klient.nazwa", 
        "TypUmowy.nazwa" : "$TypUmowy.nazwa", 
        "TypUmowy.dlugoscGwarancji" : "$TypUmowy.dlugoscGwarancji", 
        "RodzajObiektu.nazwa" : "$RodzajObiektu.nazwa", 
        "TypEwidencjiSprzedazy.nazwa" : "$TypEwidencjiSprzedazy.nazwa", 
        "TypProjektu.nazwa" : "$TypProjektu.nazwa", 
        "RodzajUslugi.nazwa" : "$RodzajUslugi.nazwa", 
        "Data.miesiac" : "$Data.miesiac", 
        "Data.rok" : "$Data.rok", 
        "Miasto.miasto" : "$Miasto.miasto", 
        "Miasto.region" : "$Miasto.region"
    }
).explain("executionStats"); 
(183 ms)

//####################################################################

SELECT * FROM UslugaFCT;

db.getCollection("Usluga").find({}) 
(23ms)

//####################################################################

SELECT Klient.nazwa, RodzajUslugi.nazwa, Rok.wartosc, SUM(cenaNetto), SUM(cenaBrutto)
FROM Klient, RodzajUslugi, Rok, UslugaFCT
WHERE Klient.idKlienta = UslugaFCT.idKlienta_FK AND RodzajUslugi.idRodzajuUslugi = UslugaFCT.idRodzajuUslugi_FK
GROUP BY Klient.nazwa, RodzajUslugi.nazwa, Rok.wartosc
ORDER BY SUM(cenaNetto), SUM(cenaBrutto);

db.getCollection("Usluga").aggregate(
    [
        { 
            "$group" : {
                "_id" : {
                    "Klient᎐nazwa" : "$Klient.nazwa", 
                    "RodzajUslugi᎐nazwa" : "$RodzajUslugi.nazwa", 
                    "Data᎐rok" : "$Data.rok"
                }, 
                "SUM(cenaNetto)" : {
                    "$sum" : "$cenaNetto"
                }, 
                "SUM(cenaBrutto)" : {
                    "$sum" : "$cenaBrutto"
                }
            }
        }, 
        { 
            "$project" : {
                "Klient.nazwa" : "$_id.Klient᎐nazwa", 
                "RodzajUslugi.nazwa" : "$_id.RodzajUslugi᎐nazwa", 
                "Data.rok" : "$_id.Data᎐rok", 
                "SUM(cenaNetto)" : "$SUM(cenaNetto)", 
                "SUM(cenaBrutto)" : "$SUM(cenaBrutto)", 
                "_id" : NumberInt(0)
            }
        }, 
        { 
            "$sort" : {
                "SUM(cenaNetto)" : NumberInt(1), 
                "SUM(cenaBrutto)" : NumberInt(1)
            }
        }
    ], 
    { 
        "allowDiskUse" : true
    }
);

//####################################################################

SELECT Klient.nazwa, TypUmowy.nazwa, Miasto.nazwa, SUM(cenaBrutto), SUM(cenaNetto), AVG(kwotaPPE), COUNT(UslugaFCT.idUslugi)
FROM UslugaFCT, Klient, TypUmowy, Miasto
WHERE Klient.idKlienta = UslugaFCT.idKlienta_FK AND TypUmowy.idTypuUmowy = UslugaFCT.idTypuUmowy_FK AND Miasto.idMiasta = UslugaFCT.idMiasta_FK
GROUP BY Klient.nazwa, TypUmowy.nazwa, Miasto.nazwa
HAVING COUNT(UslugaFCT.idUslugi) > 10
ORDER BY Klient.nazwa

db.getCollection("Usluga").aggregate(
    [
        { 
            "$group" : {
                "_id" : {
                    "Usluga᎐_id" : "$Usluga._id", 
                    "Klient᎐nazwa" : "$Klient.nazwa", 
                    "TypUmowy᎐nazwa" : "$TypUmowy.nazwa", 
                    "Miasto᎐miasto" : "$Miasto.miasto"
                }, 
                "SUM(cenaBrutto)" : {
                    "$sum" : "$cenaBrutto"
                }, 
                "SUM(cenaNetto)" : {
                    "$sum" : "$cenaNetto"
                }, 
                "AVG(kwotaPPE)" : {
                    "$avg" : "$kwotaPPE"
                }, 
                "COUNT(_id)" : {
                    "$sum" : NumberInt(1)
                }
            }
        }, 
        { 
            "$project" : {
                "Klient.nazwa" : "$_id.Klient᎐nazwa", 
                "TypUmowy.nazwa" : "$_id.TypUmowy᎐nazwa", 
                "Miasto.miasto" : "$_id.Miasto᎐miasto", 
                "SUM(cenaBrutto)" : "$SUM(cenaBrutto)", 
                "SUM(cenaNetto)" : "$SUM(cenaNetto)", 
                "AVG(kwotaPPE)" : "$AVG(kwotaPPE)", 
                "COUNT(_id)" : "$COUNT(_id)", 
                "_id" : NumberInt(0)
            }
        }, 
        { 
            "$match" : {
                "COUNT(_id)" : {
                    "$gt" : NumberLong(10)
                }
            }
        }, 
        { 
            "$group" : {
                "_id" : null, 
                "distinct" : {
                    "$addToSet" : "$$ROOT"
                }
            }
        }, 
        { 
            "$unwind" : {
                "path" : "$distinct", 
                "preserveNullAndEmptyArrays" : false
            }
        }, 
        { 
            "$replaceRoot" : {
                "newRoot" : "$distinct"
            }
        }, 
        { 
            "$sort" : {
                "Klient.nazwa" : NumberInt(1)
            }
        }
    ], 
    { 
        "allowDiskUse" : true
    }
);

//####################################################################
//####################################################################
//####################################################################
USE FIRMA_BUDOWLANA

SELECT * FROM ZakupFCT;

db.getCollection("Zakup").find({});

//####################################################################

USE FIRMA_BUDOWLANA

SELECT ZakupFCT.idZakupu, ZakupFCT.cenaNetto, ZakupFCT.stawkaVAT, ZakupFCT.kwotaVAT, ZakupFCT.cenaBrutto,
Sprzedawca.nazwa, Miasto.nazwa, Miesiac.wartosc, Rok.wartosc, TypPlatnosci.nazwa, TypEwidencjiZakupu.nazwa, TypTowaru.nazwa
FROM ZakupFCT, Sprzedawca, Miasto, Miesiac, Rok, Kwartal, TypPlatnosci, TypEwidencjiZakupu, TypTowaru
WHERE ZakupFCT.idSprzedawcy_FK = Sprzedawca.idSprzedawcy AND ZakupFCT.idMiasta_FK = Miasto.idMiasta
AND Miesiac.idMiesiaca = ZakupFCT.idDaty_FK AND Miesiac.idKwartalu_FK = Kwartal.idKwartalu AND Kwartal.idRoku_FK = Rok.idRoku
AND TypPlatnosci.idTypuPlatnosci = ZakupFCT.idTypuPlatnosci_FK AND TypEwidencjiZakupu.idTypuEwidencji = ZakupFCT.idTypuEwidencji_FK
AND TypTowaru.idTypuTowaru = ZakupFCT.idTypuTowaru_FK
ORDER BY ZakupFCT.idZakupu;

db.getCollection("Zakup").find({}, 
    { 
        "_id" : "$_id", 
        "cenaNetto" : "$cenaNetto", 
        "stawkaVAT" : "$stawkaVAT", 
        "kwotaVAT" : "$kwotaVAT", 
        "cenaBrutto" : "$cenaBrutto", 
        "Sprzedawca.nazwa" : "$Sprzedawca.nazwa", 
        "Miasto.miasto" : "$Miasto.miasto", 
        "Data.miesiac" : "$Data.miesiac", 
        "Data.rok" : "$Data.rok", 
        "TypPlatnosci.nazwa" : "$TypPlatnosci.nazwa", 
        "TypEwidencjiZakupu.nazwa" : "$TypEwidencjiZakupu.nazwa", 
        "TypTowaru.nazwa" : "$TypTowaru.nazwa"
    }
).sort(
    { 
        "_id" : NumberInt(1)
    }
);

//####################################################################

USE FIRMA_BUDOWLANA

SELECT Sprzedawca.nazwa, TypTowaru.nazwa, Rok.wartosc, SUM(ZakupFCT.cenaNetto), SUM(ZakupFCT.kwotaVAT),
SUM(ZakupFCT.cenaBrutto), COUNT(ZakupFCT.idZakupu)
FROM ZakupFCT, Sprzedawca, TypTowaru, Rok, Kwartal, Miesiac
WHERE Sprzedawca.idSprzedawcy = ZakupFCT.idSprzedawcy_FK AND TypTowaru.idTypuTowaru = ZakupFCT.idTypuTowaru_FK AND
Rok.idRoku = Kwartal.idRoku_FK AND Kwartal.idKwartalu = Miesiac.idKwartalu_FK AND Miesiac.idMiesiaca = ZakupFCT.idDaty_FK
GROUP BY Sprzedawca.nazwa, TypTowaru.nazwa, Rok.wartosc
ORDER BY COUNT(ZakupFCT.idZakupu), SUM(ZakupFCT.cenaNetto);

db.getCollection("Zakup").aggregate(
    [
        { 
            "$group" : {
                "_id" : {
                    "TypTowaru᎐nazwa" : "$TypTowaru.nazwa", 
                    "Sprzedawca᎐nazwa" : "$Sprzedawca.nazwa", 
                    "Data᎐rok" : "$Data.rok"
                }, 
                "SUM(cenaNetto)" : {
                    "$sum" : "$cenaNetto"
                }, 
                "SUM(kwotaVAT)" : {
                    "$sum" : "$kwotaVAT"
                }, 
                "SUM(cenaBrutto)" : {
                    "$sum" : "$cenaBrutto"
                }, 
                "COUNT(_id)" : {
                    "$sum" : NumberInt(1)
                }
            }
        }, 
        { 
            "$project" : {
                "Sprzedawca.nazwa" : "$_id.Sprzedawca᎐nazwa", 
                "TypTowaru.nazwa" : "$_id.TypTowaru᎐nazwa", 
                "Data.rok" : "$_id.Data᎐rok", 
                "SUM(cenaNetto)" : "$SUM(cenaNetto)", 
                "SUM(kwotaVAT)" : "$SUM(kwotaVAT)", 
                "SUM(cenaBrutto)" : "$SUM(cenaBrutto)", 
                "COUNT(_id)" : "$COUNT(_id)", 
                "_id" : NumberInt(0)
            }
        }, 
        { 
            "$sort" : {
                "Sprzedawca.nazwa" : NumberInt(1), 
                "COUNT(_id)" : NumberInt(1), 
                "SUM(cenaNetto)" : NumberInt(1)
            }
        }
    ], 
    { 
        "allowDiskUse" : true
    }
);

//####################################################################

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

db.getCollection("Zakup").aggregate(
    [
        { 
            "$group" : {
                "_id" : {
                    "TypEwidencjiZakupu᎐nazwa" : "$TypEwidencjiZakupu.nazwa", 
                    "TypTowaru᎐nazwa" : "$TypTowaru.nazwa", 
                    "Miasto᎐region" : "$Miasto.region", 
                    "Data᎐kwartal" : "$Data.kwartal", 
                    "Miasto᎐miasto" : "$Miasto.miasto", 
                    "Data᎐rok" : "$Data.rok"
                }, 
                "COUNT(_id)" : {
                    "$sum" : NumberInt(1)
                }, 
                "AVG(cenaNetto)" : {
                    "$avg" : "$cenaNetto"
                }, 
                "AVG(cenaBrutto)" : {
                    "$avg" : "$cenaBrutto"
                }, 
                "SUM(kwotaVAT)" : {
                    "$sum" : "$kwotaVAT"
                }
            }
        }, 
        { 
            "$project" : {
                "Miasto.miasto" : "$_id.Miasto᎐miasto", 
                "Miasto.region" : "$_id.Miasto᎐region", 
                "TypEwidencjiZakupu.nazwa" : "$_id.TypEwidencjiZakupu᎐nazwa", 
                "TypTowaru.nazwa" : "$_id.TypTowaru᎐nazwa", 
                "Data.kwartal" : "$_id.Data᎐kwartal", 
                "Data.rok" : "$_id.Data᎐rok", 
                "COUNT(_id)" : "$COUNT(_id)", 
                "AVG(cenaNetto)" : "$AVG(cenaNetto)", 
                "AVG(cenaBrutto)" : "$AVG(cenaBrutto)", 
                "SUM(kwotaVAT)" : "$SUM(kwotaVAT)", 
                "_id" : NumberInt(0)
            }
        }, 
        { 
            "$match" : {
                "COUNT(_id)" : {
                    "$gt" : NumberLong(10)
                }
            }
        }, 
        { 
            "$sort" : {
                "Data.rok" : NumberInt(1), 
                "Data.kwartal" : NumberInt(1), 
                "Miasto.miasto" : NumberInt(1), 
                "Miasto.region" : NumberInt(1)
            }
        }
    ], 
    { 
        "allowDiskUse" : true
    }
);