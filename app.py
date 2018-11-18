from flask import Flask, render_template
from flask_sqlalchemy import SQLAlchemy
import pymysql

app = Flask(__name__)

app.config['SQLALCHEMY_DATABASE_URI'] = 'mysql+pymysql://sklep:sklep@localhost:3306/sklep_rowerowy'
app.config['SQLALCHEMY_ECHO'] = True

db = SQLAlchemy(app)

from model import model_
app.register_blueprint(model_)
from model import Kategoria, Produkt, RodzajRoweru, Marka, Rower

@app.route('/')
def index():
    return render_template('index.html')

@app.route('/login')
def login():
    return render_template('login.html')

@app.route('/register')
def register():
    return render_template('register.html')

@app.route('/bikes')
def bikes():
    # To zapytanie nie musi być takie długie ale chyba poprawnie wyciąga wszystkie dane o produkcie z bazy
    bikes = Produkt.query.join(Rower, Produkt.rower_id==Rower.id).join(RodzajRoweru, Rower.rodzaj_roweru_id==RodzajRoweru.id).join(Marka, Rower.marka_id==Marka.id).all()
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

# do testowania czy poprawnie wyświetla
@app.route('/userCreated')
def userCreated():
    return render_template('userCreated.html')

@app.route('/product_template')
def product_template():
    return render_template('product_template.html')

if __name__ == '__main__':
    app.run(debug=True)
