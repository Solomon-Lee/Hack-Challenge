import datetime
import hashlib
import os

import bcrypt
from flask_sqlalchemy import SQLAlchemy

db = SQLAlchemy()


user_roles = db.Table("user_roles",
    db.Column("user_id", db.Integer, db.ForeignKey("users.id"), primary_key=True),
    db.Column("role_id", db.Integer, db.ForeignKey("roles.id"), primary_key=True)
)

class User(db.Model):
    """
    User model
    """
    __tablename__ = "users"
    id = db.Column(db.Integer, primary_key=True, autoincrement=True)

    # User information
    email = db.Column(db.String, nullable=False, unique=True)
    first_name = db.Column(db.String, nullable=True)
    last_name = db.Column(db.String, nullable=True)
    phone = db.Column(db.String, nullable=False)
    password_digest = db.Column(db.String)
    gender = db.Column(db.String, nullable=True)

    # Google OAuth information
    access_token = db.Column(db.String)
    refresh_token = db.Column(db.String)

    # Session information
    session_token = db.Column(db.String, nullable=False, unique=True)
    session_expiration = db.Column(db.DateTime, nullable=False)
    update_token = db.Column(db.String, nullable=False, unique=True)

    # Relationships
    roles = db.relationship('Role', secondary='user_roles', backref=db.backref('users_roles', lazy=True))
    pets = db.relationship('Pets', backref='owner', lazy=True)
    pet_owner_requests = db.relationship('PetSittingRequest', backref='owner', lazy=True, foreign_keys='PetSittingRequest.pet_owner_id')
    pet_sitter_requests = db.relationship('PetSittingRequest', backref='sitter', lazy=True, foreign_keys='PetSittingRequest.pet_sitter_id')
    sent_messages = db.relationship("Message", backref="sender", lazy=True, foreign_keys="[Message.sender_id]")
    received_messages = db.relationship("Message", backref="recipient", lazy=True, foreign_keys="[Message.recipient_id]")

    def __init__(self, **kwargs):
        """
        Initializes a User object
        """
        self.email = kwargs.get("email")
        if "password" in kwargs:
            self.password_digest = bcrypt.hashpw(kwargs.get("password").encode("utf8"), bcrypt.gensalt(rounds=13))
        self.first_name = kwargs.get("first_name", None)
        self.last_name = kwargs.get("last_name", None)
        self.phone = kwargs.get("phone")
        self.google_user_id = kwargs.get("google_user_id", None)
        self.access_token = kwargs.get("access_token")
        self.refresh_token = kwargs.get("refresh_token")
        self.gender = kwargs.get("gender", None)
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
            "gender": self.gender,
            "google_id": self.google_id,
            "access_token": self.access_token,
            "refresh_token": self.refresh_token,
            "pets": [p.simple_serialize() for p in self.pets],
            "roles": [r.serialize() for r in self.roles],
            "pet_owner_requests": [r.serialize() for r in self.pet_sitting_requests if r.pet_owner_id == self.id],
            "pet_sitter_requests": [r.serialize() for r in self.pet_sitting_requests if r.pet_sitter_id == self.id],
            "sent_messages": [m.serialize() for m in self.sent_messages],
            "received_messages": [m.serialize() for m in self.received_messages]
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
            "gender": self.gender,
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
    
    def has_role(self, role_name):
        """
        Checks if the user has the specified role
        """
        return any(role.name == role_name for role in self.roles)

    

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
    user_id = db.Column(db.Integer, db.ForeignKey('users.id'), nullable=True)

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

class Role(db.Model):
    """
    Role model
    """
    __tablename__ = "roles"
    id = db.Column(db.Integer, primary_key=True, autoincrement=True)
    name = db.Column(db.String, nullable=False, unique=True)
    description = db.Column(db.String, nullable=True)

    #Relationship
    users = db.relationship('User', secondary='user_roles', backref=db.backref('role_users', lazy=True))

    def __init__(self, **kwargs):
        """
        Initializes a Role object
        """
        self.name = kwargs.get("name")
        self.description = kwargs.get("description")

    def serialize(self):
        """
        Serializes a Role object into a dictionary
        """
        return {
            "id": self.id,
            "name": self.name,
            "description": self.description
        }
    
    def simple_serialize(self):
        """
        Serializes a Role object into a dictionary without additional details
        """
        return {
            "id": self.id,
            "name": self.name,
            "description": self.description
        }


class PetSittingRequest(db.Model):
    __tablename__ = "pet_sitting_request"
    id = db.Column(db.Integer, primary_key=True, autoincrement=True)

    # Relationships
    pet_owner_id = db.Column(db.Integer, db.ForeignKey("users.id"), nullable=False)
    pet_owner = db.relationship("User", foreign_keys=[pet_owner_id])

    pet_sitter_id = db.Column(db.Integer, db.ForeignKey("users.id"), nullable=True)
    pet_sitter = db.relationship("User", foreign_keys=[pet_sitter_id])

    pet_id = db.Column(db.Integer, db.ForeignKey("pets.id"), nullable=False)
    pet = db.relationship("Pets")

    # Request details
    start_time = db.Column(db.DateTime, nullable=False)
    end_time = db.Column(db.DateTime, nullable=False)
    additional_info = db.Column(db.String, nullable=True)

    def __init__(self, **kwargs):
        """
        Initializes a PetSittingRequest object
        """
        self.pet_owner_id = kwargs.get("pet_owner_id")
        self.pet_sitter_id = kwargs.get("pet_sitter_id")
        self.pet_id = kwargs.get("pet_id")
        self.start_time = kwargs.get("start_time")
        self.end_time = kwargs.get("end_time")
        self.additional_info = kwargs.get("additional_info")

    def serialize(self):
        """
        Serializes a PetSittingRequest object into a dictionary
        """
        return {
            "id": self.id,
            "pet_owner_id": self.pet_owner_id,
            "pet_sitter_id": self.pet_sitter_id,
            "pet_id": self.pet_id,
            "start_time": self.start_time.isoformat(),
            "end_time": self.end_time.isoformat(),
            "additional_info": self.additional_info,
        }
    
    def simple_serialize(self):
        """
        Serializes a PetSittingRequest object into a dictionary without pet and user details
        """
        return {
            "id": self.id,
            "start_date": self.start_date.isoformat(),
            "end_date": self.end_date.isoformat(),
            "additional_info": self.additional_info
        }


class Message(db.Model):
    __tablename__ = "message"
    id = db.Column(db.Integer, primary_key=True, autoincrement=True)

    # Relationships
    sender_id = db.Column(db.Integer, db.ForeignKey("users.id"), nullable=False)
    sender = db.relationship("User", foreign_keys=[sender_id], backref="sent_messages")

    recipient_id = db.Column(db.Integer, db.ForeignKey("users.id"), nullable=False)
    recipient = db.relationship("User", foreign_keys=[recipient_id], backref="received_messages")

    # Message details
    content = db.Column(db.String, nullable=False)
    timestamp = db.Column(db.DateTime, nullable=False, default=datetime.datetime.utcnow)

    def __init__(self, **kwargs):
        """
        Initializes a Message object
        """
        self.sender_id = kwargs.get("sender_id")
        self.recipient_id = kwargs.get("recipient_id")
        self.content = kwargs.get("content")

    def serialize(self):
        """
        Serializes a Message object into a dictionary
        """
        return {
            "id": self.id,
            "sender_id": self.sender_id,
            "recipient_id": self.recipient_id,
            "content": self.content,
            "timestamp": self.timestamp.isoformat(),
        }
    
    def simple_serialize(self):
        """
        Serializes a Message object into a dictionary without sender and recipient details
        """
        return {
            "id": self.id,
            "content": self.content,
            "timestamp": self.timestamp.isoformat(),
        }

