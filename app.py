import uuid
#from flask.ext.login import UserMixin
from flask import Flask, render_template, request, redirect, url_for, session
from flask_login import LoginManager, login_user, current_user, UserMixin, logout_user
from flask_sqlalchemy import SQLAlchemy
from flask_wtf import FlaskForm
import flask_login
import pymysql
from wtforms import StringField, PasswordField, BooleanField
from wtforms.validators import InputRequired, Length, Email
from werkzeug import generate_password_hash, check_password_hash
app = Flask(__name__)
app.config['SQLALCHEMY_DATABASE_URI'] = 'mysql+pymysql://sklep:sklep@localhost:3306/sklep_rowerowy'
app.config['SQLALCHEMY_ECHO'] = True
db = SQLAlchemy(app)
import model
from model import model_
app.register_blueprint(model_)
app.config['SECRET_KEY'] = 'fghjmkfrihffrhr'
login_manager = LoginManager()
login_manager.init_app(app)
login_manager.login_view = 'login'

@login_manager.user_loader
def load_user(user_id):
    return model.Klient.query.get(int(user_id))

@app.route('/')
def index():
    return render_template('index.html')

@app.route('/login', methods=['GET', 'POST'])
def login():
    return render_template('login.html')

@app.route('/signIn', methods=['GET','POST'])
def signIn():
    form = model.LoginForm()
    _login = request.form['login']
    _password = request.form['password']
 #   if form.validate_on_submit():
    user = model.Klient.query.filter_by(login=_login).first()
    if user:
        if (check_password_hash(user.haslo, _password)):
            login_user(user)
            return redirect('/')
    return render_template('wronglogin.html')

@app.route('/register')
def register():
    return render_template('register.html')


@app.route('/signUp', methods=['GET','POST'])
def signUp():
    _imie = request.form['imie']
    _nazwisko = request.form['nazwisko']
    _login = request.form['login']
    login = model.Klient.query.filter_by(login=_login).first()
    if login:
        return render_template('wrongregister.html')
    _email = request.form['email']
    email = model.Klient.query.filter_by(email = _email).first()
    if email:
        return render_template('wrongregister.html')
    _password = request.form['password']
    _hashed_password = generate_password_hash(_password)
    new_user = model.Klient(imie = _imie, nazwisko = _nazwisko , login=_login, email=_email, haslo=_hashed_password)
    db.session.add(new_user)
    db.session.commit()
    return redirect('/userCreated')

@app.route('/bikes')
def bikes():
    textToFind = request.args.get('search', '')
    priceMin = request.args.get('price-min', '')
    priceMax = request.args.get('price-max', '')
    if textToFind != '':
        bikes = model.Produkt.query.join(model.Kategoria, model.Produkt.kategoria_id == model.Kategoria.id).filter_by(nazwa_kategorii='rower').filter(model.Produkt.nazwa_produktu.ilike("%" + textToFind + "%"))
        return render_template('category_template.html', productList=bikes, categoryName="Rowery")

    if priceMin != '':
        bikes = model.Produkt.query.join(model.Kategoria, model.Produkt.kategoria_id == model.Kategoria.id).filter_by(nazwa_kategorii='rower').filter(model.Produkt.cena.between(priceMin, priceMax))
        return render_template('category_template.html', productList=bikes, categoryName="Rowery")

    bikes = model.Produkt.query.join(model.Kategoria, model.Produkt.kategoria_id == model.Kategoria.id).filter_by(nazwa_kategorii='rower')
    return render_template('category_template.html', productList=bikes, categoryName="Rowery")

@app.route('/frames')
def frames():
    textToFind = request.args.get('search', '')
    priceMin = request.args.get('price-min', '')
    priceMax = request.args.get('price-max', '')
    if textToFind != '':
        frames = model.Produkt.query.join(model.Kategoria, model.Produkt.kategoria_id == model.Kategoria.id).filter_by(nazwa_kategorii='rama').filter(model.Produkt.nazwa_produktu.ilike("%" + textToFind + "%"))
        return render_template('category_template.html', productList=frames, categoryName="Ramy")

    if priceMin != '':
        frames = model.Produkt.query.join(model.Kategoria, model.Produkt.kategoria_id == model.Kategoria.id).filter_by(nazwa_kategorii='rama').filter(model.Produkt.cena.between(priceMin, priceMax))
        return render_template('category_template.html', productList=frames, categoryName="Ramy")

    frames = model.Produkt.query.join(model.Kategoria, model.Produkt.kategoria_id == model.Kategoria.id).filter_by(nazwa_kategorii='rama')
    return render_template('category_template.html', productList=frames, categoryName="Ramy")

@app.route('/handlebars')
def handlebars():
    textToFind = request.args.get('search', '')
    priceMin = request.args.get('price-min', '')
    priceMax = request.args.get('price-max', '')
    if textToFind != '':
        handlebars = model.Produkt.query.join(model.Kategoria, model.Produkt.kategoria_id == model.Kategoria.id).filter_by(nazwa_kategorii='kierownica').filter(model.Produkt.nazwa_produktu.ilike("%" + textToFind + "%"))
        return render_template('category_template.html', productList=handlebars, categoryName="Kierownice")

    if priceMin != '':
        handlebars = model.Produkt.query.join(model.Kategoria, model.Produkt.kategoria_id == model.Kategoria.id).filter_by(nazwa_kategorii='kierownica').filter(model.Produkt.cena.between(priceMin, priceMax))
        return render_template('category_template.html', productList=handlebars, categoryName="Kierownice")

    handlebars = model.Produkt.query.join(model.Kategoria, model.Produkt.kategoria_id == model.Kategoria.id).filter_by(nazwa_kategorii='kierownica')
    return render_template('category_template.html', productList=handlebars, categoryName="Kierownice")

@app.route('/saddles')
def saddles():
    textToFind = request.args.get('search', '')
    priceMin = request.args.get('price-min', '')
    priceMax = request.args.get('price-max', '')
    if textToFind != '':
        saddles = model.Produkt.query.join(model.Kategoria, model.Produkt.kategoria_id == model.Kategoria.id).filter_by(nazwa_kategorii='siodełko').filter(model.Produkt.nazwa_produktu.ilike("%" + textToFind + "%"))
        return render_template('category_template.html', productList=saddles, categoryName="Siodełka")

    if priceMin != '':
        saddles = model.Produkt.query.join(model.Kategoria, model.Produkt.kategoria_id == model.Kategoria.id).filter_by(nazwa_kategorii='siodełko').filter(model.Produkt.cena.between(priceMin, priceMax))
        return render_template('category_template.html', productList=saddles, categoryName="Siodełka")

    saddles = model.Produkt.query.join(model.Kategoria, model.Produkt.kategoria_id == model.Kategoria.id).filter_by(nazwa_kategorii='siodełko')
    return render_template('category_template.html', productList=saddles, categoryName="Siodełka")

@app.route('/wheels')
def wheels():
    textToFind = request.args.get('search', '')
    priceMin = request.args.get('price-min', '')
    priceMax = request.args.get('price-max', '')
    if textToFind != '':
        wheels = model.Produkt.query.join(model.Kategoria, model.Produkt.kategoria_id == model.Kategoria.id).filter_by(nazwa_kategorii='koło').filter(model.Produkt.nazwa_produktu.ilike("%" + textToFind + "%"))
        return render_template('category_template.html', productList=wheels, categoryName="Koła")

    if priceMin != '':
        wheels = model.Produkt.query.join(model.Kategoria, model.Produkt.kategoria_id == model.Kategoria.id).filter_by(nazwa_kategorii='koło').filter(model.Produkt.cena.between(priceMin, priceMax))
        return render_template('category_template.html', productList=wheels, categoryName="Koła")

    wheels = model.Produkt.query.join(model.Kategoria, model.Produkt.kategoria_id == model.Kategoria.id).filter_by(nazwa_kategorii='koło')
    return render_template('category_template.html', productList=wheels, categoryName="Koła")

@app.route('/tyres')
def tyres():
    textToFind = request.args.get('search', '')
    priceMin = request.args.get('price-min', '')
    priceMax = request.args.get('price-max', '')
    if textToFind != '':
        tyres = model.Produkt.query.join(model.Kategoria, model.Produkt.kategoria_id == model.Kategoria.id).filter_by(nazwa_kategorii='opona').filter(model.Produkt.nazwa_produktu.ilike("%" + textToFind + "%"))
        return render_template('category_template.html', productList=tyres, categoryName="Opony")

    if priceMin != '':
        tyres = model.Produkt.query.join(model.Kategoria, model.Produkt.kategoria_id == model.Kategoria.id).filter_by(nazwa_kategorii='opona').filter(model.Produkt.cena.between(priceMin, priceMax))
        return render_template('category_template.html', productList=tyres, categoryName="Opony")

    tyres = model.Produkt.query.join(model.Kategoria, model.Produkt.kategoria_id == model.Kategoria.id).filter_by(nazwa_kategorii='opona')
    return render_template('category_template.html', productList=tyres, categoryName="Opony")

@app.route('/cart')
def cart():
    return render_template('cart.html')

@app.route('/makeOrder')
def makeOrder():
    return render_template('order.html')

# do testowania czy poprawnie wyświetla
@app.route('/userCreated')
def userCreated():
    return render_template('userCreated.html')

@app.route('/product<int:product_id>')
def product_template(product_id):
    productObj = model.Produkt.query.filter_by(id=product_id).first()
    categoryObj = model.Kategoria.query.filter_by(id=productObj.kategoria_id).first()
    if categoryObj.nazwa_kategorii == 'rower':
        bikeObj = model.Rower.query.filter_by(id=productObj.rower_id).first()
        typeObj = model.RodzajRoweru.query.filter_by(id=bikeObj.rodzaj_roweru_id).first()
        brandObj = model.Marka.query.filter_by(id=bikeObj.marka_id).first()
        return render_template('product_template.html', productName=productObj.nazwa_produktu, brand=brandObj.nazwa_marki, category=categoryObj.nazwa_kategorii, diameter=bikeObj.srednica_kola, price=productObj.cena,  type=typeObj.rodzaj)

    return render_template('product_template.html', productName=productObj.nazwa_produktu, brand='nie dotyczy', category=categoryObj.nazwa_kategorii, diameter='nie dotyczy', price=productObj.cena,  type='nie dotyczy')

@app.route('/stores')
def stores():
    stores = model.LokalizacjaSklepu.query.all()
#    print(stores)
    return render_template('stores.html', productList = stores)
@app.route('/searchStores?search=<string:miasto>')
def searchStores(miasto):
    stores = model.LokalizacjaSklepu.query.filter_by(miasto = miasto).first()
    return render_template('stores.html', productList = stores)
@app.route('/logout')
def logout():
    logout_user()
    return redirect('/')

if __name__ == '__main__':
    app.run(debug=True)
