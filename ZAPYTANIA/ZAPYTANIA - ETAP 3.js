USE FIRMA_BUDOWLANA

SELECT idUslugi, cenaNetto, stawkaVAT, kwotaVAT, cenaBrutto, stawkaPPE, kwotaPPE, iloscDniPlatnosci, satysfakcjaKlienta, Klient.nazwa,
TypUmowy.nazwa, TypUmowy.dlugoscGwarancji, RodzajObiektu.nazwa, 
TypEwidencjiSprzedazy.nazwa, TypProjektu.nazwa, RodzajUslugi.nazwa, Miesiac.wartosc, Miasto.nazwa,
TypPlatnosci.nazwa 
FROM UslugaFCT, TypUmowy, RodzajObiektu, TypEwidencjiSprzedazy, TypProjektu, RodzajUslugi, Miesiac, Miasto, TypPlatnosci, Klient
WHERE Klient.idKlienta = UslugaFCT.idKlienta_FK AND TypUmowy.idTypuUmowy = UslugaFCT.idTypuUmowy_FK AND RodzajObiektu.idRodzajuObiektu = UslugaFCT.idRodzajuObiektu_FK
AND TypEwidencjiSprzedazy.idTypuEwidencji = UslugaFCT.idTypuEwidencji_FK AND TypProjektu.idTypuProjektu = UslugaFCT.idTypuProjektu_FK AND RodzajUslugi.idRodzajuUslugi = UslugaFCT.idRodzajuUslugi_FK
AND Miesiac.idMiesiaca = UslugaFCT.idDaty_FK AND Miasto.idMiasta = UslugaFCT.idMiasta_FK AND TypPlatnosci.idTypuPlatnosci = UslugaFCT.idTypuPlatnosci_FK;

db.getCollection("Usluga").aggregate(
    [
        { 
            "$project" : {
                "_id" : NumberInt(0), 
                "Usluga" : "$$ROOT"
            }
        }, 
        { 
            "$lookup" : {
                "localField" : "Usluga.klient", 
                "from" : "Klient", 
                "foreignField" : "_id", 
                "as" : "Klient"
            }
        }, 
        { 
            "$unwind" : {
                "path" : "$Klient", 
                "preserveNullAndEmptyArrays" : false
            }
        }, 
        { 
            "$lookup" : {
                "localField" : "Usluga.obiekt", 
                "from" : "Obiekt", 
                "foreignField" : "_id", 
                "as" : "Obiekt"
            }
        }, 
        { 
            "$unwind" : {
                "path" : "$Obiekt", 
                "preserveNullAndEmptyArrays" : false
            }
        }, 
        { 
            "$lookup" : {
                "localField" : "Usluga.rodzajUslugi", 
                "from" : "RodzajUslugi", 
                "foreignField" : "_id", 
                "as" : "RodzajUslugi"
            }
        }, 
        { 
            "$unwind" : {
                "path" : "$RodzajUslugi", 
                "preserveNullAndEmptyArrays" : false
            }
        }, 
        { 
            "$lookup" : {
                "localField" : "Usluga.czas", 
                "from" : "Czas", 
                "foreignField" : "_id", 
                "as" : "Czas"
            }
        }, 
        { 
            "$unwind" : {
                "path" : "$Czas", 
                "preserveNullAndEmptyArrays" : false
            }
        }, 
        { 
            "$lookup" : {
                "localField" : "Usluga.lokalizacja", 
                "from" : "Lokalizacja", 
                "foreignField" : "_id", 
                "as" : "Lokalizacja"
            }
        }, 
        { 
            "$unwind" : {
                "path" : "$Lokalizacja", 
                "preserveNullAndEmptyArrays" : false
            }
        }, 
        { 
            "$project" : {
                "Usluga._id" : "$Usluga._id", 
                "Usluga.cenaNetto" : "$Usluga.cenaNetto", 
                "Usluga.stawkaVAT" : "$Usluga.stawkaVAT", 
                "Usluga.kwotaVAT" : "$Usluga.kwotaVAT", 
                "Usluga.cenaBrutto" : "$Usluga.cenaBrutto", 
                "Usluga.stawkaPPE" : "$Usluga.stawkaPPE", 
                "Usluga.kwotaPPE" : "$Usluga.kwotaPPE", 
                "Usluga.iloscDniPlatnosci" : "$Usluga.iloscDniPlatnosci", 
                "Usluga.satysfakcjaKlienta" : "$Usluga.satysfakcjaKlienta", 
                "Klient.nazwa" : "$Klient.nazwa", 
                "Usluga.TypUmowy.nazwa" : "$Usluga.TypUmowy.nazwa", 
                "Usluga.TypUmowy.dlugoscGwarancji" : "$Usluga.TypUmowy.dlugoscGwarancji", 
                "Obiekt.nazwa" : "$Obiekt.nazwa", 
                "Usluga.TypEwidencjiSprzedazy.nazwa" : "$Usluga.TypEwidencjiSprzedazy.nazwa", 
                "Usluga.TypProjektu.nazwa" : "$Usluga.TypProjektu.nazwa", 
                "RodzajUslugi.nazwa" : "$RodzajUslugi.nazwa", 
                "Czas.miesiac" : "$Czas.miesiac", 
                "Lokalizacja.miasto" : "$Lokalizacja.miasto", 
                "Usluga.TypPlatnosci.nazwa" : "$Usluga.TypPlatnosci.nazwa", 
                "_id" : NumberInt(0)
            }
        }
    ], 
    { 
        "allowDiskUse" : true
    }
);
(25.191s)

//####################################################################

SELECT * FROM UslugaFCT;

db.getCollection("Usluga").find({}).explain("executionStats") 
(11ms)

//####################################################################

SELECT Klient.nazwa, RodzajUslugi.nazwa, Rok.wartosc, SUM(cenaNetto), SUM(cenaBrutto)
FROM Klient, RodzajUslugi, Rok, UslugaFCT
WHERE Klient.idKlienta = UslugaFCT.idKlienta_FK AND RodzajUslugi.idRodzajuUslugi = UslugaFCT.idRodzajuUslugi_FK
GROUP BY Klient.nazwa, RodzajUslugi.nazwa, Rok.wartosc
ORDER BY SUM(cenaNetto), SUM(cenaBrutto);

db.getCollection("Usluga").aggregate(
    [
        { 
            "$project" : {
                "_id" : NumberInt(0), 
                "Usluga" : "$$ROOT"
            }
        }, 
        { 
            "$lookup" : {
                "localField" : "Usluga.klient", 
                "from" : "Klient", 
                "foreignField" : "_id", 
                "as" : "Klient"
            }
        }, 
        { 
            "$unwind" : {
                "path" : "$Klient", 
                "preserveNullAndEmptyArrays" : false
            }
        }, 
        { 
            "$lookup" : {
                "localField" : "Usluga.rodzajUslugi", 
                "from" : "RodzajUslugi", 
                "foreignField" : "_id", 
                "as" : "RodzajUslugi"
            }
        }, 
        { 
            "$unwind" : {
                "path" : "$RodzajUslugi", 
                "preserveNullAndEmptyArrays" : false
            }
        }, 
        { 
            "$lookup" : {
                "localField" : "Usluga.czas", 
                "from" : "Czas", 
                "foreignField" : "_id", 
                "as" : "Czas"
            }
        }, 
        { 
            "$unwind" : {
                "path" : "$Czas", 
                "preserveNullAndEmptyArrays" : false
            }
        }, 
        { 
            "$group" : {
                "_id" : {
                    "Klient᎐nazwa" : "$Klient.nazwa", 
                    "RodzajUslugi᎐nazwa" : "$RodzajUslugi.nazwa", 
                    "Czas᎐rok" : "$Czas.rok"
                }, 
                "SUM(Usluga᎐cenaNetto)" : {
                    "$sum" : "$Usluga.cenaNetto"
                }, 
                "SUM(Usluga᎐cenaBrutto)" : {
                    "$sum" : "$Usluga.cenaBrutto"
                }
            }
        }, 
        { 
            "$project" : {
                "Klient.nazwa" : "$_id.Klient᎐nazwa", 
                "RodzajUslugi.nazwa" : "$_id.RodzajUslugi᎐nazwa", 
                "Czas.rok" : "$_id.Czas᎐rok", 
                "SUM(Usluga.cenaNetto)" : "$SUM(Usluga᎐cenaNetto)", 
                "SUM(Usluga.cenaBrutto)" : "$SUM(Usluga᎐cenaBrutto)", 
                "_id" : NumberInt(0)
            }
        }, 
        { 
            "$sort" : {
                "SUM(Usluga.cenaNetto)" : NumberInt(1), 
                "SUM(Usluga.cenaBrutto)" : NumberInt(1)
            }
        }, 
        { 
            "$project" : {
                "_id" : NumberInt(0), 
                "Klient.nazwa" : "$Klient.nazwa", 
                "RodzajUslugi.nazwa" : "$RodzajUslugi.nazwa", 
                "Czas.rok" : "$Czas.rok", 
                "SUM(Usluga᎐cenaNetto)" : "$SUM(Usluga.cenaNetto)", 
                "SUM(Usluga᎐cenaBrutto)" : "$SUM(Usluga.cenaBrutto)"
            }
        }
    ], 
    { 
        "allowDiskUse" : true
    }
);
(13.811s)

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
            "$project" : {
                "_id" : NumberInt(0), 
                "Usluga" : "$$ROOT"
            }
        }, 
        { 
            "$lookup" : {
                "localField" : "Usluga.klient", 
                "from" : "Klient", 
                "foreignField" : "_id", 
                "as" : "Klient"
            }
        }, 
        { 
            "$unwind" : {
                "path" : "$Klient", 
                "preserveNullAndEmptyArrays" : false
            }
        }, 
        { 
            "$lookup" : {
                "localField" : "Usluga.lokalizacja", 
                "from" : "Lokalizacja", 
                "foreignField" : "_id", 
                "as" : "Lokalizacja"
            }
        }, 
        { 
            "$unwind" : {
                "path" : "$Lokalizacja", 
                "preserveNullAndEmptyArrays" : false
            }
        }, 
        { 
            "$group" : {
                "_id" : {
                    "Lokalizacja᎐miasto" : "$Lokalizacja.miasto", 
                    "Klient᎐nazwa" : "$Klient.nazwa", 
                    "Usluga᎐TypUmowy᎐nazwa" : "$Usluga.TypUmowy.nazwa"
                }, 
                "SUM(Usluga᎐cenaBrutto)" : {
                    "$sum" : "$Usluga.cenaBrutto"
                }, 
                "SUM(Usluga᎐cenaNetto)" : {
                    "$sum" : "$Usluga.cenaNetto"
                }, 
                "AVG(Usluga᎐kwotaPPE)" : {
                    "$avg" : "$Usluga.kwotaPPE"
                }, 
                "COUNT(Usluga᎐_id)" : {
                    "$sum" : NumberInt(1)
                }
            }
        }, 
        { 
            "$project" : {
                "Klient.nazwa" : "$_id.Klient᎐nazwa", 
                "Usluga.TypUmowy.nazwa" : "$_id.Usluga᎐TypUmowy᎐nazwa", 
                "Lokalizacja.miasto" : "$_id.Lokalizacja᎐miasto", 
                "SUM(Usluga.cenaBrutto)" : "$SUM(Usluga᎐cenaBrutto)", 
                "SUM(Usluga.cenaNetto)" : "$SUM(Usluga᎐cenaNetto)", 
                "AVG(Usluga.kwotaPPE)" : "$AVG(Usluga᎐kwotaPPE)", 
                "COUNT(Usluga._id)" : "$COUNT(Usluga᎐_id)", 
                "_id" : NumberInt(0)
            }
        }, 
        { 
            "$match" : {
                "COUNT(Usluga._id)" : {
                    "$gt" : NumberLong(10)
                }
            }
        }, 
        { 
            "$sort" : {
                "Klient.nazwa" : NumberInt(1)
            }
        }, 
        { 
            "$project" : {
                "_id" : NumberInt(0), 
                "Klient.nazwa" : "$Klient.nazwa", 
                "Usluga.TypUmowy.nazwa" : "$Usluga.TypUmowy.nazwa", 
                "Lokalizacja.miasto" : "$Lokalizacja.miasto", 
                "SUM(Usluga᎐cenaBrutto)" : "$SUM(Usluga.cenaBrutto)", 
                "SUM(Usluga᎐cenaNetto)" : "$SUM(Usluga.cenaNetto)", 
                "AVG(Usluga᎐kwotaPPE)" : "$AVG(Usluga.kwotaPPE)", 
                "COUNT(Usluga᎐_id)" : "$COUNT(Usluga._id)"
            }
        }
    ], 
    { 
        "allowDiskUse" : true
    }
);
(9.658s)

//####################################################################
//####################################################################
//####################################################################

USE FIRMA_BUDOWLANA

SELECT * FROM ZakupFCT;

db.getCollection("Zakup").find({});
(0.450s)

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

db.getCollection("Zakup").aggregate(
    [
        { 
            "$project" : {
                "_id" : NumberInt(0), 
                "Zakup" : "$$ROOT"
            }
        }, 
        { 
            "$lookup" : {
                "localField" : "Zakup.sprzedawca", 
                "from" : "Sprzedawca", 
                "foreignField" : "_id", 
                "as" : "Sprzedawca"
            }
        }, 
        { 
            "$unwind" : {
                "path" : "$Sprzedawca", 
                "preserveNullAndEmptyArrays" : false
            }
        }, 
        { 
            "$lookup" : {
                "localField" : "Zakup.lokalizacja", 
                "from" : "Lokalizacja", 
                "foreignField" : "_id", 
                "as" : "Lokalizacja"
            }
        }, 
        { 
            "$unwind" : {
                "path" : "$Lokalizacja", 
                "preserveNullAndEmptyArrays" : false
            }
        }, 
        { 
            "$lookup" : {
                "localField" : "Zakup.czas", 
                "from" : "Czas", 
                "foreignField" : "_id", 
                "as" : "Czas"
            }
        }, 
        { 
            "$unwind" : {
                "path" : "$Czas", 
                "preserveNullAndEmptyArrays" : false
            }
        }, 
        { 
            "$lookup" : {
                "localField" : "Zakup.typTowaru", 
                "from" : "TypTowaru", 
                "foreignField" : "_id", 
                "as" : "TypTowaru"
            }
        }, 
        { 
            "$unwind" : {
                "path" : "$TypTowaru", 
                "preserveNullAndEmptyArrays" : false
            }
        }, 
        { 
            "$sort" : {
                "Zakup._id" : NumberInt(1)
            }
        }, 
        { 
            "$project" : {
                "Zakup._id" : "$Zakup._id", 
                "Zakup.cenaBrutto" : "$Zakup.cenaBrutto", 
                "Zakup.stawkaVAT" : "$Zakup.stawkaVAT", 
                "Zakup.kwotaVAT" : "$Zakup.kwotaVAT", 
                "Sprzedawca.nazwa" : "$Sprzedawca.nazwa", 
                "Lokalizacja.miasto" : "$Lokalizacja.miasto", 
                "Czas.miesiac" : "$Czas.miesiac", 
                "Czas.rok" : "$Czas.rok", 
                "Zakup.TypPlatnosci.nazwa" : "$Zakup.TypPlatnosci.nazwa", 
                "Zakup.TypEwidencjiZakupu.nazwa" : "$Zakup.TypEwidencjiZakupu.nazwa", 
                "TypTowaru.nazwa" : "$TypTowaru.nazwa", 
                "_id" : NumberInt(0)
            }
        }
    ], 
    { 
        "allowDiskUse" : true
    }
);
(19.702s)

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
            "$project" : {
                "_id" : NumberInt(0), 
                "Zakup" : "$$ROOT"
            }
        }, 
        { 
            "$lookup" : {
                "localField" : "Zakup.sprzedawca", 
                "from" : "Sprzedawca", 
                "foreignField" : "_id", 
                "as" : "Sprzedawca"
            }
        }, 
        { 
            "$unwind" : {
                "path" : "$Sprzedawca", 
                "preserveNullAndEmptyArrays" : false
            }
        }, 
        { 
            "$lookup" : {
                "localField" : "Zakup.typTowaru", 
                "from" : "TypTowaru", 
                "foreignField" : "_id", 
                "as" : "TypTowaru"
            }
        }, 
        { 
            "$unwind" : {
                "path" : "$TypTowaru", 
                "preserveNullAndEmptyArrays" : false
            }
        }, 
        { 
            "$lookup" : {
                "localField" : "Zakup.czas", 
                "from" : "Czas", 
                "foreignField" : "_id", 
                "as" : "Czas"
            }
        }, 
        { 
            "$unwind" : {
                "path" : "$Czas", 
                "preserveNullAndEmptyArrays" : false
            }
        }, 
        { 
            "$group" : {
                "_id" : {
                    "TypTowaru᎐nazwa" : "$TypTowaru.nazwa", 
                    "Sprzedawca᎐nazwa" : "$Sprzedawca.nazwa", 
                    "Czas᎐rok" : "$Czas.rok"
                }, 
                "SUM(Zakup᎐cenaNetto)" : {
                    "$sum" : "$Zakup.cenaNetto"
                }, 
                "SUM(Zakup᎐kwotaVAT)" : {
                    "$sum" : "$Zakup.kwotaVAT"
                }, 
                "SUM(Zakup᎐cenaBrutto)" : {
                    "$sum" : "$Zakup.cenaBrutto"
                }, 
                "COUNT(Zakup᎐_id)" : {
                    "$sum" : NumberInt(1)
                }
            }
        }, 
        { 
            "$project" : {
                "Sprzedawca.nazwa" : "$_id.Sprzedawca᎐nazwa", 
                "TypTowaru.nazwa" : "$_id.TypTowaru᎐nazwa", 
                "Czas.rok" : "$_id.Czas᎐rok", 
                "SUM(Zakup.cenaNetto)" : "$SUM(Zakup᎐cenaNetto)", 
                "SUM(Zakup.kwotaVAT)" : "$SUM(Zakup᎐kwotaVAT)", 
                "SUM(Zakup.cenaBrutto)" : "$SUM(Zakup᎐cenaBrutto)", 
                "COUNT(Zakup._id)" : "$COUNT(Zakup᎐_id)", 
                "_id" : NumberInt(0)
            }
        }, 
        { 
            "$sort" : {
                "COUNT(Zakup._id)" : NumberInt(1), 
                "SUM(Zakup.cenaNetto)" : NumberInt(1)
            }
        }, 
        { 
            "$project" : {
                "_id" : NumberInt(0), 
                "Sprzedawca.nazwa" : "$Sprzedawca.nazwa", 
                "TypTowaru.nazwa" : "$TypTowaru.nazwa", 
                "Czas.rok" : "$Czas.rok", 
                "SUM(Zakup᎐cenaNetto)" : "$SUM(Zakup.cenaNetto)", 
                "SUM(Zakup᎐kwotaVAT)" : "$SUM(Zakup.kwotaVAT)", 
                "SUM(Zakup᎐cenaBrutto)" : "$SUM(Zakup.cenaBrutto)", 
                "COUNT(Zakup᎐_id)" : "$COUNT(Zakup._id)"
            }
        }
    ], 
    { 
        "allowDiskUse" : true
    }
);
(14.043s)

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
            "$project" : {
                "_id" : NumberInt(0), 
                "Zakup" : "$$ROOT"
            }
        }, 
        { 
            "$lookup" : {
                "localField" : "Zakup.lokalizacja", 
                "from" : "Lokalizacja", 
                "foreignField" : "_id", 
                "as" : "Lokalizacja"
            }
        }, 
        { 
            "$unwind" : {
                "path" : "$Lokalizacja", 
                "preserveNullAndEmptyArrays" : false
            }
        }, 
        { 
            "$lookup" : {
                "localField" : "Zakup.typTowaru", 
                "from" : "TypTowaru", 
                "foreignField" : "_id", 
                "as" : "TypTowaru"
            }
        }, 
        { 
            "$unwind" : {
                "path" : "$TypTowaru", 
                "preserveNullAndEmptyArrays" : false
            }
        }, 
        { 
            "$lookup" : {
                "localField" : "Zakup.czas", 
                "from" : "Czas", 
                "foreignField" : "_id", 
                "as" : "Czas"
            }
        }, 
        { 
            "$unwind" : {
                "path" : "$Czas", 
                "preserveNullAndEmptyArrays" : false
            }
        }, 
        { 
            "$group" : {
                "_id" : {
                    "Czas᎐kwartal" : "$Czas.kwartal", 
                    "Lokalizacja᎐miasto" : "$Lokalizacja.miasto", 
                    "Lokalizacja᎐region" : "$Lokalizacja.region", 
                    "TypTowaru᎐nazwa" : "$TypTowaru.nazwa", 
                    "Zakup᎐TypEwidencjiZakupu᎐nazwa" : "$Zakup.TypEwidencjiZakupu.nazwa", 
                    "Czas᎐rok" : "$Czas.rok"
                }, 
                "COUNT(Zakup᎐_id)" : {
                    "$sum" : NumberInt(1)
                }, 
                "AVG(Zakup᎐cenaNetto)" : {
                    "$avg" : "$Zakup.cenaNetto"
                }, 
                "AVG(Zakup᎐cenaBrutto)" : {
                    "$avg" : "$Zakup.cenaBrutto"
                }, 
                "SUM(Zakup᎐kwotaVAT)" : {
                    "$sum" : "$Zakup.kwotaVAT"
                }
            }
        }, 
        { 
            "$project" : {
                "Lokalizacja.miasto" : "$_id.Lokalizacja᎐miasto", 
                "Lokalizacja.region" : "$_id.Lokalizacja᎐region", 
                "Zakup.TypEwidencjiZakupu.nazwa" : "$_id.Zakup᎐TypEwidencjiZakupu᎐nazwa", 
                "TypTowaru.nazwa" : "$_id.TypTowaru᎐nazwa", 
                "Czas.kwartal" : "$_id.Czas᎐kwartal", 
                "Czas.rok" : "$_id.Czas᎐rok", 
                "COUNT(Zakup._id)" : "$COUNT(Zakup᎐_id)", 
                "AVG(Zakup.cenaNetto)" : "$AVG(Zakup᎐cenaNetto)", 
                "AVG(Zakup.cenaBrutto)" : "$AVG(Zakup᎐cenaBrutto)", 
                "SUM(Zakup.kwotaVAT)" : "$SUM(Zakup᎐kwotaVAT)", 
                "_id" : NumberInt(0)
            }
        }, 
        { 
            "$match" : {
                "COUNT(Zakup._id)" : {
                    "$gt" : NumberLong(10)
                }
            }
        }, 
        { 
            "$sort" : {
                "Czas.rok" : NumberInt(1), 
                "Czas.kwartal" : NumberInt(1), 
                "Lokalizacja.miasto" : NumberInt(1), 
                "Lokalizacja.region" : NumberInt(1)
            }
        }, 
        { 
            "$project" : {
                "_id" : NumberInt(0), 
                "Lokalizacja.miasto" : "$Lokalizacja.miasto", 
                "Lokalizacja.region" : "$Lokalizacja.region", 
                "Zakup.TypEwidencjiZakupu.nazwa" : "$Zakup.TypEwidencjiZakupu.nazwa", 
                "TypTowaru.nazwa" : "$TypTowaru.nazwa", 
                "Czas.kwartal" : "$Czas.kwartal", 
                "Czas.rok" : "$Czas.rok", 
                "COUNT(Zakup᎐_id)" : "$COUNT(Zakup._id)", 
                "AVG(Zakup᎐cenaNetto)" : "$AVG(Zakup.cenaNetto)", 
                "AVG(Zakup᎐cenaBrutto)" : "$AVG(Zakup.cenaBrutto)", 
                "SUM(Zakup᎐kwotaVAT)" : "$SUM(Zakup.kwotaVAT)"
            }
        }
    ], 
    { 
        "allowDiskUse" : true
    }
);
(13.603s)
