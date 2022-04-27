import os
from flask_login import current_user, login_user, LoginManager,login_required,logout_user
from flask import Flask, jsonify, request
from werkzeug.security import check_password_hash
from database.database import db, init_database
import database.models as models

app = Flask(__name__)
login = LoginManager(app)

# Setup the secret key and the environment 
app.config.update(SECRET_KEY=str(os.urandom(64)),
                  ENV='development')

app.config["SQLALCHEMY_DATABASE_URI"] = "sqlite:///database/database.db"
app.config["SQLALCHEMY_TRACK_MODIFICATIONS"] = False
db.init_app(app)
with app.app_context():
    init_database()
    models.populate_database()

@login.user_loader
def load_user(id):
    return User.query.get(int(id))

@app.route('/')
def hello_world():
    return login()


@app.route('/login', methods=['POST'])
def login():

    if current_user.is_authenticated : 
        return jsonify({
            "firstname": current_user.firstname,
            "lastname": current_user.lastname,
            "picture": current_user.picture,
            "biography": current_user.biography
        })

    json = request.get_json()
    username = json['username']
    password = json['password']
    user = models.User.query.filter_by(username=username).first()

    # check if the user actually exists
    # take the user-supplied password, hash it, and compare it to the hashed password in the database
    if not user or not check_password_hash(user.password, password):
        return "authentication error: try again"
    # if the above check passes, then we know the user has the right credentials
    elif user and check_password_hash(user.password,password):
        login_user(user, remember=True)
        return jsonify({
            "firstname": user.firstname,
            "lastname": user.lastname,
            "picture": user.picture,
            "biography": user.biography
        })

@app.route('/directory_page', methods=['POST'])
@login_required
def directory_page():
    json = request.get_json()
    users = models.User.query.all()
    data = []
    for user in users:
        data.append({
            "firstname": user.firstname,
            "lastname": user.lastname,
            "picture": user.picture,
            "biography": user.biography
        })
    return jsonify(data)

@login_required
@app.route('/logout')
def logout():
    logout_user()
    return "Logout"



port = int(os.environ.get("PORT", 5000)) # <-----
app.run(host='0.0.0.0', port=port)
if __name__ == '__main__':
    app.run(host='0.0.0.0',port=port)
