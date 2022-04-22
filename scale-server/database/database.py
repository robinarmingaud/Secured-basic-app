from flask_sqlalchemy import SQLAlchemy

db = SQLAlchemy()



def init_database():
    db.drop_all()
    db.create_all()


