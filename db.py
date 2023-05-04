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

EXTENSIONS = ["jpg", "jpeg", "png", "gif"]
BASE_DIR = os.getcwd()
S3_BUCKET_NAME = os.environ.get("S3_BUCKET_NAME")
S3_BASE_URL = f"https://{S3_BUCKET_NAME}.s3.us-east-1.amazonaws.com"

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

    #Relationships
    user_id = db.Column(db.Integer, db.ForeignKey("users.id"), nullable=True)
    pet_sitting_id = db.Column(db.Integer, db.ForeignKey("pet_sitting_request.id"), nullable=True)
    pet_adoption_id = db.Column(db.Integer, db.ForeignKey("pet_adoption_request.id"), nullable=True)

    def __init__(self, **kwargs):
        """
        Initializes an Asset object
        """
        self.create(kwargs.get("image_data"))
        self.user_id = kwargs.get("user_id")
        self.pet_sitting_id = kwargs.get("pet_sitting_id")
        self.pet_adoption_id = kwargs.get("pet_adoption_id")
    
    def serialize(self):
        """
        Returns a dictionary representation of an Asset object
        """
        return {
            "base_url": f"{self.base_url}/{self.salt}.{self.extension}",
            "created_at": str(self.created_at),
            "asset_id": self.id,
            "user_id": self.user_id,
            "pet_sitting_id": self.pet_sitting_id,
            "pet_adoption_id": self.pet_adoption_id
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
    age = db.Column(db.String, nullable=True)
    college_student = db.Column(db.Boolean, nullable=True, default=True)
    curr_location = db.Column(db.String, nullable=True)
    pet_owner_boolean = db.Column(db.Boolean, nullable=True, default=True)

    # Google OAuth information
    access_token = db.Column(db.String)
    refresh_token = db.Column(db.String)

    # Session information
    session_token = db.Column(db.String, nullable=False, unique=True)
    session_expiration = db.Column(db.DateTime, nullable=False)
    update_token = db.Column(db.String, nullable=False, unique=True)

    # Relationships
    pets = db.relationship('Pets', backref='owner', lazy=True)

    pet_owner_sitting_requests = db.relationship('PetSittingRequest', backref='owner_sitter', lazy=True, foreign_keys='PetSittingRequest.pet_owner_id')
    pet_sitter_requests = db.relationship('PetSittingRequest', backref='sitter', lazy=True, foreign_keys='PetSittingRequest.pet_sitter_id')

    pet_owner_adoption_requests = db.relationship('PetAdoptionRequest', backref='owner_adopter', lazy=True, foreign_keys='PetAdoptionRequest.pet_owner_id')
    pet_adopter_requests = db.relationship('PetAdoptionRequest', backref='adopter', lazy=True, foreign_keys='PetAdoptionRequest.pet_adopter_id')

    sent_messages_from_user = db.relationship("Message", backref="sender_user", lazy=True, foreign_keys="Message.sender_id")
    received_messages_for_user = db.relationship("Message", backref="recipient_user", lazy=True, foreign_keys="Message.recipient_id")

    asset = db.relationship("Asset", uselist=False, backref="user")

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
        self.age = kwargs.get("age", None)
        self.college_student = kwargs.get("college_student", True)
        self.curr_location = kwargs.get("curr_location", None)
        self.pet_owner_boolean = kwargs.get("pet_owner_boolean", True)
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
            "age": self.age,
            "college_student": self.college_student,
            "curr_location": self.curr_location,
            "pet_owner_boolean": self.pet_owner_boolean,
            "session_token": self.session_token,
            "update_token": self.update_token,
            "session_expiration": str(self.session_expiration),
            "pets_as_owner": [p.simple_serialize() for p in self.pets],
            "pet_owner_sitting_requests": [r.serialize() for r in self.pet_owner_sitting_requests if r.pet_owner_id == self.id],
            "pet_sitter_requests": [r.serialize() for r in self.pet_sitter_requests if r.pet_sitter_id == self.id],
            "pet_owner_adoption_requests": [r.serialize() for r in self.pet_owner_adoption_requests if r.pet_owner_id == self.id],
            "pet_adopter_requests": [r.serialize() for r in self.pet_adopter_requests if r.pet_adopter_id == self.id],
            "sent_messages": [m.serialize() for m in self.sent_messages],
            "received_messages": [m.serialize() for m in self.received_messages],
            "asset": self.asset.serialize() if self.asset else None
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
            "age": self.age,
            "college_student": self.college_student,
            "curr_location": self.curr_location,
            "pet_owner_boolean": self.pet_owner_boolean,
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
    gender = db.Column(db.String, nullable=False)
    age = db.Column(db.String, nullable=False)
    category = db.Column(db.String, nullable=False)
    breed = db.Column(db.String, nullable=False)

    #Define relationship to user
    user_id = db.Column(db.Integer, db.ForeignKey('users.id'), nullable=True)

    def __init__(self, **kwargs):
        """
        Initialize Pets Object
        """
        self.name = kwargs.get('name')
        self.age = kwargs.get('age')
        self.breed = kwargs.get('breed')
        self.gender = kwargs.get('gender')
        self.category = kwargs.get('category')
        self.user_id = kwargs.get('user_id')


    def serialize(self):
        """
        Serializes a user object
        """

        return {
            "id": self.id,
            "name": self.name,
            "gender": self.gender,
            "age": self.age,
            "breed": self.breed,
            "category": self.category,
            "owner_id": self.user_id
        }
    
    def simple_serialize(self):
        """
        Serializes a pets object without user
        """

        return {
            "id": self.id,
            "name": self.name,
            "gender": self.gender,
            "age": self.age,
            "category": self.category,
            "breed": self.breed,
        }

class PetSittingRequest(db.Model):
    __tablename__ = "pet_sitting_request"
    id = db.Column(db.Integer, primary_key=True, autoincrement=True)
    # Request details
    name = db.Column(db.String, nullable=False)
    age = db.Column(db.String, nullable=False)
    gender = db.Column(db.String, nullable=False)
    category = db.Column(db.String, nullable=False)
    breed = db.Column(db.String, nullable=False)
    on_campus = db.Column(db.Boolean, nullable=False)
    off_campus = db.Column(db.Boolean, nullable=False)
    outside = db.Column(db.Boolean, nullable=False)
    start_time = db.Column(db.String, nullable=False)
    end_time = db.Column(db.String, nullable=False)
    pet_description = db.Column(db.String, nullable=False)
    additional_info = db.Column(db.String, nullable=False)
    food_supplies = db.Column(db.Boolean, nullable=False)
    sitter_pay = db.Column(db.Boolean, nullable=False)
    sitter_housing = db.Column(db.Boolean, nullable=False)

    # Relationships
    pet_owner_id = db.Column(db.Integer, db.ForeignKey("users.id"), nullable=False)
    pet_owner = db.relationship("User", foreign_keys=pet_owner_id)

    pet_sitter_id = db.Column(db.Integer, db.ForeignKey("users.id"), nullable=True)
    pet_sitter = db.relationship("User", foreign_keys=pet_sitter_id)

    asset = db.relationship("Asset", backref="pet_sitting_request_asset", lazy=True)

    def __init__(self, **kwargs):
        """
        Initializes a PetSittingRequest object
        """
        self.pet_id = kwargs.get('pet_id')
        self.name = kwargs.get('name')
        self.age = kwargs.get('age')
        self.gender = kwargs['gender']
        self.category = kwargs.get('category')
        self.breed = kwargs.get('breed')
        self.on_campus = kwargs.get('on_campus')
        self.off_campus = kwargs.get('off_campus')
        self.outside = kwargs.get('outside')
        self.start_time = kwargs.get('start_time')
        self.end_time = kwargs.get('end_time')
        self.pet_description = kwargs.get('pet_description')
        self.additional_info = kwargs.get('additional_info')
        self.food_supplies = kwargs.get('food_supplies')
        self.sitter_pay = kwargs.get('sitter_pay')
        self.sitter_housing = kwargs.get('sitter_housing')
        self.pet_owner_id = kwargs.get('pet_owner_id')
        self.pet_sitter_id = kwargs.get('pet_sitter_id')

    def serialize(self):
        """
        Serializes a PetSittingRequest object into a dictionary
        """
        return {
            "id": self.id,
            "pet_owner_id": self.pet_owner_id,
            "pet_sitter_id": self.pet_sitter_id,
            "name": self.name,
            "age": self.age,
            "gender": self.gender,
            "category": self.category,
            "breed": self.breed,
            "on_campus": self.on_campus,
            "off_campus": self.off_campus,
            "outside": self.outside,
            "start_time": self.start_time,
            "end_time": self.end_time,
            "pet_description": self.pet_description,
            "additional_info": self.additional_info,
            "food_supplies": self.food_supplies,
            "sitter_pay": self.sitter_pay,
            "sitter_housing": self.sitter_housing,
            "assets": [asset.serialize() for asset in self.asset]
        }
    
    def simple_serialize(self):
        """
        Serializes a PetSittingRequest object into a dictionary without pet and user details
        """
        return {
            "id": self.id,
            "name": self.name,
            "age": self.age,
            "gender": self.gender,
            "category": self.category,
            "breed": self.breed,
            "on_campus": self.on_campus,
            "off_campus": self.off_campus,
            "outside": self.outside,
            "start_time": self.start_time,
            "end_time": self.end_time,
            "pet_description": self.pet_description,
            "additional_info": self.additional_info,
            "food_supplies": self.food_supplies,
            "sitter_pay": self.sitter_pay,
            "sitter_housing": self.sitter_housing
        }
    
class PetAdoptionRequest(db.Model):
    __tablename__ = "pet_adoption_request"

    id = db.Column(db.Integer, primary_key=True, autoincrement=True)
    # Request details
    name = db.Column(db.String, nullable=False)
    age = db.Column(db.String, nullable=False)
    gender = db.Column(db.String, nullable=False)
    category = db.Column(db.String, nullable=False)
    breed = db.Column(db.String, nullable=False)
    on_campus = db.Column(db.Boolean, nullable=False)
    off_campus = db.Column(db.Boolean, nullable=False)
    outside = db.Column(db.Boolean, nullable=False)
    end_time = db.Column(db.String, nullable=False)
    pet_description = db.Column(db.String, nullable=False)
    additional_info = db.Column(db.String, nullable=False)
    food_supplies = db.Column(db.Boolean, nullable=False)
    adopter_reward = db.Column(db.Boolean, nullable=False)

    # Relationships
    pet_owner_id = db.Column(db.Integer, db.ForeignKey("users.id"), nullable=False)
    pet_owner = db.relationship("User", foreign_keys=pet_owner_id)

    pet_adopter_id = db.Column(db.Integer, db.ForeignKey("users.id"), nullable=True)
    pet_adopter = db.relationship("User", foreign_keys=pet_adopter_id)

    asset = db.relationship("Asset", backref="pet_adoption_request_asset", lazy=True)

    def __init__(self, **kwargs):
        """
        Initializes a PetAdopterRequest object
        """
        self.pet_id = kwargs.get('pet_id')
        self.name = kwargs.get('name')
        self.age = kwargs.get('age')
        self.gender = kwargs['gender']
        self.category = kwargs.get('category')
        self.breed = kwargs.get('breed')
        self.on_campus = kwargs.get('on_campus')
        self.off_campus = kwargs.get('off_campus')
        self.outside = kwargs.get('outside')
        self.end_time = kwargs.get('end_time')
        self.pet_description = kwargs.get('pet_description')
        self.additional_info = kwargs.get('additional_info')
        self.food_supplies = kwargs.get('food_supplies')
        self.adopter_reward = kwargs.get('adopter_reward')
    
    def serialize(self):
        """
        Serializes a PetAdoptionRequest object into a dictionary
        """
        return {
            "id": self.id,
            "pet_owner_id": self.pet_owner_id,
            "pet_adopter_id": self.pet_adopter_id,
            "name": self.name,
            "age": self.age,
            "gender": self.gender,
            "category": self.category,
            "breed": self.breed,
            "on_campus": self.on_campus,
            "off_campus": self.off_campus,
            "outside": self.outside,
            "end_time": self.end_time,
            "pet_description": self.pet_description,
            "additional_info": self.additional_info,
            "food_supplies": self.food_supplies,
            "adopter_reward": self.adopter_reward,
            "assets": [asset.serialize() for asset in self.asset]
        }
    
    def simple_serialize(self):
        """
        Serializes a PetAdoptionRequest object into a dictionary without pet and user details
        """
        return {
            "id": self.id,
            "name": self.name,
            "age": self.age,
            "gender": self.gender,
            "category": self.category,
            "breed": self.breed,
            "on_campus": self.on_campus,
            "off_campus": self.off_campus,
            "outside": self.outside,
            "end_time": self.end_time,
            "pet_description": self.pet_description,
            "additional_info": self.additional_info,
            "food_supplies": self.food_supplies,
            "adopter_reward": self.adopter_reward
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