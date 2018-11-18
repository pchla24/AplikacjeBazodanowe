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
    haslo varchar(40) NOT NULL,
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
    Nazwa_produktu varchar(40) NOT NULL,
    id int NOT NULL AUTO_INCREMENT,
    Kategoria_id int NOT NULL,
    Rower_id int NOT NULL,
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

-- foreign keys
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

-- End of file.

