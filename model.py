from flask import Blueprint, render_template, abort

model_ = Blueprint('model_', __name__)

import sqlalchemy
from sqlalchemy import create_engine
from sqlalchemy.ext.declarative import declarative_base
from sqlalchemy import Column, Integer, BigInteger, String, ForeignKey, Unicode, Binary, LargeBinary, Time, DateTime, Date, Text, Boolean, Float, JSON
from sqlalchemy.orm import relationship, backref, deferred
from sqlalchemy.orm import sessionmaker

Base = declarative_base()



class Produkt (Base):
    __tablename__ = "Produkt"
    nazwa_produktu = Column('Nazwa_produktu', Unicode)
    id = Column('id', Integer, primary_key = True)
    kategoria_id = Column('Kategoria_id', Integer, ForeignKey('Kategoria.id'))
    rower_id = Column('Rower_id', Integer, ForeignKey('Rower.id'))
    cena = Column('Cena', BigInteger)

    kategoria = relationship('Kategoria', foreign_keys=kategoria_id)
    rower = relationship('Rower', foreign_keys=rower_id)

class Kategoria (Base):
    __tablename__ = "Kategoria"
    id = Column('id', Integer, primary_key = True)
    nazwa_kategorii = Column('Nazwa_kategorii', Unicode)

class ZamowieniePozycja (Base):
    __tablename__ = "Zamowienie_pozycja"
    id = Column('id', Integer, primary_key = True)
    produkt_id = Column('Produkt_id', Integer, ForeignKey('Produkt.id'))
    zamowienie_id = Column('Zamowienie_id', Integer, ForeignKey('Zamowienie.id'))

    produkt = relationship('Produkt', foreign_keys=produkt_id)
    zamowienie = relationship('Zamowienie', foreign_keys=zamowienie_id)

class RodzajRoweru (Base):
    __tablename__ = "Rodzaj_roweru"
    id = Column('id', Integer, primary_key = True)
    rodzaj = Column('Rodzaj', Unicode)

class Rower (Base):
    __tablename__ = "Rower"
    id = Column('id', Integer, primary_key = True)
    nazwa_roweru = Column('Nazwa_roweru', Unicode)
    srednica_kola = Column('Srednica_kola', Integer)
    nazwa_modelu = Column('Nazwa_modelu', Unicode)
    rodzaj_roweru_id = Column('Rodzaj_roweru_id', Integer, ForeignKey('Rodzaj_roweru.id'))
    marka_id = Column('Marka_id', Integer, ForeignKey('Marka.id'))

    rodzaj_roweru = relationship('RodzajRoweru', foreign_keys=rodzaj_roweru_id)
    marka = relationship('Marka', foreign_keys=marka_id)

class Marka (Base):
    __tablename__ = "Marka"
    id = Column('id', Integer, primary_key = True)
    nazwa_marki = Column('Nazwa_marki', Unicode)

class StanMagazynowy (Base):
    __tablename__ = "Stan_magazynowy"
    id = Column('id', Integer, primary_key = True)
    stan = Column('Stan', Integer)
    produkt_id = Column('Produkt_id', Integer, ForeignKey('Produkt.id'))
    lokalizacja_sklepu_id = Column('Lokalizacja_sklepu_id', Integer, ForeignKey('Lokalizacja_sklepu.id'))

    produkt = relationship('Produkt', foreign_keys=produkt_id)
    lokalizacja_sklepu = relationship('LokalizacjaSklepu', foreign_keys=lokalizacja_sklepu_id)

class LokalizacjaSklepu (Base):
    __tablename__ = "Lokalizacja_sklepu"
    id = Column('id', Integer, primary_key = True)
    kod_pocztowy = Column('kod_pocztowy', Integer)
    telefon = Column('telefon', Integer)
    adres = Column('adres', Unicode)
    miasto_id = Column('Miasto_id', Integer, ForeignKey('Miasto.id'))

    miasto = relationship('Miasto', foreign_keys=miasto_id)

class Miasto (Base):
    __tablename__ = "Miasto"
    id = Column('id', Integer, primary_key = True)
    nazwa = Column('Nazwa', Unicode)

class Zamowienie (Base):
    __tablename__ = "Zamowienie"
    id = Column('id', Integer, primary_key = True)
    lokalizacja_sklepu_id = Column('Lokalizacja_sklepu_id', Integer, ForeignKey('Lokalizacja_sklepu.id'))
    klient_id = Column('Klient_id', Integer, ForeignKey('Klient.id'))

    lokalizacja_sklepu = relationship('LokalizacjaSklepu', foreign_keys=lokalizacja_sklepu_id)
    klient = relationship('Klient', foreign_keys=klient_id)

class Pracownik (Base):
    __tablename__ = "Pracownik"
    id = Column('id', Integer, primary_key = True)
    stanowisko = Column('Stanowisko', Unicode)
    lokalizacja_sklepu_id = Column('Lokalizacja_sklepu_id', Integer, ForeignKey('Lokalizacja_sklepu.id'))
    imie = Column('Imie', Unicode)
    nazwisko = Column('Nazwisko', Unicode)

    lokalizacja_sklepu = relationship('LokalizacjaSklepu', foreign_keys=lokalizacja_sklepu_id)

class Klient (Base):
    __tablename__ = "Klient"
    id = Column('id', Integer, primary_key = True)
    imie = Column('Imie', Unicode)
    nazwisko = Column('Nazwisko', Unicode)
    login = Column('login', Unicode)
    haslo = Column('haslo', Unicode)
    email = Column('email', Unicode)

class Blad (Base):
    __tablename__ = "Blad"
    id = Column('id', Integer, primary_key = True)
    # Unknown SQL type: 'time'
    timestamp = Column('timestamp', String)
    ip = Column('IP', Integer)



