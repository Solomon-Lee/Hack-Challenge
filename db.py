import datetime
import hashlib
import os

import bcrypt
from flask_sqlalchemy import SQLAlchemy

db = SQLAlchemy()

class User(db.Model):
    """
    User model
    """
    __tablename__ = "user"
    id = db.Column(db.Integer, primary_key=True, autoincrement=True)

    # User information
    email = db.Column(db.String, nullable=False, unique=True)
    first_name = db.Column(db.String, nullable=False)
    last_name = db.Column(db.String, nullable=False)
    phone = db.Column(db.String, nullable=False)
    password_digest = db.Column(db.String)

    # Google OAuth information
    google_id = db.Column(db.String, unique=True)
    access_token = db.Column(db.String)
    refresh_token = db.Column(db.String)

    # Session information
    session_token = db.Column(db.String, nullable=False, unique=True)
    session_expiration = db.Column(db.DateTime, nullable=False)
    update_token = db.Column(db.String, nullable=False, unique=True)

    # Relationships
    pets = db.relationship("Pets", backref="user")

    def __init__(self, **kwargs):
        """
        Initializes a User object
        """
        self.email = kwargs.get("email")
        if "password" in kwargs:
            self.password_digest = bcrypt.hashpw(kwargs.get("password").encode("utf8"), bcrypt.gensalt(rounds=13))
        self.first_name = kwargs.get("first_name")
        self.last_name = kwargs.get("last_name")
        self.phone = kwargs.get("phone")
        self.google_id = kwargs.get("google_id")
        self.access_token = kwargs.get("access_token")
        self.refresh_token = kwargs.get("refresh_token")
        self.renew_session()

    def serialize(self):
        """
        Serializes a User object into a dictionary
        """
        return {
            "id": self.id,
            "email": self.email,
            "first_name": self.first_name,
            "last_name": self.last_name,
            "phone": self.phone,
            "google_id": self.google_id,
            "access_token": self.access_token,
            "refresh_token": self.refresh_token,
            "pets": [p.simple_serialize() for p in self.pets],
        }

    def simple_serialize(self):
        """
        Serializes a User object into a dictionary without other objects
        """
        return {
            "id": self.id,
            "email": self.email,
            "first_name": self.first_name,
            "last_name": self.last_name,
            "phone": self.phone,
            "google_id": self.google_id,
            "access_token": self.access_token,
            "refresh_token": self.refresh_token,
        }

    def _urlsafe_base_64(self):
        """
        Randomly generates hashed tokens (used for session/update tokens)
        """
        return hashlib.sha1(os.urandom(64)).hexdigest()

    def renew_session(self):
        """
        Renews the sessions, i.e.
        1. Creates a new session token
        2. Sets the expiration time of the session to be a day from now
        3. Creates a new update token
        """
        self.session_token = self._urlsafe_base_64()
        self.session_expiration = datetime.datetime.now() + datetime.timedelta(days=1)
        self.update_token = self._urlsafe_base_64()

    def verify_password(self, password):
        """
        Verifies the password of a user
        """
        if self.password_digest is None:
            return False
        return bcrypt.checkpw(password.encode("utf8"), self.password_digest)


    def verify_session_token(self, session_token):
        """
        Verifies the session token of a user
        """
        return session_token == self.session_token and datetime.datetime.now() < self.session_expiration

    def verify_update_token(self, update_token):
        """
        Verifies the update token of a user
        """
        return update_token == self.update_token
    

class Pets(db.Model):
    """
    Pets model
    """

    __tablename__ = 'pets'
    id = db.Column(db.Integer, primary_key=True, autoincrement=True)
    name = db.Column(db.String, nullable=False)
    age = db.Column(db.Integer, nullable=False)
    species = db.Column(db.String, nullable=False)
    breed = db.Column(db.String, nullable=False)
    color = db.Column(db.String, nullable=False)
    medical_conditions = db.Column(db.String, nullable=False)

    #Define relationship to user
    user_id = db.Column(db.Integer, db.ForeignKey('user.id'), nullable=False)


    def __init__(self, **kwargs):
        """
        Initialize Pets Object
        """
        self.name = kwargs.get('name')
        self.age = kwargs.get('age')
        self.species = kwargs.get('species')
        self.breed = kwargs.get('breed')
        self.color = kwargs.get('color')
        self.medical_conditions = kwargs.get('medical_conditions')

    def serialize(self):
        """
        Serializes a user object
        """

        return {
            "id": self.id,
            "name": self.name,
            "age": self.age,
            "species": self.species,
            "breed": self.breed,
            "color": self.color,
            "medical_conditions": self.medical_conditions,
            "user_id": self.user_id
        }
    
    def simple_serialize(self):
        """
        Serializes a pets object without user
        """

        return {
            "id": self.id,
            "name": self.name,
            "age": self.age,
            "species": self.species,
            "breed": self.breed,
            "color": self.color,
            "medical_conditions": self.medical_conditions
        }
