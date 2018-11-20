from flask import Flask, render_template, request, redirect, url_for
from flask_login import LoginManager, login_user
from flask_sqlalchemy import SQLAlchemy
from flask_wtf import FlaskForm
import flask_login
import pymysql
from wtforms import StringField, PasswordField, BooleanField
from wtforms.validators import InputRequired, Length, Email

import model
from model import model_
from werkzeug import generate_password_hash, check_password_hash
app = Flask(__name__)
app.register_blueprint(model_)
app.config['SQLALCHEMY_DATABASE_URI'] = 'mysql+pymysql://sklep:sklep@localhost:3306/sklep_rowerowy'
app.config['SQLALCHEMY_ECHO'] = True
db = SQLAlchemy(app)
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
    print(user)
    if user:
        #print(user.haslo)
        #pas = generate_password_hash(_password)[0:40]
        #print(pas)
        if (_password== user.haslo):
            #print('haslo przeszlo')
            #login_user(user)
            return redirect('/')
    return '<h1>Invalid username or password</h1>'
        #return '<h1>' + form.username.data + ' ' + form.password.data + '</h1>'

  #  return render_template('login.html')

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
    new_user = model.Klient(imie = _imie, nazwisko = _nazwisko , login=_login, email=_email, haslo=_password)
    db.session.add(new_user)
    db.session.commit()
    return redirect('/userCreated')

@app.route('/bikes')
def bikes():
    # To zapytanie nie musi być takie długie ale chyba poprawnie wyciąga wszystkie dane o produkcie z bazy
    bikes = model.Produkt.query.join(model.Rower, model.Produkt.rower_id == model.Rower.id).join(model.RodzajRoweru, model.Rower.rodzaj_roweru_id == model.RodzajRoweru.id).join(model.Marka, model.Rower.marka_id == model.Marka.id).all()
    return render_template('category_template.html', productList=bikes)

@app.route('/frames')
def frames():
    return render_template('category_template.html')

@app.route('/handlebars')
def handlebars():
    return render_template('category_template.html')

@app.route('/saddles')
def saddles():
    return render_template('category_template.html')

@app.route('/wheels')
def wheels():
    return render_template('category_template.html')

@app.route('/tyres')
def tyres():
    return render_template('category_template.html')

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

if __name__ == '__main__':
    app.run(debug=True)
