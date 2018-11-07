from flask import Flask, render_template
app = Flask(__name__)

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
    return render_template('category_template.html')

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
