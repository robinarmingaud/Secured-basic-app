
from flask_login import UserMixin
from werkzeug.security import generate_password_hash

from database.database import db

class User(UserMixin, db.Model):
    """
    :param str email: email address of user
    :param str password: encrypted password for the user

    """
    __tablename__ = 'user'
    id = db.Column(db.Integer,primary_key=True)
    username = db.Column(db.String)
    password = db.Column(db.String) # as a sha256
    lastname = db.Column(db.String)
    firstname = db.Column(db.String)
    picture = db.Column(db.String, default="")
    biography = db.Column(db.String, default="")

def populate_database():
    user = User(
        id=1,
        username="test",
        password=generate_password_hash("a", method='sha256'),
        lastname="Bidule",
        firstname="Machin",
        picture="https://fr.web.img6.acsta.net/pictures/16/05/12/17/04/136865.jpg",
        biography="mon mot de passe c'est a"
    )
    db.session.add(user)
    user2 = User(
        id=2,
        username="Brad",
        password=generate_password_hash("a", method='sha256'),
        lastname="Pitt",
        firstname="Brad",
        picture="https://media.gqmagazine.fr/photos/6082bd46e24bc2c55a7e1c4f/1:1/w_120",
        biography="William Bradley Pitt (born December 18, 1963) is an American actor and film producer."
    )
    db.session.add(user2)
    user3 = User(
        id=3,
        username="George",
        password=generate_password_hash("a", method='sha256'),
        lastname="Clooney",
        firstname="George",
        picture="https://fr.web.img6.acsta.net/pictures/16/05/12/17/04/136865.jpg",
        biography="George Timothy Clooney (born May 6, 1961) is an American actor and filmmaker. He is the recipient of numerous accolades, including a British Academy Film Award, four Golden Globe Awards, and two Academy Awards, one for his acting and the other as a producer."
    )
    db.session.add(user3)
    db.session.commit()