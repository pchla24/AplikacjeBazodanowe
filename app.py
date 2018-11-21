import uuid

from flask import Flask, render_template, request, redirect, url_for, session
from flask_login import LoginManager, login_user
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
        session['user'] = _login
        sid = str(uuid.uuid4())
        if (check_password_hash(user.haslo, _password)):
            #print('haslo przeszlo')
            #login_user(user)
            return redirect('/')
    return '<h1>Invalid username or password</h1>'

@app.route('/register')
def register():
    return render_template('register.html')


@app.route('/signUp', methods=['GET','POST'])
def signUp():
    _imie = request.form['imie']
    _nazwisko = request.form['nazwisko']
    _login = request.form['login']
    _email = request.form['email']
    _password = request.form['password']
    _hashed_password = generate_password_hash(_password)
    new_user = model.Klient(imie = _imie, nazwisko = _nazwisko , login=_login, email=_email, haslo=_hashed_password)
    db.session.add(new_user)
    db.session.commit()
    return redirect('/userCreated')

@app.route('/bikes')
def bikes():
    # To zapytanie nie musi być takie długie ale chyba poprawnie wyciąga wszystkie dane o produkcie z bazy
    #bikes = model.Produkt.query.join(model.Rower, model.Produkt.rower_id == model.Rower.id).join(model.RodzajRoweru, model.Rower.rodzaj_roweru_id == model.RodzajRoweru.id).join(model.Marka, model.Rower.marka_id == model.Marka.id).all()
    bikes = model.Produkt.query.join(model.Kategoria, model.Produkt.kategoria_id == model.Kategoria.id).filter_by(nazwa_kategorii='rower')
    return render_template('category_template.html', productList=bikes)

@app.route('/frames')
def frames():
    frames = model.Produkt.query.join(model.Kategoria, model.Produkt.kategoria_id == model.Kategoria.id).filter_by(nazwa_kategorii='rama')
    return render_template('category_template.html', productList=frames)

@app.route('/handlebars')
def handlebars():
    handlebars = model.Produkt.query.join(model.Kategoria, model.Produkt.kategoria_id == model.Kategoria.id).filter_by(nazwa_kategorii='kierownica')
    return render_template('category_template.html', productList=handlebars)

@app.route('/saddles')
def saddles():
    saddles = model.Produkt.query.join(model.Kategoria, model.Produkt.kategoria_id == model.Kategoria.id).filter_by(nazwa_kategorii='siodełko')
    return render_template('category_template.html', productList=saddles)

@app.route('/wheels')
def wheels():
    wheels = model.Produkt.query.join(model.Kategoria, model.Produkt.kategoria_id == model.Kategoria.id).filter_by(nazwa_kategorii='koło')
    return render_template('category_template.html', productList=wheels)

@app.route('/tyres')
def tyres():
    tyres = model.Produkt.query.join(model.Kategoria, model.Produkt.kategoria_id == model.Kategoria.id).filter_by(nazwa_kategorii='opona')
    return render_template('category_template.html', productList=tyres)

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

@app.route('/product_template')
def product_template():
    return render_template('product_template.html')

@app.route('/stores')
def stores():
    stores = model.LokalizacjaSklepu.query.all()
    return render_template('stores.html')

def searchStores(miasto):
    stores = model.LokalizacjaSklepu.query.filter_by(miasto = miasto)
    print("ok" + miasto)
    return stores
@app.route('/logout')
def logout():
    userToLogout = session['user']
    sidToLogout = session['sid']
    session.pop('user', None)
    session.pop('sid', None)
    return redirect('/')

if __name__ == '__main__':
    app.run(debug=True)
