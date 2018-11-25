-- Created by Vertabelo (http://vertabelo.com)
-- Last modification date: 2018-11-17 18:50:54.834
CREATE DATABASE IF NOT EXISTS sklep_rowerowy;
USE sklep_rowerowy;

CREATE USER 'sklep'@'localhost' IDENTIFIED BY 'sklep';
GRANT ALL PRIVILEGES ON sklep_rowerowy. * TO 'sklep'@'localhost';
ALTER USER 'sklep'@'localhost' IDENTIFIED WITH mysql_native_password BY 'sklep';

-- tables
-- Table: Blad
CREATE TABLE Blad (
    id int NOT NULL AUTO_INCREMENT,
    timestamp time NOT NULL,
    IP int NOT NULL,
    CONSTRAINT Blad_pk PRIMARY KEY (id)
);

-- Table: Kategoria
CREATE TABLE Kategoria (
    id int NOT NULL AUTO_INCREMENT,
    Nazwa_kategorii varchar(40) NOT NULL,
    CONSTRAINT Kategoria_pk PRIMARY KEY (id)
);


-- Table: Klient
CREATE TABLE Klient (
    id int NOT NULL AUTO_INCREMENT,
    Imie varchar(40) NOT NULL,
    Nazwisko varchar(40) NOT NULL,
    login varchar(40) NOT NULL,
    haslo varchar(100) NOT NULL,
    email varchar(40) NOT NULL,
    CONSTRAINT Klient_pk PRIMARY KEY (id)
);

-- Table: Lokalizacja_sklepu
CREATE TABLE Lokalizacja_sklepu (
    id int NOT NULL AUTO_INCREMENT,
    kod_pocztowy int NOT NULL,
    telefon int NOT NULL,
    adres varchar(100) NOT NULL,
    Miasto_id int NOT NULL,
    CONSTRAINT Lokalizacja_sklepu_pk PRIMARY KEY (id)
);

-- Table: Marka
CREATE TABLE Marka (
    id int NOT NULL AUTO_INCREMENT,
    Nazwa_marki varchar(40) NOT NULL,
    CONSTRAINT Marka_pk PRIMARY KEY (id)
);

-- Table: Miasto
CREATE TABLE Miasto (
    id int NOT NULL AUTO_INCREMENT,
    Nazwa varchar(40) NOT NULL,
    CONSTRAINT Miasto_pk PRIMARY KEY (id)
);

-- Table: Pracownik
CREATE TABLE Pracownik (
    id int NOT NULL AUTO_INCREMENT,
    Stanowisko varchar(40) NOT NULL,
    Lokalizacja_sklepu_id int NOT NULL,
    Imie varchar(40) NOT NULL,
    Nazwisko varchar(40) NOT NULL,
    CONSTRAINT Pracownik_pk PRIMARY KEY (id)
);

-- Table: Produkt
CREATE TABLE Produkt (
    Nazwa_produktu varchar(40) DEFAULT NULL,
    id int NOT NULL AUTO_INCREMENT,
    Kategoria_id int NOT NULL,
    Rower_id int DEFAULT NULL,
    Cena decimal(5,2) NOT NULL,
    CONSTRAINT Produkt_pk PRIMARY KEY (id)
);

-- Table: Rodzaj_roweru
CREATE TABLE Rodzaj_roweru (
    id int NOT NULL AUTO_INCREMENT,
    Rodzaj varchar(40) NOT NULL,
    CONSTRAINT Rodzaj_roweru_pk PRIMARY KEY (id)
);

-- Table: Rower
CREATE TABLE Rower (
    id int NOT NULL AUTO_INCREMENT,
    Nazwa_roweru varchar(40) NOT NULL,
    Srednica_kola int NOT NULL,
    Nazwa_modelu varchar(40) NOT NULL,
    Rodzaj_roweru_id int NOT NULL,
    Marka_id int NOT NULL,
    CONSTRAINT Rower_pk PRIMARY KEY (id)
);

-- Table: Stan_magazynowy
CREATE TABLE Stan_magazynowy (
    id int NOT NULL AUTO_INCREMENT,
    Stan int NOT NULL,
    Produkt_id int NOT NULL,
    Lokalizacja_sklepu_id int NOT NULL,
    CONSTRAINT Stan_magazynowy_pk PRIMARY KEY (id)
);

-- Table: Zamowienie
CREATE TABLE Zamowienie (
    id int NOT NULL AUTO_INCREMENT,
    Lokalizacja_sklepu_id int NOT NULL,
    Klient_id int NOT NULL,
    CONSTRAINT Zamowienie_pk PRIMARY KEY (id)
);

-- Table: Zamowienie_pozycja
CREATE TABLE Zamowienie_pozycja (
    id int NOT NULL AUTO_INCREMENT,
    Produkt_id int NOT NULL,
    Zamowienie_id int NOT NULL,
    CONSTRAINT Zamowienie_pozycja_pk PRIMARY KEY (id)
);

CREATE TABLE Koszyk (
    id int NOT NULL AUTO_INCREMENT,
    Klient_id int NOT NULL,
    CONSTRAINT Koszyk_pk PRIMARY KEY (id)
);

CREATE TABLE Koszyk_pozycja (
    id int NOT NULL AUTO_INCREMENT,
    Produkt_id int NOT NULL,
    Koszyk_id int NOT NULL,
    CONSTRAINT Koszyk_pozycja_pk PRIMARY KEY (id)
);


-- foreign keys


-- Reference: Koszyk_pozycja_Produkt (table: Koszyk_pozycja)
ALTER TABLE Koszyk_pozycja ADD CONSTRAINT Koszyk_pozycja_Produkt FOREIGN KEY Koszyk_pozycja_Produkt (Produkt_id)
    REFERENCES Produkt (id);

-- Reference: Koszyk_pozycja_Zamowienie (table: Koszyk_pozycja)
ALTER TABLE Koszyk_pozycja ADD CONSTRAINT Koszyk_pozycja_Zamowienie FOREIGN KEY Koszyk_pozycja_Zamowienie (Koszyk_id)
    REFERENCES Koszyk (id);

-- Reference: Koszyk_Klient (table: Koszyk_)
ALTER TABLE Koszyk ADD CONSTRAINT Koszyk_Klient FOREIGN KEY Koszyk_Klient (Klient_id)
    REFERENCES Klient (id);

-- Reference: Lokalizacja_sklepu_Miasto (table: Lokalizacja_sklepu)
ALTER TABLE Lokalizacja_sklepu ADD CONSTRAINT Lokalizacja_sklepu_Miasto FOREIGN KEY Lokalizacja_sklepu_Miasto (Miasto_id)
    REFERENCES Miasto (id);

-- Reference: Pracownik_Lokalizacja_sklepu (table: Pracownik)
ALTER TABLE Pracownik ADD CONSTRAINT Pracownik_Lokalizacja_sklepu FOREIGN KEY Pracownik_Lokalizacja_sklepu (Lokalizacja_sklepu_id)
    REFERENCES Lokalizacja_sklepu (id);

-- Reference: Produkt_Kategoria (table: Produkt)
ALTER TABLE Produkt ADD CONSTRAINT Produkt_Kategoria FOREIGN KEY Produkt_Kategoria (Kategoria_id)
    REFERENCES Kategoria (id);

-- Reference: Produkt_Rower (table: Produkt)
ALTER TABLE Produkt ADD CONSTRAINT Produkt_Rower FOREIGN KEY Produkt_Rower (Rower_id)
    REFERENCES Rower (id);

-- Reference: Rower_Marka (table: Rower)
ALTER TABLE Rower ADD CONSTRAINT Rower_Marka FOREIGN KEY Rower_Marka (Marka_id)
    REFERENCES Marka (id);

-- Reference: Rower_Rodzaj_roweru (table: Rower)
ALTER TABLE Rower ADD CONSTRAINT Rower_Rodzaj_roweru FOREIGN KEY Rower_Rodzaj_roweru (Rodzaj_roweru_id)
    REFERENCES Rodzaj_roweru (id);

-- Reference: Stan_magazynowy_Lokalizacja_sklepu (table: Stan_magazynowy)
ALTER TABLE Stan_magazynowy ADD CONSTRAINT Stan_magazynowy_Lokalizacja_sklepu FOREIGN KEY Stan_magazynowy_Lokalizacja_sklepu (Lokalizacja_sklepu_id)
    REFERENCES Lokalizacja_sklepu (id);

-- Reference: Stan_magazynowy_Produkt (table: Stan_magazynowy)
ALTER TABLE Stan_magazynowy ADD CONSTRAINT Stan_magazynowy_Produkt FOREIGN KEY Stan_magazynowy_Produkt (Produkt_id)
    REFERENCES Produkt (id);

-- Reference: Zamowienie_Klient (table: Zamowienie)
ALTER TABLE Zamowienie ADD CONSTRAINT Zamowienie_Klient FOREIGN KEY Zamowienie_Klient (Klient_id)
    REFERENCES Klient (id);

-- Reference: Zamowienie_Lokalizacja_sklepu (table: Zamowienie)
ALTER TABLE Zamowienie ADD CONSTRAINT Zamowienie_Lokalizacja_sklepu FOREIGN KEY Zamowienie_Lokalizacja_sklepu (Lokalizacja_sklepu_id)
    REFERENCES Lokalizacja_sklepu (id);

-- Reference: Zamowienie_pozycja_Produkt (table: Zamowienie_pozycja)
ALTER TABLE Zamowienie_pozycja ADD CONSTRAINT Zamowienie_pozycja_Produkt FOREIGN KEY Zamowienie_pozycja_Produkt (Produkt_id)
    REFERENCES Produkt (id);

-- Reference: Zamowienie_pozycja_Zamowienie (table: Zamowienie_pozycja)
ALTER TABLE Zamowienie_pozycja ADD CONSTRAINT Zamowienie_pozycja_Zamowienie FOREIGN KEY Zamowienie_pozycja_Zamowienie (Zamowienie_id)
    REFERENCES Zamowienie (id);
    
    
-- Przykładowe rekordy

-- Kategoria
INSERT INTO Kategoria (Nazwa_kategorii) VALUES ('Rower');
INSERT INTO Kategoria (Nazwa_kategorii) VALUES ('Rama');
INSERT INTO Kategoria (Nazwa_kategorii) VALUES ('Kierownica');
INSERT INTO Kategoria (Nazwa_kategorii) VALUES ('Siodełko');
INSERT INTO Kategoria (Nazwa_kategorii) VALUES ('Koło');
INSERT INTO Kategoria (Nazwa_kategorii) VALUES ('Opona');

-- Marka
INSERT INTO Marka (Nazwa_marki) VALUES ('Kettler');
INSERT INTO Marka (Nazwa_marki) VALUES ('Pin Up');
INSERT INTO Marka (Nazwa_marki) VALUES ('Le Grand');
INSERT INTO Marka (Nazwa_marki) VALUES ('Burghardt');
INSERT INTO Marka (Nazwa_marki) VALUES ('Unity');
INSERT INTO Marka (Nazwa_marki) VALUES ('Accent');
INSERT INTO Marka (Nazwa_marki) VALUES ('Continental');
INSERT INTO Marka (Nazwa_marki) VALUES ('Kenda');
INSERT INTO Marka (Nazwa_marki) VALUES ('Mitas');
INSERT INTO Marka (Nazwa_marki) VALUES ('Fulcrum');

-- Miasto
INSERT INTO Miasto (Nazwa) VALUES ('Warszawa');
INSERT INTO Miasto (Nazwa) VALUES ('Kraków');
INSERT INTO Miasto (Nazwa) VALUES ('Toruń');
INSERT INTO Miasto (Nazwa) VALUES ('Gdańsk');
INSERT INTO Miasto (Nazwa) VALUES ('Wrocław');

-- Rodzaj_roweru
INSERT INTO Rodzaj_roweru (Rodzaj) VALUES ('Miejski');
INSERT INTO Rodzaj_roweru (Rodzaj) VALUES ('Cruiser');
INSERT INTO Rodzaj_roweru (Rodzaj) VALUES ('Szosowy');
INSERT INTO Rodzaj_roweru (Rodzaj) VALUES ('Górski');
INSERT INTO Rodzaj_roweru (Rodzaj) VALUES ('Elektryczny');

-- Rower
INSERT INTO Rower (Nazwa_roweru, Srednica_kola, Nazwa_modelu, Rodzaj_roweru_id, Marka_id)
	SELECT CONCAT(m.Nazwa_marki, ' ', 'Lola Evo'), 26, 'Lola Evo',  r.id, m.id
	FROM Rodzaj_roweru AS r
	CROSS JOIN Marka AS m
	WHERE r.Rodzaj = 'Miejski'
	AND m.Nazwa_marki = 'Pin Up';
	
INSERT INTO Rower (Nazwa_roweru, Srednica_kola, Nazwa_modelu, Rodzaj_roweru_id, Marka_id)
	SELECT CONCAT(m.Nazwa_marki, ' ', 'Traveller 4'), 25, 'Traveller 4',  r.id, m.id
	FROM Rodzaj_roweru AS r
	CROSS JOIN Marka AS m
	WHERE r.Rodzaj = 'Cruiser'
	AND m.Nazwa_marki = 'Kettler';
    
INSERT INTO Rower (Nazwa_roweru, Srednica_kola, Nazwa_modelu, Rodzaj_roweru_id, Marka_id)
	SELECT CONCAT(m.Nazwa_marki, ' ', 'City Cruiser Comfort'), 24, 'City Cruiser Comfort',  r.id, m.id
	FROM Rodzaj_roweru AS r
	CROSS JOIN Marka AS m
	WHERE r.Rodzaj = 'Cruiser'
	AND m.Nazwa_marki = 'Kettler';
    
INSERT INTO Rower (Nazwa_roweru, Srednica_kola, Nazwa_modelu, Rodzaj_roweru_id, Marka_id)
	SELECT CONCAT(m.Nazwa_marki, ' ', 'Glider'), 26, 'Glider',  r.id, m.id
	FROM Rodzaj_roweru AS r
	CROSS JOIN Marka AS m
	WHERE r.Rodzaj = 'Elektryczny'
	AND m.Nazwa_marki = 'Kettler';
    
INSERT INTO Rower (Nazwa_roweru, Srednica_kola, Nazwa_modelu, Rodzaj_roweru_id, Marka_id)
	SELECT CONCAT(m.Nazwa_marki, ' ', 'Monster'), 27, 'Monster',  r.id, m.id
	FROM Rodzaj_roweru AS r
	CROSS JOIN Marka AS m
	WHERE r.Rodzaj = 'Górski'
	AND m.Nazwa_marki = 'Accent';
    
INSERT INTO Rower (Nazwa_roweru, Srednica_kola, Nazwa_modelu, Rodzaj_roweru_id, Marka_id)
	SELECT CONCAT(m.Nazwa_marki, ' ', 'Shark'), 26, 'Shark',  r.id, m.id
	FROM Rodzaj_roweru AS r
	CROSS JOIN Marka AS m
	WHERE r.Rodzaj = 'Szosowy'
	AND m.Nazwa_marki = 'Accent';
    
INSERT INTO Rower (Nazwa_roweru, Srednica_kola, Nazwa_modelu, Rodzaj_roweru_id, Marka_id)
	SELECT CONCAT(m.Nazwa_marki, ' ', 'Daisy 2'), 25, 'Daisy 2',  r.id, m.id
	FROM Rodzaj_roweru AS r
	CROSS JOIN Marka AS m
	WHERE r.Rodzaj = 'Miejski'
	AND m.Nazwa_marki = 'Accent';
    
INSERT INTO Rower (Nazwa_roweru, Srednica_kola, Nazwa_modelu, Rodzaj_roweru_id, Marka_id)
	SELECT CONCAT(m.Nazwa_marki, ' ', 'Julia'), 25, 'Julia',  r.id, m.id
	FROM Rodzaj_roweru AS r
	CROSS JOIN Marka AS m
	WHERE r.Rodzaj = 'Miejski'
	AND m.Nazwa_marki = 'Kettler';
    
INSERT INTO Rower (Nazwa_roweru, Srednica_kola, Nazwa_modelu, Rodzaj_roweru_id, Marka_id)
	SELECT CONCAT(m.Nazwa_marki, ' ', 'Freeliner'), 26, 'Freeliner',  r.id, m.id
	FROM Rodzaj_roweru AS r
	CROSS JOIN Marka AS m
	WHERE r.Rodzaj = 'Cruiser'
	AND m.Nazwa_marki = 'Accent';
    
INSERT INTO Rower (Nazwa_roweru, Srednica_kola, Nazwa_modelu, Rodzaj_roweru_id, Marka_id)
	SELECT CONCAT(m.Nazwa_marki, ' ', 'Berlin Cargo'), 28, 'Berlin Cargo',  r.id, m.id
	FROM Rodzaj_roweru AS r
	CROSS JOIN Marka AS m
	WHERE r.Rodzaj = 'Cruiser'
	AND m.Nazwa_marki = 'Kettler';
    
INSERT INTO Rower (Nazwa_roweru, Srednica_kola, Nazwa_modelu, Rodzaj_roweru_id, Marka_id)
	SELECT CONCAT(m.Nazwa_marki, ' ', 'Madison'), 25, 'Madison',  r.id, m.id
	FROM Rodzaj_roweru AS r
	CROSS JOIN Marka AS m
	WHERE r.Rodzaj = 'Miejski'
	AND m.Nazwa_marki = 'Le Grand';
    
INSERT INTO Rower (Nazwa_roweru, Srednica_kola, Nazwa_modelu, Rodzaj_roweru_id, Marka_id)
	SELECT CONCAT(m.Nazwa_marki, ' ', 'Sanibel'), 24, 'Sanibel',  r.id, m.id
	FROM Rodzaj_roweru AS r
	CROSS JOIN Marka AS m
	WHERE r.Rodzaj = 'Cruiser'
	AND m.Nazwa_marki = 'Le Grand';
    
INSERT INTO Rower (Nazwa_roweru, Srednica_kola, Nazwa_modelu, Rodzaj_roweru_id, Marka_id)
	SELECT CONCAT(m.Nazwa_marki, ' ', 'William'), 26, 'William',  r.id, m.id
	FROM Rodzaj_roweru AS r
	CROSS JOIN Marka AS m
	WHERE r.Rodzaj = 'Miejski'
	AND m.Nazwa_marki = 'Le Grand';
    
INSERT INTO Rower (Nazwa_roweru, Srednica_kola, Nazwa_modelu, Rodzaj_roweru_id, Marka_id)
	SELECT CONCAT(m.Nazwa_marki, ' ', 'Swan'), 26, 'Swan',  r.id, m.id
	FROM Rodzaj_roweru AS r
	CROSS JOIN Marka AS m
	WHERE r.Rodzaj = 'Miejski'
	AND m.Nazwa_marki = 'Burghardt';
    
INSERT INTO Rower (Nazwa_roweru, Srednica_kola, Nazwa_modelu, Rodzaj_roweru_id, Marka_id)
	SELECT CONCAT(m.Nazwa_marki, ' ', 'Race Star'), 28, 'Race Star',  r.id, m.id
	FROM Rodzaj_roweru AS r
	CROSS JOIN Marka AS m
	WHERE r.Rodzaj = 'Górski'
	AND m.Nazwa_marki = 'Burghardt';
    
INSERT INTO Rower (Nazwa_roweru, Srednica_kola, Nazwa_modelu, Rodzaj_roweru_id, Marka_id)
	SELECT CONCAT(m.Nazwa_marki, ' ', 'Varsovia'), 26, 'Varsovia',  r.id, m.id
	FROM Rodzaj_roweru AS r
	CROSS JOIN Marka AS m
	WHERE r.Rodzaj = 'Elektryczny'
	AND m.Nazwa_marki = 'Unity';
    
INSERT INTO Rower (Nazwa_roweru, Srednica_kola, Nazwa_modelu, Rodzaj_roweru_id, Marka_id)
	SELECT CONCAT(m.Nazwa_marki, ' ', 'Mosca'), 25, 'Mosca',  r.id, m.id
	FROM Rodzaj_roweru AS r
	CROSS JOIN Marka AS m
	WHERE r.Rodzaj = 'Elektryczny'
	AND m.Nazwa_marki = 'Unity';
    
INSERT INTO Rower (Nazwa_roweru, Srednica_kola, Nazwa_modelu, Rodzaj_roweru_id, Marka_id)
	SELECT CONCAT(m.Nazwa_marki, ' ', 'Jasmine Evo'), 26, 'Jasmine Evo',  r.id, m.id
	FROM Rodzaj_roweru AS r
	CROSS JOIN Marka AS m
	WHERE r.Rodzaj = 'Miejski'
	AND m.Nazwa_marki = 'Pin Up';
    
INSERT INTO Rower (Nazwa_roweru, Srednica_kola, Nazwa_modelu, Rodzaj_roweru_id, Marka_id)
	SELECT CONCAT(m.Nazwa_marki, ' ', 'Nadie Evo'), 27, 'Nadie Evo',  r.id, m.id
	FROM Rodzaj_roweru AS r
	CROSS JOIN Marka AS m
	WHERE r.Rodzaj = 'Cruiser'
	AND m.Nazwa_marki = 'Pin Up';
    
INSERT INTO Rower (Nazwa_roweru, Srednica_kola, Nazwa_modelu, Rodzaj_roweru_id, Marka_id)
	SELECT CONCAT(m.Nazwa_marki, ' ', 'Gina Evo'), 28, 'Gina Evo',  r.id, m.id
	FROM Rodzaj_roweru AS r
	CROSS JOIN Marka AS m
	WHERE r.Rodzaj = 'Szosowy'
	AND m.Nazwa_marki = 'Pin Up';
    
INSERT INTO Rower (Nazwa_roweru, Srednica_kola, Nazwa_modelu, Rodzaj_roweru_id, Marka_id)
	SELECT CONCAT(m.Nazwa_marki, ' ', 'Stella Evo'), 26, 'Stella Evo',  r.id, m.id
	FROM Rodzaj_roweru AS r
	CROSS JOIN Marka AS m
	WHERE r.Rodzaj = 'Elektryczny'
	AND m.Nazwa_marki = 'Pin Up';
    
INSERT INTO Rower (Nazwa_roweru, Srednica_kola, Nazwa_modelu, Rodzaj_roweru_id, Marka_id)
	SELECT CONCAT(m.Nazwa_marki, ' ', 'Holy Evo'), 26, 'Holy Evo',  r.id, m.id
	FROM Rodzaj_roweru AS r
	CROSS JOIN Marka AS m
	WHERE r.Rodzaj = 'Miejski'
	AND m.Nazwa_marki = 'Pin Up';


-- Produkt - Rower

INSERT INTO Produkt (Nazwa_produktu, Kategoria_id, Rower_id, Cena)
	SELECT r.Nazwa_roweru, k.id, r.id, 500
	FROM Kategoria AS k
	CROSS JOIN Rower AS r
	WHERE k.Nazwa_kategorii = 'rower'
	AND r.id = 1;
    
INSERT INTO Produkt (Nazwa_produktu, Kategoria_id, Rower_id, Cena)
	SELECT r.Nazwa_roweru, k.id, r.id, 900
	FROM Kategoria AS k
	CROSS JOIN Rower AS r
	WHERE k.Nazwa_kategorii = 'rower'
	AND r.id = 2;
    
INSERT INTO Produkt (Nazwa_produktu, Kategoria_id, Rower_id, Cena)
	SELECT r.Nazwa_roweru, k.id, r.id, 700
	FROM Kategoria AS k
	CROSS JOIN Rower AS r
	WHERE k.Nazwa_kategorii = 'rower'
	AND r.id = 3;
    
INSERT INTO Produkt (Nazwa_produktu, Kategoria_id, Rower_id, Cena)
	SELECT r.Nazwa_roweru, k.id, r.id, 900
	FROM Kategoria AS k
	CROSS JOIN Rower AS r
	WHERE k.Nazwa_kategorii = 'rower'
	AND r.id = 4;
    
INSERT INTO Produkt (Nazwa_produktu, Kategoria_id, Rower_id, Cena)
	SELECT r.Nazwa_roweru, k.id, r.id, 600
	FROM Kategoria AS k
	CROSS JOIN Rower AS r
	WHERE k.Nazwa_kategorii = 'rower'
	AND r.id = 5;
    
INSERT INTO Produkt (Nazwa_produktu, Kategoria_id, Rower_id, Cena)
	SELECT r.Nazwa_roweru, k.id, r.id, 750
	FROM Kategoria AS k
	CROSS JOIN Rower AS r
	WHERE k.Nazwa_kategorii = 'rower'
	AND r.id = 6;
    
INSERT INTO Produkt (Nazwa_produktu, Kategoria_id, Rower_id, Cena)
	SELECT r.Nazwa_roweru, k.id, r.id, 550
	FROM Kategoria AS k
	CROSS JOIN Rower AS r
	WHERE k.Nazwa_kategorii = 'rower'
	AND r.id = 7;
    
INSERT INTO Produkt (Nazwa_produktu, Kategoria_id, Rower_id, Cena)
	SELECT r.Nazwa_roweru, k.id, r.id, 820
	FROM Kategoria AS k
	CROSS JOIN Rower AS r
	WHERE k.Nazwa_kategorii = 'rower'
	AND r.id = 8;
    
INSERT INTO Produkt (Nazwa_produktu, Kategoria_id, Rower_id, Cena)
	SELECT r.Nazwa_roweru, k.id, r.id, 400
	FROM Kategoria AS k
	CROSS JOIN Rower AS r
	WHERE k.Nazwa_kategorii = 'rower'
	AND r.id = 9;
    
INSERT INTO Produkt (Nazwa_produktu, Kategoria_id, Rower_id, Cena)
	SELECT r.Nazwa_roweru, k.id, r.id, 720
	FROM Kategoria AS k
	CROSS JOIN Rower AS r
	WHERE k.Nazwa_kategorii = 'rower'
	AND r.id = 10;
    
INSERT INTO Produkt (Nazwa_produktu, Kategoria_id, Rower_id, Cena)
	SELECT r.Nazwa_roweru, k.id, r.id, 910
	FROM Kategoria AS k
	CROSS JOIN Rower AS r
	WHERE k.Nazwa_kategorii = 'rower'
	AND r.id = 11;
    
INSERT INTO Produkt (Nazwa_produktu, Kategoria_id, Rower_id, Cena)
	SELECT r.Nazwa_roweru, k.id, r.id, 500
	FROM Kategoria AS k
	CROSS JOIN Rower AS r
	WHERE k.Nazwa_kategorii = 'rower'
	AND r.id = 12;
    
INSERT INTO Produkt (Nazwa_produktu, Kategoria_id, Rower_id, Cena)
	SELECT r.Nazwa_roweru, k.id, r.id, 930
	FROM Kategoria AS k
	CROSS JOIN Rower AS r
	WHERE k.Nazwa_kategorii = 'rower'
	AND r.id = 13;
    
INSERT INTO Produkt (Nazwa_produktu, Kategoria_id, Rower_id, Cena)
	SELECT r.Nazwa_roweru, k.id, r.id, 400
	FROM Kategoria AS k
	CROSS JOIN Rower AS r
	WHERE k.Nazwa_kategorii = 'rower'
	AND r.id = 14;
    
INSERT INTO Produkt (Nazwa_produktu, Kategoria_id, Rower_id, Cena)
	SELECT r.Nazwa_roweru, k.id, r.id, 550
	FROM Kategoria AS k
	CROSS JOIN Rower AS r
	WHERE k.Nazwa_kategorii = 'rower'
	AND r.id = 15;
    
INSERT INTO Produkt (Nazwa_produktu, Kategoria_id, Rower_id, Cena)
	SELECT r.Nazwa_roweru, k.id, r.id, 600
	FROM Kategoria AS k
	CROSS JOIN Rower AS r
	WHERE k.Nazwa_kategorii = 'rower'
	AND r.id = 16;
    
INSERT INTO Produkt (Nazwa_produktu, Kategoria_id, Rower_id, Cena)
	SELECT r.Nazwa_roweru, k.id, r.id, 770
	FROM Kategoria AS k
	CROSS JOIN Rower AS r
	WHERE k.Nazwa_kategorii = 'rower'
	AND r.id = 17;
    
INSERT INTO Produkt (Nazwa_produktu, Kategoria_id, Rower_id, Cena)
	SELECT r.Nazwa_roweru, k.id, r.id, 940
	FROM Kategoria AS k
	CROSS JOIN Rower AS r
	WHERE k.Nazwa_kategorii = 'rower'
	AND r.id = 18;
    
INSERT INTO Produkt (Nazwa_produktu, Kategoria_id, Rower_id, Cena)
	SELECT r.Nazwa_roweru, k.id, r.id, 500
	FROM Kategoria AS k
	CROSS JOIN Rower AS r
	WHERE k.Nazwa_kategorii = 'rower'
	AND r.id = 19;
    
INSERT INTO Produkt (Nazwa_produktu, Kategoria_id, Rower_id, Cena)
	SELECT r.Nazwa_roweru, k.id, r.id, 800
	FROM Kategoria AS k
	CROSS JOIN Rower AS r
	WHERE k.Nazwa_kategorii = 'rower'
	AND r.id = 20;
    
INSERT INTO Produkt (Nazwa_produktu, Kategoria_id, Rower_id, Cena)
	SELECT r.Nazwa_roweru, k.id, r.id, 950
	FROM Kategoria AS k
	CROSS JOIN Rower AS r
	WHERE k.Nazwa_kategorii = 'rower'
	AND r.id = 21;
    
INSERT INTO Produkt (Nazwa_produktu, Kategoria_id, Rower_id, Cena)
	SELECT r.Nazwa_roweru, k.id, r.id, 820
	FROM Kategoria AS k
	CROSS JOIN Rower AS r
	WHERE k.Nazwa_kategorii = 'rower'
	AND r.id = 22;
    
    
-- Produkt - Rama

INSERT INTO Produkt (Nazwa_produktu, Kategoria_id, Cena)
	SELECT 'Accent Mitori', k.id, 100
    FROM Kategoria as k
    WHERE k.Nazwa_kategorii = 'rama';
    
INSERT INTO Produkt (Nazwa_produktu, Kategoria_id, Cena)
	SELECT 'Accent Ranger', k.id, 200
    FROM Kategoria as k
    WHERE k.Nazwa_kategorii = 'rama';
    
INSERT INTO Produkt (Nazwa_produktu, Kategoria_id, Cena)
	SELECT 'Accent Shannon', k.id, 250
    FROM Kategoria as k
    WHERE k.Nazwa_kategorii = 'rama';
    
INSERT INTO Produkt (Nazwa_produktu, Kategoria_id, Cena)
	SELECT 'Accent Tormenta Lady', k.id, 150
    FROM Kategoria as k
    WHERE k.Nazwa_kategorii = 'rama';
    
INSERT INTO Produkt (Nazwa_produktu, Kategoria_id, Cena)
	SELECT 'Accent Volt', k.id, 300
    FROM Kategoria as k
    WHERE k.Nazwa_kategorii = 'rama';
    
INSERT INTO Produkt (Nazwa_produktu, Kategoria_id, Cena)
	SELECT 'Accent Nordkapp', k.id, 450
    FROM Kategoria as k
    WHERE k.Nazwa_kategorii = 'rama';
    
INSERT INTO Produkt (Nazwa_produktu, Kategoria_id, Cena)
	SELECT 'Kettler Peak Lady', k.id, 150
    FROM Kategoria as k
    WHERE k.Nazwa_kategorii = 'rama';
    
INSERT INTO Produkt (Nazwa_produktu, Kategoria_id, Cena)
	SELECT 'Unity Apex', k.id, 250
    FROM Kategoria as k
    WHERE k.Nazwa_kategorii = 'rama';
    

-- Produkt - Kierownice
    
INSERT INTO Produkt (Nazwa_produktu, Kategoria_id, Cena)
	SELECT 'Le Grand Ergo', k.id, 150
    FROM Kategoria as k
    WHERE k.Nazwa_kategorii = 'kierownica';
    
INSERT INTO Produkt (Nazwa_produktu, Kategoria_id, Cena)
	SELECT 'Le Grand Force', k.id, 250
    FROM Kategoria as k
    WHERE k.Nazwa_kategorii = 'kierownica';
    
INSERT INTO Produkt (Nazwa_produktu, Kategoria_id, Cena)
	SELECT 'Le Grand Road', k.id, 200
    FROM Kategoria as k
    WHERE k.Nazwa_kategorii = 'kierownica';
    
INSERT INTO Produkt (Nazwa_produktu, Kategoria_id, Cena)
	SELECT 'Kenda Ozero TT', k.id, 100
    FROM Kategoria as k
    WHERE k.Nazwa_kategorii = 'kierownica';
    
INSERT INTO Produkt (Nazwa_produktu, Kategoria_id, Cena)
	SELECT 'Kenda Carbon', k.id, 450
    FROM Kategoria as k
    WHERE k.Nazwa_kategorii = 'kierownica';
    
INSERT INTO Produkt (Nazwa_produktu, Kategoria_id, Cena)
	SELECT 'Kenda Basic', k.id, 50
    FROM Kategoria as k
    WHERE k.Nazwa_kategorii = 'kierownica';
    
INSERT INTO Produkt (Nazwa_produktu, Kategoria_id, Cena)
	SELECT 'Mitas Crossroad', k.id, 200
    FROM Kategoria as k
    WHERE k.Nazwa_kategorii = 'kierownica';
    
INSERT INTO Produkt (Nazwa_produktu, Kategoria_id, Cena)
	SELECT 'Mitas Ergotec', k.id, 150
    FROM Kategoria as k
    WHERE k.Nazwa_kategorii = 'kierownica';
    

-- Produkt - Siodełka

INSERT INTO Produkt (Nazwa_produktu, Kategoria_id, Cena)
	SELECT 'Burghardt Athletic', k.id, 50
    FROM Kategoria as k
    WHERE k.Nazwa_kategorii = 'siodełko';
    
INSERT INTO Produkt (Nazwa_produktu, Kategoria_id, Cena)
	SELECT 'Burghardt Moderate', k.id, 60
    FROM Kategoria as k
    WHERE k.Nazwa_kategorii = 'siodełko';
    
INSERT INTO Produkt (Nazwa_produktu, Kategoria_id, Cena)
	SELECT 'Burghardt Ellipse', k.id, 40
    FROM Kategoria as k
    WHERE k.Nazwa_kategorii = 'siodełko';
    
INSERT INTO Produkt (Nazwa_produktu, Kategoria_id, Cena)
	SELECT 'Burghardt Italia', k.id, 80
    FROM Kategoria as k
    WHERE k.Nazwa_kategorii = 'siodełko';
    
INSERT INTO Produkt (Nazwa_produktu, Kategoria_id, Cena)
	SELECT 'Fulcrum Sportouer', k.id, 50
    FROM Kategoria as k
    WHERE k.Nazwa_kategorii = 'siodełko';
    
INSERT INTO Produkt (Nazwa_produktu, Kategoria_id, Cena)
	SELECT 'Fulcrum Relaxed Sky', k.id, 30
    FROM Kategoria as k
    WHERE k.Nazwa_kategorii = 'siodełko';
    
INSERT INTO Produkt (Nazwa_produktu, Kategoria_id, Cena)
	SELECT 'Fulcrum Relaxed Viento', k.id, 20
    FROM Kategoria as k
    WHERE k.Nazwa_kategorii = 'siodełko';
    
INSERT INTO Produkt (Nazwa_produktu, Kategoria_id, Cena)
	SELECT 'Pin Up Grappa', k.id, 20
    FROM Kategoria as k
    WHERE k.Nazwa_kategorii = 'siodełko';
    
    
-- Produkt - Koła

INSERT INTO Produkt (Nazwa_produktu, Kategoria_id, Cena)
	SELECT 'Pin Up Spline', k.id, 300
    FROM Kategoria as k
    WHERE k.Nazwa_kategorii = 'koło';
    
INSERT INTO Produkt (Nazwa_produktu, Kategoria_id, Cena)
	SELECT 'Pin Up Passion', k.id, 200
    FROM Kategoria as k
    WHERE k.Nazwa_kategorii = 'koło';
    
INSERT INTO Produkt (Nazwa_produktu, Kategoria_id, Cena)
	SELECT 'Pin Up Thru', k.id, 150
    FROM Kategoria as k
    WHERE k.Nazwa_kategorii = 'koło';
    
INSERT INTO Produkt (Nazwa_produktu, Kategoria_id, Cena)
	SELECT 'Pin Up Crossride', k.id, 320
    FROM Kategoria as k
    WHERE k.Nazwa_kategorii = 'koło';
    
INSERT INTO Produkt (Nazwa_produktu, Kategoria_id, Cena)
	SELECT 'Accent Country', k.id, 240
    FROM Kategoria as k
    WHERE k.Nazwa_kategorii = 'koło';
    
INSERT INTO Produkt (Nazwa_produktu, Kategoria_id, Cena)
	SELECT 'Accent Novatec', k.id, 80
    FROM Kategoria as k
    WHERE k.Nazwa_kategorii = 'koło';
    
INSERT INTO Produkt (Nazwa_produktu, Kategoria_id, Cena)
	SELECT 'Kettler Joytech', k.id, 350
    FROM Kategoria as k
    WHERE k.Nazwa_kategorii = 'koło';
    
INSERT INTO Produkt (Nazwa_produktu, Kategoria_id, Cena)
	SELECT 'Kettler Swift', k.id, 170
    FROM Kategoria as k
    WHERE k.Nazwa_kategorii = 'koło';
    
    
-- Produkt - Opony

INSERT INTO Produkt (Nazwa_produktu, Kategoria_id, Cena)
	SELECT 'Continental Burt', k.id, 27
    FROM Kategoria as k
    WHERE k.Nazwa_kategorii = 'opona';
    
INSERT INTO Produkt (Nazwa_produktu, Kategoria_id, Cena)
	SELECT 'Continental Standard', k.id, 15
    FROM Kategoria as k
    WHERE k.Nazwa_kategorii = 'opona';
    
INSERT INTO Produkt (Nazwa_produktu, Kategoria_id, Cena)
	SELECT 'Continental Compact', k.id, 17
    FROM Kategoria as k
    WHERE k.Nazwa_kategorii = 'opona';
    
INSERT INTO Produkt (Nazwa_produktu, Kategoria_id, Cena)
	SELECT 'Kenda Khan', k.id, 25
    FROM Kategoria as k
    WHERE k.Nazwa_kategorii = 'opona';
    
INSERT INTO Produkt (Nazwa_produktu, Kategoria_id, Cena)
	SELECT 'Kenda K898', k.id, 30
    FROM Kategoria as k
    WHERE k.Nazwa_kategorii = 'opona';
    
INSERT INTO Produkt (Nazwa_produktu, Kategoria_id, Cena)
	SELECT 'Kenda Thunder', k.id, 40
    FROM Kategoria as k
    WHERE k.Nazwa_kategorii = 'opona';
    
INSERT INTO Produkt (Nazwa_produktu, Kategoria_id, Cena)
	SELECT 'Continental Tour', k.id, 35
    FROM Kategoria as k
    WHERE k.Nazwa_kategorii = 'opona';
    
INSERT INTO Produkt (Nazwa_produktu, Kategoria_id, Cena)
	SELECT 'Continental Slim', k.id, 50
    FROM Kategoria as k
    WHERE k.Nazwa_kategorii = 'opona';
    

INSERT INTO Lokalizacja_sklepu(kod_pocztowy, telefon, adres, Miasto_id)
	SELECT '02777', '555666777', 'ul.Grochowska 7, Warszawa', m.id
    FROM Miasto AS m
    WHERE m.Nazwa = 'Warszawa';


INSERT INTO Lokalizacja_sklepu(kod_pocztowy, telefon, adres, Miasto_id)
	SELECT '35666', '555666765', 'ul.Kopernika 3, Toruń', m.id
    FROM Miasto AS m
    WHERE m.Nazwa = 'Toruń';


INSERT INTO Lokalizacja_sklepu(kod_pocztowy, telefon, adres, Miasto_id)
	SELECT '15676', '535646775', 'ul.Portowa 4, Gdańsk', m.id
    FROM Miasto AS m
    WHERE m.Nazwa = 'Gdańsk';

INSERT INTO Lokalizacja_sklepu(kod_pocztowy, telefon, adres, Miasto_id)
	SELECT '18888', '995656795', 'ul.Warszawska 136, Wrocław', m.id
    FROM Miasto AS m
    WHERE m.Nazwa = 'Wrocław';

INSERT INTO Lokalizacja_sklepu(kod_pocztowy, telefon, adres, Miasto_id)
	SELECT '88675', '987453761', 'ul.Sukiennice 1, Kraków', m.id
    FROM Miasto AS m
    WHERE m.Nazwa = 'Kraków';
    

    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    

-- End of file.

