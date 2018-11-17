from flask import Blueprint, render_template, abort

model_ = Blueprint('model_', __name__)

@model_.route('/bikes', methods=['GET', 'POST'])
def getbikes():
    return render_template()

