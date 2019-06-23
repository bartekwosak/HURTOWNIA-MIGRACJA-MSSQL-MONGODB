# HURTOWNIA-MIGRACJA-MSSQL-MONGODB
Projekt zakłada:

Przeniesienie hurtowni danych zaprojektowanej w Microsoft SQL Server 2017 do bazy NoSQLowej zorientowanej na dokumenty MongoDB, w tym:

* Importowanie danych z plików CSV do MSSQL za pomocą SSIS
* Exportowanie danych przechowywanych w RDBMS za pomocą specjalnych zapytań tworzących pliki JSON do bazy MongoDB
* Stworzenie 3 baz danych MongoDB celem zbadania wpływu struktury dokumentów i pseudo-relacji pomiędzy nimi na szybkość wykonywania zapytań:
** Struktura odwzorowująca budowę hurtowni w bazie relacyjnej na skład dokumentów MongoDB (za pomocą ręcznych referencji lub DBRef)
** Struktura zmniejszająca ilość agregatów o 50% względem RDBMS (za pomocą ręcznych referencji lub DBRef)
** Stworzenie dwóch głównych dokumentów reprezentujących zawartość dwóch tabel faktów z RDBMS (duża redundancja danych)
* Stworzenie zapytań do zbadania szybkości wykonywania po stronie RDMBS oraz MongoDB
* Podsumowanie wyników w postaci raportu stworzonego w środowisku PowerBI
* Obliczenie powtarzalności danych pomiędzy RDBMS (przyjęte za ideał) a poszczególnymi strukturami MongoDB

Wykorzystane technologie/narzędzia:
* MongoDB
* Microsoft SQL Server 2017 Developer
* SQL Server Integration Services (SSIS)
* Studio3T
* MongoDB Compass
* SQL Server Management System (SSMS)
* T-SQL
* Mongo query
* Mongoimport
