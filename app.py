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

    new_cart = model.Koszyk(klient_id = new_user.id)
    db.session.add(new_cart)
    db.session.commit()

    return redirect('/userCreated')

@app.route('/bikes')
def bikes():
    textToFind = request.args.get('search', '')
    priceMin = request.args.get('price-min', '')
    priceMax = request.args.get('price-max', '')
    if textToFind != '':
        bikes = model.Produkt.query.join(model.Kategoria, model.Produkt.kategoria_id == model.Kategoria.id).filter_by(nazwa_kategorii='Rower').filter(model.Produkt.nazwa_produktu.ilike("%" + textToFind + "%"))
        return render_template('category_template.html', productList=bikes, categoryName="Rowery")

    if priceMin != '':
        bikes = model.Produkt.query.join(model.Kategoria, model.Produkt.kategoria_id == model.Kategoria.id).filter_by(nazwa_kategorii='Rower').filter(model.Produkt.cena.between(priceMin, priceMax))
        return render_template('category_template.html', productList=bikes, categoryName="Rowery")

    bikes = model.Produkt.query.join(model.Kategoria, model.Produkt.kategoria_id == model.Kategoria.id).filter_by(nazwa_kategorii='Rower')
    return render_template('category_template.html', productList=bikes, categoryName="Rowery")

@app.route('/frames')
def frames():
    textToFind = request.args.get('search', '')
    priceMin = request.args.get('price-min', '')
    priceMax = request.args.get('price-max', '')
    if textToFind != '':
        frames = model.Produkt.query.join(model.Kategoria, model.Produkt.kategoria_id == model.Kategoria.id).filter_by(nazwa_kategorii='Rama').filter(model.Produkt.nazwa_produktu.ilike("%" + textToFind + "%"))
        return render_template('category_template.html', productList=frames, categoryName="Ramy")

    if priceMin != '':
        frames = model.Produkt.query.join(model.Kategoria, model.Produkt.kategoria_id == model.Kategoria.id).filter_by(nazwa_kategorii='Rama').filter(model.Produkt.cena.between(priceMin, priceMax))
        return render_template('category_template.html', productList=frames, categoryName="Ramy")

    frames = model.Produkt.query.join(model.Kategoria, model.Produkt.kategoria_id == model.Kategoria.id).filter_by(nazwa_kategorii='Rama')
    return render_template('category_template.html', productList=frames, categoryName="Ramy")

@app.route('/handlebars')
def handlebars():
    textToFind = request.args.get('search', '')
    priceMin = request.args.get('price-min', '')
    priceMax = request.args.get('price-max', '')
    if textToFind != '':
        handlebars = model.Produkt.query.join(model.Kategoria, model.Produkt.kategoria_id == model.Kategoria.id).filter_by(nazwa_kategorii='Kierownica').filter(model.Produkt.nazwa_produktu.ilike("%" + textToFind + "%"))
        return render_template('category_template.html', productList=handlebars, categoryName="Kierownice")

    if priceMin != '':
        handlebars = model.Produkt.query.join(model.Kategoria, model.Produkt.kategoria_id == model.Kategoria.id).filter_by(nazwa_kategorii='Kierownica').filter(model.Produkt.cena.between(priceMin, priceMax))
        return render_template('category_template.html', productList=handlebars, categoryName="Kierownice")

    handlebars = model.Produkt.query.join(model.Kategoria, model.Produkt.kategoria_id == model.Kategoria.id).filter_by(nazwa_kategorii='Kierownica')
    return render_template('category_template.html', productList=handlebars, categoryName="Kierownice")

@app.route('/saddles')
def saddles():
    textToFind = request.args.get('search', '')
    priceMin = request.args.get('price-min', '')
    priceMax = request.args.get('price-max', '')
    if textToFind != '':
        saddles = model.Produkt.query.join(model.Kategoria, model.Produkt.kategoria_id == model.Kategoria.id).filter_by(nazwa_kategorii='Siodełko').filter(model.Produkt.nazwa_produktu.ilike("%" + textToFind + "%"))
        return render_template('category_template.html', productList=saddles, categoryName="Siodełka")

    if priceMin != '':
        saddles = model.Produkt.query.join(model.Kategoria, model.Produkt.kategoria_id == model.Kategoria.id).filter_by(nazwa_kategorii='Siodełko').filter(model.Produkt.cena.between(priceMin, priceMax))
        return render_template('category_template.html', productList=saddles, categoryName="Siodełka")

    saddles = model.Produkt.query.join(model.Kategoria, model.Produkt.kategoria_id == model.Kategoria.id).filter_by(nazwa_kategorii='Siodełko')
    return render_template('category_template.html', productList=saddles, categoryName="Siodełka")

@app.route('/wheels')
def wheels():
    textToFind = request.args.get('search', '')
    priceMin = request.args.get('price-min', '')
    priceMax = request.args.get('price-max', '')
    if textToFind != '':
        wheels = model.Produkt.query.join(model.Kategoria, model.Produkt.kategoria_id == model.Kategoria.id).filter_by(nazwa_kategorii='Koło').filter(model.Produkt.nazwa_produktu.ilike("%" + textToFind + "%"))
        return render_template('category_template.html', productList=wheels, categoryName="Koła")

    if priceMin != '':
        wheels = model.Produkt.query.join(model.Kategoria, model.Produkt.kategoria_id == model.Kategoria.id).filter_by(nazwa_kategorii='Koło').filter(model.Produkt.cena.between(priceMin, priceMax))
        return render_template('category_template.html', productList=wheels, categoryName="Koła")

    wheels = model.Produkt.query.join(model.Kategoria, model.Produkt.kategoria_id == model.Kategoria.id).filter_by(nazwa_kategorii='Koło')
    return render_template('category_template.html', productList=wheels, categoryName="Koła")

@app.route('/tyres')
def tyres():
    textToFind = request.args.get('search', '')
    priceMin = request.args.get('price-min', '')
    priceMax = request.args.get('price-max', '')
    if textToFind != '':
        tyres = model.Produkt.query.join(model.Kategoria, model.Produkt.kategoria_id == model.Kategoria.id).filter_by(nazwa_kategorii='Opona').filter(model.Produkt.nazwa_produktu.ilike("%" + textToFind + "%"))
        return render_template('category_template.html', productList=tyres, categoryName="Opony")

    if priceMin != '':
        tyres = model.Produkt.query.join(model.Kategoria, model.Produkt.kategoria_id == model.Kategoria.id).filter_by(nazwa_kategorii='Opona').filter(model.Produkt.cena.between(priceMin, priceMax))
        return render_template('category_template.html', productList=tyres, categoryName="Opony")

    tyres = model.Produkt.query.join(model.Kategoria, model.Produkt.kategoria_id == model.Kategoria.id).filter_by(nazwa_kategorii='Opona')
    return render_template('category_template.html', productList=tyres, categoryName="Opony")

@app.route('/cart', methods=['GET', 'POST'])
def cart():
    currentCart = model.Koszyk.query.filter_by(klient_id=current_user.id).first()
    currentCartID = currentCart.id
    if request.method == 'POST':
        productToCartID = request.form['idOfProduct']
        cartItem = model.KoszykPozycja(produkt_id=productToCartID, koszyk_id=currentCartID)
        db.session.add(cartItem)
        db.session.commit()

    cartList = model.Produkt.query.join(model.KoszykPozycja, model.Produkt.id == model.KoszykPozycja.produkt_id).filter_by(koszyk_id=currentCartID).all()
    return render_template('cart.html', cartList = cartList)

@app.route('/removeFromCart', methods=['POST'])
def removeFromCart():
    toRemoveID = request.form['toRemoveID']
    currentCart = model.Koszyk.query.filter_by(klient_id=current_user.id).first()
    currentCartID = currentCart.id
    itemToRemove = model.KoszykPozycja.query.filter_by(koszyk_id=currentCartID).filter_by(produkt_id=toRemoveID).first()
    db.session.delete(itemToRemove)
    db.session.commit()
    return redirect('/cart')

def clearCart():
    currentCart = model.Koszyk.query.filter_by(klient_id=current_user.id).first()
    currentCartID = currentCart.id
    currentCartItems = model.KoszykPozycja.query.filter_by(koszyk_id=currentCartID)
    for i in currentCartItems:
        db.session.delete(i)
        db.session.commit()

@app.route('/makeOrder', methods = ['GET', 'POST'])
def makeOrder():
    stores = model.LokalizacjaSklepu.query.all()
    return render_template('order.html', productList = stores)

@app.route('/order', methods=['GET','POST'])
def order():
    _miasto = request.form.get('miasto')
    print(_miasto)
    _lokalizacja = model.LokalizacjaSklepu.query.filter_by(adres=_miasto).first()
    currentCart = model.Koszyk.query.filter_by(klient_id=current_user.id).first()
    order = model.Zamowienie(lokalizacja_sklepu_id = _lokalizacja.id, klient_id=current_user.id)
    db.session.add(order)
    db.session.commit()
    currentCartID = currentCart.id
    if request.method == 'POST':
         currentCartItems = model.KoszykPozycja.query.filter_by(koszyk_id = currentCartID)
         for i in currentCartItems:
             orderItem = model.ZamowieniePozycja(produkt_id=i.produkt_id , zamowienie_id = order.id)
             db.session.add(orderItem)
             db.session.commit()
    clearCart()
    return render_template('order_summary.html')

# do testowania czy poprawnie wyświetla
@app.route('/userCreated')
def userCreated():
    return render_template('userCreated.html')

@app.route('/product<int:product_id>')
def product_template(product_id):
    productObj = model.Produkt.query.filter_by(id=product_id).first()
    categoryObj = model.Kategoria.query.filter_by(id=productObj.kategoria_id).first()
    if categoryObj.nazwa_kategorii == 'Rower':
        bikeObj = model.Rower.query.filter_by(id=productObj.rower_id).first()
        typeObj = model.RodzajRoweru.query.filter_by(id=bikeObj.rodzaj_roweru_id).first()
        brandObj = model.Marka.query.filter_by(id=bikeObj.marka_id).first()
        return render_template('product_template.html', productName=productObj.nazwa_produktu, category=categoryObj.nazwa_kategorii, diameter=bikeObj.srednica_kola, price=productObj.cena,  type=typeObj.rodzaj, id_of_product=productObj.id)

    return render_template('product_template.html', productName=productObj.nazwa_produktu, category=categoryObj.nazwa_kategorii, diameter='nie dotyczy', price=productObj.cena,  type='nie dotyczy', id_of_product=productObj.id)

@app.route('/stores')
def stores():
    textToFind = request.args.get('search', '')
    if textToFind != '':
        stores = model.LokalizacjaSklepu.query.join(model.Miasto, model.LokalizacjaSklepu.miasto_id == model.Miasto.id).filter(model.Miasto.nazwa.ilike("%" + textToFind + "%"))
        return render_template('stores.html', productList=stores, categoryName="Nasze sklepy")
    stores = model.LokalizacjaSklepu.query.all()
#    print(stores)
    return render_template('stores.html', productList = stores, categoryName = "Nasze sklepy")
@app.route('/logout')
def logout():
    logout_user()
    return redirect('/')

if __name__ == '__main__':
    app.run(debug=True)
