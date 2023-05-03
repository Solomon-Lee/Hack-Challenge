import datetime
import hashlib
import os
import base64
import io
from io import BytesIO
import boto3
from mimetypes import guess_extension, guess_type
from PIL import Image
import random
import re
import string

import bcrypt
from flask_sqlalchemy import SQLAlchemy

db = SQLAlchemy()

user_roles = db.Table("user_roles",
    db.Column("user_id", db.Integer, db.ForeignKey("users.id"), primary_key=True),
    db.Column("role_id", db.Integer, db.ForeignKey("roles.id"), primary_key=True)
)

EXTENSIONS = ["jpg", "jpeg", "png", "gif"]
BASE_DIR = os.getcwd()
S3_BUCKET_NAME = os.environ.get("S3_BUCKET_NAME")
S3_BASE_URL = f"https://{S3_BUCKET}.s3.us-east-1.amazonaws.com"

class Asset(db.Model):
    """
    Asset model
    """
    __tablename__ = "assets"
    id = db.Column(db.Integer, primary_key=True, autoincrement=True)
    base_url = db.Column(db.String, nullable=True)
    salt = db.Column(db.String, nullable=True)
    extension = db.Column(db.String, nullable=True)
    width = db.Column(db.Integer, nullable=True)
    height = db.Column(db.Integer, nullable=True)
    created_at = db.Column(db.DateTime, nullable=False)

    def __init__(self, **kwargs):
        """
        Initializes an Asset object
        """
        self.create(kwargs.get("image_data"))
    
    def serialize(self):
        """
        Returns a dictionary representation of an Asset object
        """
        return {
            "base_url": f"{self.base_url}/{self.salt}.{self.extension}",
            "created_at": str(self.created_at)
        }
    
    def create(self, image_data):
        """
        Given an image in base64 form does the following:
            1. Rejects image if not in supported file types
            2. Generates a random string for image filename
            3. Decodes the image and attempts to upload it to AWS
        """

        try:
            ext = guess_extension(guess_type(image_data)[0])[1:]

            #Only accepts supported file extension
            if ext not in EXTENSIONS:
                raise Exception("Extension {ext} not supported")
            
            #Generates a random string for image filename
            salt = "".join(
                random.SystemRandom().choice(
                    string.ascii_uppercase + string.digits
                )

                for _ in range(16)
            )

            #Removes base64 header
            img_str = re.sub("^data:image/.+;base64,", "", image_data)
            img_data = base64.b64decode(img_str)
            img = Image.open(BytesIO(img_data))

            self.base_url = S3_BASE_URL
            self.salt = salt
            self.extension = ext
            self.width = img.width
            self.height = img.height
            self.created_at = datetime.datetime.now()

            img_filename = f"{self.salt}.{self.extension}"
            self.upload(img, img_filename)
        except Exception as e:
            print(f"Error creating asset: {e}")
        
    def upload(self, img, img_filename):
        """
        Uploads image to AWS
        """
        try:
            img_temploc = f"{BASE_DIR}/{img_filename}"
            img.save(img_temploc)

            #upload image to S3
            s3_client = boto3.client("s3")
            s3_client.upload_file(img_temploc, S3_BUCKET_NAME, img_filename)

            #make s3 image url public
            s3_resource = boto3.resource("s3")
            object_acl = s3_resource.ObjectAcl(S3_BUCKET_NAME, img_filename)
            object_acl.put(ACL="public-read")

            #Remove image from server
            os.remove(img_temploc)
        except Exception as e:
            print(f"Error uploading image: {e}")
    



class User(db.Model):
    """
    User model
    """
    __tablename__ = "users"
    id = db.Column(db.Integer, primary_key=True, autoincrement=True)

    # User information
    email = db.Column(db.String, nullable=False, unique=True)
    username = db.Column(db.String, nullable=True, unique=False)
    phone = db.Column(db.String, nullable=True)
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
    sent_messages_from_user = db.relationship("Message", backref="sender_user", lazy=True, foreign_keys="Message.sender_id")
    received_messages_for_user = db.relationship("Message", backref="recipient_user", lazy=True, foreign_keys="Message.recipient_id")

    def __init__(self, **kwargs):
        """
        Initializes a User object
        """
        self.email = kwargs.get("email")
        if "password" in kwargs:
            self.password_digest = bcrypt.hashpw(kwargs.get("password").encode("utf8"), bcrypt.gensalt(rounds=13))
        self.username = kwargs.get("username", None)
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
            "username": self.username,
            "phone": self.phone,
            "gender": self.gender,
            "session_token": self.session_token,
            "update_token": self.update_token,
            "session_expiration": str(self.session_expiration),
            "pets": [p.simple_serialize() for p in self.pets],
            "roles": [r.serialize() for r in self.roles],
            "pet_owner_requests": [r.serialize() for r in self.pet_owner_requests if r.pet_owner_id == self.id],
            "pet_sitter_requests": [r.serialize() for r in self.pet_sitter_requests if r.pet_sitter_id == self.id],
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
            "username": self.username,
            "gender": self.gender,
            "phone": self.phone,
            "session_token": self.session_token,
            "update_token": self.update_token,
            "session_expiration": str(self.session_expiration)
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
    # Request details
    additional_info = db.Column(db.String, nullable=False)
    start_time = db.Column(db.String, nullable=False)
    end_time = db.Column(db.String, nullable=False)


    # Relationships
    pet_owner_id = db.Column(db.Integer, db.ForeignKey("users.id"), nullable=False)
    pet_owner = db.relationship("User", foreign_keys=pet_owner_id)

    pet_sitter_id = db.Column(db.Integer, db.ForeignKey("users.id"), nullable=True)
    pet_sitter = db.relationship("User", foreign_keys=pet_sitter_id)

    pet_id = db.Column(db.Integer, db.ForeignKey("pets.id"), nullable=False)
    pet = db.relationship("Pets")

    def __init__(self, **kwargs):
        """
        Initializes a PetSittingRequest object
        """
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
            "start_time": self.start_time,
            "end_time": self.end_time,
            "additional_info": self.additional_info,
        }
    
    def simple_serialize(self):
        """
        Serializes a PetSittingRequest object into a dictionary without pet and user details
        """
        return {
            "id": self.id,
            "start_time": self.start_time,
            "end_time": self.end_time,
            "additional_info": self.additional_info
        }


class Message(db.Model):
    __tablename__ = "message"
    id = db.Column(db.Integer, primary_key=True, autoincrement=True)

    # Relationships
    sender_id = db.Column(db.Integer, db.ForeignKey("users.id"), nullable=False)
    sender = db.relationship("User", foreign_keys=sender_id, backref="sent_messages")

    recipient_id = db.Column(db.Integer, db.ForeignKey("users.id"), nullable=False)
    recipient = db.relationship("User", foreign_keys=recipient_id, backref="received_messages")

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

