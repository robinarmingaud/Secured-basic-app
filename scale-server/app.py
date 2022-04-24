from flask import Flask, jsonify, request
from werkzeug.security import check_password_hash
from database.database import db, init_database
import database.models as models

app = Flask(__name__)
app.config["SQLALCHEMY_DATABASE_URI"] = "sqlite:///database/database.db"
app.config["SQLALCHEMY_TRACK_MODIFICATIONS"] = False
db.init_app(app)
with app.app_context():
    init_database()
    models.populate_database()


@app.route('/')
def hello_world():
    return login()


@app.route('/login', methods=['POST'])
def login():
    username = request.args.get('username')
    password = request.args.get('password')
    user = models.User.query.filter_by(username=username).first()

    # check if the user actually exists
    # take the user-supplied password, hash it, and compare it to the hashed password in the database
    if not user or not check_password_hash(user.password, password):
        return "authentication error: try again"
    # if the above check passes, then we know the user has the right credentials
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


'''
@app.route('/for_tests')
def populate():
    db.drop_all()
    db.create_all()
    models.populate_database()
    users = models.User.query.all()
    data=[]
    for user in users:
        data.append({
            "firstname": user.firstname,
            "lastname": user.lastname,
            "picture": user.picture,
            "biography": user.biography
        })

    return jsonify(data)
'''


if __name__ == '__main__':
    app.run(host='0.0.0.0', port=443 ,ssl_context=('cert.pem', 'key.pem'))
