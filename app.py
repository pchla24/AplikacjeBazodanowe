from flask import Flask, render_template
from model import model_
from flask_sqlalchemy import SQLAlchemy
import pymysql
from model import Kategoria, Produkt, RodzajRoweru, Marka, Rower

app = Flask(__name__)
app.register_blueprint(model_)

app.config['SQLALCHEMY_DATABASE_URI'] = 'mysql+pymysql://sklep:sklep@localhost:3306/sklep_rowerowy'
app.config['SQLALCHEMY_ECHO'] = True

db = SQLAlchemy(app)

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
    # Tu wywala ze Kategoria nie ma atrybutu query
    testList = Kategoria.query.all()
    #bikes = Produkt.query.join(Rower, Produkt.rower_id==Rower.id).join(RodzajRoweru, Rower.rodzaj_roweru_id==RodzajRoweru.id).join(Marka, Rower.marka_id==Marka.id).all()
    return render_template('category_template.html', productList=testList)

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
