import json

from db import db
from flask import Flask, redirect, request, session, url_for
from google.oauth2 import id_token
from urllib.parse import urlencode
from google.auth.transport import requests
import users_dao
import datetime
import os
from open_ai_helper import generate_ai_response
from db import User, Pets, PetSittingRequest, Message, Asset, PetAdoptionRequest

db_filename = "auth.db"
app = Flask(__name__)

app.config["SQLALCHEMY_DATABASE_URI"] = "sqlite:///%s" % db_filename
app.config["SQLALCHEMY_TRACK_MODIFICATIONS"] = False
app.config["SQLALCHEMY_ECHO"] = True

#Make env file for google shit
app.config['GOOGLE_CLIENT_ID'] = os.environ.get('GOOGLE_CLIENT_ID', None)

db.init_app(app)
with app.app_context():
    db.create_all()

# generalized response formats
def success_response(data, code=200):
    """
    Generalized success response function
    """
    return json.dumps(data), code

def failure_response(message, code=404):
    """
    Generalized failure response function
    """
    return json.dumps({"error": message}), code

def extract_token(request):
    """
    Helper function that extracts the token from the header of a request
    """
    auth_header = request.headers.get("Authorization")
    if auth_header is None:
        return False, json.dumps({"error": "Missing authorization header."})

    bearer_token = auth_header.replace("Bearer", "").strip()
    if not bearer_token:
        return False, json.dumps({"error": "Invalid authorization header."})
    return True, bearer_token

@app.route("/")
def hello_world():
    """
    Endpoint for printing Hello World!
    """
    return "Hello World!"

@app.route("/register/", methods=["POST"])
def register_account():
    """
    Endpoint for registering a new user
    """
    body = json.loads(request.data)
    email = body.get("email")
    password = body.get("password")
    username = body.get("username")
    phone = body.get("phone")

    if email is None or password is None or username is None or phone is None:
        return failure_response("Email, password, username, or phone not provided")
    
    created, user = users_dao.create_user(email, password, username, phone)

    if not created:
        return failure_response("User already exists")
    
    return json.dumps(
        {
            "session_token": user.session_token,
            "update_token": user.update_token,
            "session_expiration": str(user.session_expiration)
        }
    )


@app.route("/login/", methods=["POST"])
def login():
    """
    Endpoint for logging in a user
    """
    body = json.loads(request.data)
    email = body.get("email")
    password = body.get("password")

    if email is None or password is None:
        return failure_response("Email or password not provided")
    
    success, user = users_dao.verify_credentials(email, password)

    if not success:
        return failure_response("Incorrect email or password")
    
    return json.dumps(
        {
            "session_token": user.session_token,
            "update_token": user.update_token,
            "session_expiration": str(user.session_expiration)
        }
    )

@app.route("/session/", methods=["POST"])
def update_session():
    """
    Endpoint for updating a user's session
    """
    success, session_token = extract_token(request)

    if not success:
        return session_token
    
    user = users_dao.renew_session(session_token)

    if user is None:
        return failure_response("Invalid session token")
    
    return json.dumps(
        {
            "session_token": user.session_token,
            "update_token": user.update_token,
            "session_expiration": str(user.session_expiration)
        }
    )

@app.route("/secret/", methods=["GET"])
def secret_message():
    """
    Endpoint for verifying a session token and returning a secret message

    In your project, you will use the same logic for any endpoint that needs 
    authentication
    """
    success, session_token = extract_token(request)

    if not success:
        return session_token
    
    user = users_dao.get_user_by_session_token(session_token)

    if user is None or not user.verify_session_token(session_token):
        return failure_response("Invalid session token")
    
    return success_response({"message": "You have successfully implemented sessions!"})

@app.route("/logout/", methods=["POST"])
def logout():
    """
    Endpoint for logging out a user
    """
    success, session_token = extract_token(request)

    if not success:
        return session_token
    
    user = users_dao.get_user_by_session_token(session_token)

    if user is None or not user.verify_session_token(session_token):
        return failure_response("Invalid session token")
    
    user.session_expiration = datetime.datetime.now()
    db.session.commit()

    return success_response({"message": "You have successfully logged out!"})

@app.route("/google_login/", methods=["POST"])
def google_login():
    token = request.json.get("id_token")

    if not token:
        return failure_response("Missing id_token")

    try:
        idinfo = id_token.verify_oauth2_token(token, requests.Request(), app.config["GOOGLE_CLIENT_ID"])

        if idinfo["iss"] not in ["accounts.google.com", "https://accounts.google.com"]:
            raise ValueError("Wrong issuer.")

        google_user_id = idinfo["sub"]

    except ValueError:
        return failure_response("Invalid id_token")

    user = users_dao.get_user_by_google_id(google_user_id)

    if not user:
        email = idinfo["email"]
        first_name = idinfo["given_name"]
        last_name = idinfo["family_name"]

        user = users_dao.create_user_with_google_id(google_user_id, email, first_name, last_name)

    return json.dumps(
        {
            "session_token": user.session_token,
            "update_token": user.update_token,
            "session_expiration": str(user.session_expiration)
        }
    )

#User endpoints
@app.route("/user", methods=["GET"])
def get_user():
    """
    Endpoint for getting a user's information
    """
    success, session_token = extract_token(request)

    if not success:
        return session_token
    
    user = users_dao.get_user_by_session_token(session_token)

    if user is None or not user.verify_session_token(session_token):
        return failure_response("Invalid session token")
    
    return success_response(user.serialize())

@app.route("/all_users/", methods=["GET"])
def get_all_users():
    """
    Endpoint for getting all users
    """
    users = [user.serialize() for user in users_dao.get_all_users()]
    return success_response({"users": users})

@app.route("/user", methods=["PUT"])
def update_user():
    """
    Endpoint for updating a user
    """
    success, session_token = extract_token(request)

    if not success:
        return session_token
    
    user = users_dao.get_user_by_session_token(session_token)
    if user is None:
        return failure_response("User not found!")

    data = request.get_json()
    if "phone" in data:
        user.phone = data["phone"]
    if "gender" in data:
        user.gender = data["gender"]
    if "age" in data:
        user.age = data["age"]
    if "curr_location" in data:
        user.curr_location = data["curr_location"]
    if "college_student" in data:
        user.college_student = data["college_student"]
    if "pet_owner_boolean" in data:
        user.pet_owner_boolean = data["pet_owner_boolean"]

    db.session.commit()
    return success_response(user.serialize())

@app.route("/user", methods=["DELETE"])
def delete_user():
    """
    Endpoint for deleting a user
    """

    success, session_token = extract_token(request)

    if not success:
        return session_token

    user = users_dao.get_user_by_session_token(session_token)
    if user is None:
        return failure_response("User not found!")
    
    db.session.delete(user)
    db.session.commit()
    return success_response(user.serialize())

#Pets endpoints
@app.route("/pets/", methods=["GET"])
def get_pets():
    """Endpoint for getting all pets"""

    pets = [pet.simple_serialize() for pet in Pets.query.all()]
    return success_response({"pets": pets})

@app.route("/pet/<int:pet_id>/")
def get_pet_by_id(pet_id):
    """Endpoint for getting a pet with id"""
    pet = Pets.query.filter_by(id = pet_id).first()
    if pet is None:
        return failure_response("User not found!")
    return success_response(pet.simple_serialize())

@app.route("/user/pet/", methods = ["POST"])
def create_pet():
    body = json.loads(request.data)
    name = body.get("name")
    age = body.get("age")
    gender = body.get('gender')
    breed = body.get('breed')
    category = body.get('category')

    success, session_token = extract_token(request)

    if not success:
        return session_token
    
    user = users_dao.get_user_by_session_token(session_token)
    if user is None:
        return failure_response("User not found!")
    if name is None or age is None or gender is None or breed is None or category is None:
        return failure_response("Missing necessary information!")
    
    pet = Pets(name = name, age = age, gender = gender, breed=breed, category=category)

    user.pets.append(pet)
    db.session.add(pet)
    db.session.commit()
    return success_response(pet.serialize(), 201)

@app.route("/pet/<int:pet_id>", methods = ["DELETE"])
def delete_pet(pet_id):
    """
    Endpoint for deleting a pet with pet_id
    """
    pet = Pets.query.filter_by(id= pet_id).first()
    if pet is None:
        return failure_response("Pet not found!")
    db.session.delete(pet)
    db.session.commit()
    return success_response(pet.serialize())

@app.route("/user/pets/", methods = ["GET"])
def get_user_pets():
    """
    Endpoint for getting all pets of a user
    """
    success, session_token = extract_token(request)

    if not success:
        return session_token
    
    user = users_dao.get_user_by_session_token(session_token)
    if user is None:
        return failure_response("User not found!")
    pets = [pet.serialize() for pet in user.pets]
    return success_response({"pets": pets})

@app.route("/user/pet/<int:pet_id>/", methods = ["DELETE"])
def remove_pet_from_user(pet_id):
    """
    Endpoint for removing a pet from a user
    """

    success, session_token = extract_token(request)

    if not success:
        return session_token
    
    user = users_dao.get_user_by_session_token(session_token)
    if user is None:
        return failure_response("User not found!")
    pet = Pets.query.filter_by(id = pet_id).first()
    if pet is None:
        return failure_response("Pet not found!")
    user.pets.remove(pet)
    db.session.commit()
    return success_response(pet.simple_serialize())

@app.route("/pet/<int:pet_id>/", methods = ["PUT"])
def update_pet(pet_id):
    """
    Endpoint for updating a pet
    """
    pet = Pets.query.filter_by(id = pet_id).first()
    if pet is None:
        return failure_response("Pet not found!")
    data = request.get_json()
    if "name" in data:
        pet.name = data["name"]
    if "age" in data:
        pet.age = data["age"]
    if "gender" in data:
        pet.gender = data["gender"]
    if "breed" in data:
        pet.breed = data["breed"]
    if "category" in data:
        pet.category = data["category"]
    db.session.commit()
    return success_response(pet.simple_serialize())

#Pet Sitting Request endpoints
@app.route("/user/pet_sitting_request/", methods = ["POST"])
def create_pet_sitting_request():
    """
    Endpoint for creating a pet sitting request
    """
    body = json.loads(request.data)
    name = body.get("name")
    age = body.get("age")
    gender = body.get("gender")
    breed = body.get("breed")
    category = body.get("category")
    on_campus = body.get("on_campus")
    off_campus = body.get("off_campus")
    outside = body.get("outside")
    start_time = body.get("start_time")
    end_time = body.get("end_time")
    additional_info = body.get("additional_info")
    pet_description = body.get("pet_description")
    food_supplies = body.get("food_supplies")
    sitter_pay = body.get("sitter_pay")
    sitter_housing = body.get("sitter_housing")

    success, session_token = extract_token(request)

    if not success:
        return session_token
    
    user = users_dao.get_user_by_session_token(session_token)

    if user is None:
        return failure_response("User not found!")
    pet_sitting_request = PetSittingRequest(name=name,age=age,gender=gender,breed=breed,category=category,on_campus=on_campus, 
                                            off_campus=off_campus, outside=outside, start_time=start_time, end_time=end_time, 
                                            additional_info=additional_info, pet_description=pet_description, food_supplies=food_supplies, 
                                            sitter_pay=sitter_pay, sitter_housing=sitter_housing)
    user.pet_owner_sitting_requests.append(pet_sitting_request)
    db.session.add(pet_sitting_request)
    db.session.commit()
    return success_response(pet_sitting_request.serialize(), 201)

@app.route("/user/pet_sitting_request/<int:pet_sitting_request_id>/", methods = ["POST"])
def add_user_as_pet_sitter(pet_sitting_request_id):
    """
    Endpoint for adding a pet sitter to a pet sitting request
    """
    success, session_token = extract_token(request)

    if not success:
        return session_token
    
    user = users_dao.get_user_by_session_token(session_token)
    pet_sitting_request = PetSittingRequest.query.filter_by(id = pet_sitting_request_id).first()
    if user is None:
        return failure_response("User not found!")
    if pet_sitting_request is None:
        return failure_response("Pet sitting request not found!")
    pet_sitting_request.pet_sitter_id = user.id
    user.pet_owner_sitting_requests.append(pet_sitting_request)
    db.session.commit()
    return success_response(pet_sitting_request.serialize(), 201)

@app.route("/pet_sitting_request/<int:pet_sitting_request_id>/", methods = ["DELETE"])
def delete_pet_sitting_request(pet_sitting_request_id):
    """
    Endpoint for deleting a pet sitting request
    """
    pet_sitting_request = PetSittingRequest.query.filter_by(id = pet_sitting_request_id).first()
    if pet_sitting_request is None:
        return failure_response("Pet sitting request not found!")
    db.session.delete(pet_sitting_request)
    db.session.commit()
    return success_response(pet_sitting_request.serialize(), 202)

@app.route("/pet_sitting_request/<int:pet_sitting_request_id>/", methods = ["PUT"])
def update_pet_sitting_request(pet_sitting_request_id):
    """
    Endpoint for updating a pet sitting request
    """
    pet_sitting_request = PetSittingRequest.query.filter_by(id = pet_sitting_request_id).first()
    if pet_sitting_request is None:
        return failure_response("Pet sitting request not found!")
    data = request.get_json()
    if "name" in data:
        pet_sitting_request.name = data["name"]
    if "age" in data:
        pet_sitting_request.age = data["age"]
    if "gender" in data:
        pet_sitting_request.gender = data["gender"]
    if "category" in data:
        pet_sitting_request.category = data["category"]
    if "breed" in data:
        pet_sitting_request.breed = data["breed"]
    if "on_campus" in data:
        pet_sitting_request.on_campus = data["on_campus"]
    if "off_campus" in data:
        pet_sitting_request.off_campus = data["off_campus"]
    if "outside" in data:
        pet_sitting_request.outside = data["outside"]
    if "start_time" in data:
        pet_sitting_request.start_time = data["start_time"]
    if "end_time" in data:
        pet_sitting_request.end_time = data["end_time"]
    if "additional_info" in data:
        pet_sitting_request.additional_info = data["additional_info"]
    if "pet_description" in data:
        pet_sitting_request.pet_description = data["pet_description"]
    if "food_supplies" in data:
        pet_sitting_request.food_supplies = data["food_supplies"]
    if "sitter_pay" in data:
        pet_sitting_request.sitter_pay = data["sitter_pay"]
    if "sitter_housing" in data:
        pet_sitting_request.sitter_housing = data["sitter_housing"]
    db.session.commit()
    return success_response(pet_sitting_request.serialize(), 200)

@app.route("/pet_sitting_request")
def get_all_pet_sitting_requests():
    """
    Endpoint for getting all pet sitting requests
    """
    pet_sitting_requests = [pet_sitting_request.serialize() for pet_sitting_request in PetSittingRequest.query.all()]
    return success_response({"pet_sitting_requests": pet_sitting_requests})

@app.route("/pet_sitting_request/<int:pet_sitting_request_id>/", methods = ["GET"])
def get_pet_sitting_request_by_id(pet_sitting_request_id):
    """
    Endpoint for getting a pet sitting request
    """
    pet_sitting_request = PetSittingRequest.query.filter_by(id = pet_sitting_request_id).first()
    if pet_sitting_request is None:
        return failure_response("Pet sitting request not found!")
    return success_response(pet_sitting_request.serialize())

@app.route("/user/pet_sitting_requests/", methods=["GET"])
def get_user_pet_sitting_requests():
    """
    Endpoint for getting all pet sitting requests of a user
    """

    success, session_token = extract_token(request)

    if not success:
        return session_token
    
    user = users_dao.get_user_by_session_token(session_token)
    if user is None:
        return failure_response("User not found!")
    pet_owner_sitting_requests = [r.serialize() for r in user.pet_owner_requests]
    pet_sitter_requests = [r.serialize() for r in user.pet_sitter_requests]
    return success_response({
        "pet_owner_sitting_requests": pet_owner_sitting_requests,
        "pet_sitter_requests": pet_sitter_requests
    })

#Pet Adoption Endpoints
@app.route("/user/pet_adoption_request/", methods = ["POST"])
def create_pet_adoption_request():
    """
    Endpoint for creating a pet sitting request
    """
    body = json.loads(request.data)
    name = body.get("name")
    age = body.get("age")
    gender = body.get("gender")
    breed = body.get("breed")
    category = body.get("category")
    on_campus = body.get("on_campus")
    off_campus = body.get("off_campus")
    outside = body.get("outside")
    end_time = body.get("end_time")
    additional_info = body.get("additional_info")
    pet_description = body.get("pet_description")
    food_supplies = body.get("food_supplies")
    adopter_reward = body.get("adopter_reward")

    success, session_token = extract_token(request)

    if not success:
        return session_token
    
    user = users_dao.get_user_by_session_token(session_token)

    if user is None:
        return failure_response("User not found!")
    pet_adoption_request = PetAdoptionRequest(name=name,age=age,gender=gender,breed=breed,category=category,on_campus=on_campus, 
                                            off_campus=off_campus, outside=outside, end_time=end_time, 
                                            additional_info=additional_info, pet_description=pet_description, food_supplies=food_supplies, 
                                            adopter_reward=adopter_reward)
    user.pet_owner_adoption_requests.append(pet_adoption_request)
    db.session.add(pet_adoption_request)
    db.session.commit()
    return success_response(pet_adoption_request.serialize(), 201)

@app.route("/user/pet_adoption_request/<int:pet_adoption_request_id>/", methods = ["POST"])
def add_user_as_pet_adopter(pet_adoption_request_id):
    """
    Endpoint for adding a pet sitter to a pet sitting request
    """
    success, session_token = extract_token(request)

    if not success:
        return session_token
    
    user = users_dao.get_user_by_session_token(session_token)
    pet_adoption_request = PetAdoptionRequest.query.filter_by(id = pet_adoption_request_id).first()
    if user is None:
        return failure_response("User not found!")
    if pet_adoption_request is None:
        return failure_response("Pet sitting request not found!")
    
    pet_adoption_request.pet_adopter_id = user.id
    user.pet_adopter_requests.append(pet_adoption_request)
    db.session.commit()
    return success_response(pet_adoption_request.serialize(), 201)

@app.route("/pet_adoption_request/<int:pet_adoption_request_id>/", methods = ["DELETE"])
def delete_pet_adoption_request(pet_adoption_request_id):
    """
    Endpoint for deleting a pet sitting request
    """
    pet_adoption_request = PetAdoptionRequest.query.filter_by(id = pet_adoption_request_id).first()
    if pet_adoption_request is None:
        return failure_response("Pet Adoption request not found!")
    db.session.delete(pet_adoption_request)
    db.session.commit()
    return success_response(pet_adoption_request.serialize(), 202)

@app.route("/pet_adoption_request/<int:pet_adoption_request_id>/", methods = ["PUT"])
def update_pet_adoption_request(pet_adoption_request_id):
    """
    Endpoint for updating a pet sitting request
    """
    pet_adoption_request = PetAdoptionRequest.query.filter_by(id = pet_adoption_request_id).first()
    if pet_adoption_request is None:
        return failure_response("Pet Adoption request not found!")
    data = request.get_json()
    if "name" in data:
        pet_adoption_request.name = data["name"]
    if "age" in data:
        pet_adoption_request.age = data["age"]
    if "gender" in data:
        pet_adoption_request.gender = data["gender"]
    if "category" in data:
        pet_adoption_request.category = data["category"]
    if "breed" in data:
        pet_adoption_request.breed = data["breed"]
    if "on_campus" in data:
        pet_adoption_request.on_campus = data["on_campus"]
    if "off_campus" in data:
        pet_adoption_request.off_campus = data["off_campus"]
    if "outside" in data:
        pet_adoption_request.outside = data["outside"]
    if "end_time" in data:
        pet_adoption_request.end_time = data["end_time"]
    if "additional_info" in data:
        pet_adoption_request.additional_info = data["additional_info"]
    if "pet_description" in data:
        pet_adoption_request.pet_description = data["pet_description"]
    if "food_supplies" in data:
        pet_adoption_request.food_supplies = data["food_supplies"]
    if "adopter_reward" in data:
        pet_adoption_request.adopter_reward = data["adopter_reward"]
    db.session.commit()
    return success_response(pet_adoption_request.serialize(), 200)

@app.route("/pet_adoption_request")
def get_all_pet_adoption_requests():
    """
    Endpoint for getting all pet sitting requests
    """
    pet_adoption_request = [pet_adoption_request.serialize() for pet_adoption_request in PetAdoptionRequest.query.all()]
    return success_response({"pet_adoption_requests": pet_adoption_request})

@app.route("/pet_adoption_request/<int:pet_adoption_request_id>/", methods = ["GET"])
def get_pet_adoption_request_by_id(pet_adoption_request_id):
    """
    Endpoint for getting a pet sitting request
    """
    pet_adoption_request = PetAdoptionRequest.query.filter_by(id = pet_adoption_request_id).first()
    if pet_adoption_request is None:
        return failure_response("Pet sitting request not found!")
    return success_response(pet_adoption_request.serialize())

@app.route("/user/pet_adoption_request/", methods=["GET"])
def get_user_pet_adoption_request():
    """
    Endpoint for getting all pet sitting requests of a user
    """

    success, session_token = extract_token(request)

    if not success:
        return session_token
    
    user = users_dao.get_user_by_session_token(session_token)
    if user is None:
        return failure_response("User not found!")
    pet_owner_requests = [r.serialize() for r in user.pet_owner_adoption_requests]
    pet_adopter_requests = [r.serialize() for r in user.pet_adopter_requests]
    return success_response({
        "pet_owner_adoption_requests": pet_owner_requests,
        "pet_adoption_request": pet_adopter_requests
    })

#Message endpoints
@app.route("/messages/", methods=["GET"])
def get_all_messages():
    """
    Endpoint for getting all messages
    """
    messages = Message.query.all()
    serialized_messages = [m.serialize() for m in messages]
    return success_response({"messages": serialized_messages})

@app.route("/message/<int:message_id>/", methods=["GET"])
def get_message_by_id(message_id):
    """
    Endpoint for getting a message
    """
    message = Message.query.filter_by(id=message_id).first()
    if message is None:
        return failure_response("Message not found!")
    return success_response(message.serialize())

@app.route("/message/<int:message_id>/", methods=["DELETE"])
def delete_message(message_id):
    """
    Endpoint for deleting a message
    """
    message = Message.query.filter_by(id=message_id).first()
    if message is None:
        return failure_response("Message not found!")
    db.session.delete(message)
    db.session.commit()
    return success_response(message.serialize())

@app.route("/message/<string:sender_email>", methods=["POST"])
def create_message(sender_email):
    """
    Endpoint for creating a message
    """
    body = json.loads(request.data)
    content = body.get("content")

    success, session_token = extract_token(request)

    if not success:
        return session_token

    recipient = users_dao.get_user_by_session_token(session_token)
    sender = users_dao.get_user_by_email(sender_email)
    if sender is None or recipient is None:
        return failure_response("Recipient not found!")
    new_message = Message(content=content, sender_id=sender.id, recipient_id=recipient.id, timestamp = datetime.datetime.utcnow())
    db.session.add(new_message)
    db.session.commit()
    return success_response(new_message.serialize(), 201)

@app.route("/message/", methods=["GET"])
def get_user_messages():
    """
    Endpoint for getting all messages of a user
    """
    success, session_token = extract_token(request)

    if not success:
        return session_token
    
    user = users_dao.get_user_by_session_token(session_token)
    if user is None:
        return failure_response("User not found!")
    messages = Message.query.filter_by(recipient_id=user.id).all()
    serialized_messages = [m.serialize() for m in messages]
    return success_response({"messages": serialized_messages})

#Images endpoints
@app.route("/upload/", methods=["POST"])
def upload():
    """
    Endpoint for uploading an image to AWS given its base64 form,
    then returning the URL of that image
    """
    body = json.loads(request.data)
    image_data = body.get("image_data")
    if image_data is None:
        return failure_response("No base64 URL")
    
    #Create new asset object
    asset = Asset(image_data=image_data)
    db.session.add(asset)
    db.session.commit()

    return success_response(asset.serialize(), 201)

@app.route("/upload/<int:asset_id>/", methods=["GET"])
def get_asset(asset_id):
    """
    Endpoint for getting an asset
    """
    asset = Asset.query.filter_by(id=asset_id).first()
    if asset is None:
        return failure_response("Asset not found!")
    return success_response(asset.serialize())

@app.route("/upload/", methods=["GET"])
def get_all_assets():
    """
    Endpoint for getting all assets
    """
    assets = Asset.query.all()
    serialized_assets = [a.serialize() for a in assets]
    return success_response({"assets": serialized_assets})

@app.route("/upload/<int:asset_id>/", methods=["DELETE"])
def delete_asset(asset_id):
    """
    Endpoint for deleting an asset
    """
    asset = Asset.query.filter_by(id=asset_id).first()
    if asset is None:
        return failure_response("Asset not found!")
    db.session.delete(asset)
    db.session.commit()
    return success_response(asset.serialize())

#User Asset endpoints
@app.route("/upload/user/", methods=["POST"])
def upload_asset_to_user():
    """
    Endpoint for uploading an asset to a user
    """
    body = json.loads(request.data)
    image_data = body.get("image_data")
    if image_data is None:
        return failure_response("No base64 URL")
    
    success, session_token = extract_token(request)

    if not success:
        return session_token
    
    user = users_dao.get_user_by_session_token(session_token)

    if user is None:
        return failure_response("User not found!")
    
    existing_asset = Asset.query.filter_by(user_id=user.id).first()
    if existing_asset:
        return failure_response("User already has an asset!")
    
    #Create new asset object
    asset = Asset(image_data=image_data, user_id = user.id)
    db.session.add(asset)
    db.session.commit()

    return success_response(asset.serialize(), 201)

@app.route("/upload/user/", methods=["GET"])
def get_user_asset():
    """
    Endpoint for getting an asset
    """

    success, session_token = extract_token(request)

    if not success:
        return session_token
    
    user = users_dao.get_user_by_session_token(session_token)
    asset = Asset.query.filter_by(user_id=user.id).first()
    if asset is None:
        return failure_response("Asset not found!")
    return success_response(asset.serialize())

@app.route("/upload/user/", methods=["DELETE"])
def delete_user_asset():
    """
    Endpoint for deleting an asset
    """

    success, session_token = extract_token(request)

    if not success:
        return session_token
    
    user = users_dao.get_user_by_session_token(session_token)
    asset = Asset.query.filter_by(user_id=user.id).first()
    if asset is None:
        return failure_response("Asset not found!")
    db.session.delete(asset)
    db.session.commit()
    return success_response(asset.serialize())

#Pet Sitting Asset endpoints
@app.route("/upload/pet_sitting/<int:pet_sitting_id>", methods=["POST"])
def upload_asset_to_pet_sitting(pet_sitting_id):
    """
    Endpoint for uploading an asset to a pet sitting
    """
    body = json.loads(request.data)
    image_data = body.get("image_data")
    if image_data is None:
        return failure_response("No base64 URL")
    
    pet_sitting = PetSittingRequest.query.filter_by(id=pet_sitting_id).first()
    if pet_sitting is None:
        return failure_response("Pet sitting not found!")
    
    asset = Asset(image_data=image_data, pet_sitting_id = pet_sitting.id)
    db.session.add(asset)
    db.session.commit()

    return success_response(asset.serialize(), 201)

@app.route("/upload/pet_sitting/<int:pet_sitting_id>", methods=["GET"])
def get_all_pet_sitting_asset(pet_sitting_id):
    """
    Endpoint for getting all assets in pet_sitting request
    """
    pet_sitting = PetSittingRequest.query.filter_by(id=pet_sitting_id).first()
    if pet_sitting is None:
        return failure_response("Pet sitting not found!")
    assets = Asset.query.filter_by(pet_sitting_id=pet_sitting.id).all()
    serialized_assets = [a.serialize() for a in assets]
    return success_response({"assets": serialized_assets})

@app.route("/upload/pet_sitting/<int:pet_sitting_id>/<int:asset_id>", methods=["DELETE"])
def delete_pet_sitting_asset(pet_sitting_id, asset_id):
    """
    Endpoint for deleting an asset
    """
    pet_sitting = PetSittingRequest.query.filter_by(id=pet_sitting_id).first()
    if pet_sitting is None:
        return failure_response("Pet sitting not found!")
    asset = Asset.query.filter_by(id=asset_id).first()
    if asset is None:
        return failure_response("Asset not found!")
    asset = Asset.query.filter_by(id=asset_id, pet_sitting_id=pet_sitting_id).first()
    if asset is None:
        return failure_response("Asset not found or not associated with the pet sitting request!")
    
    db.session.delete(asset)
    db.session.commit()
    return success_response(asset.serialize())

#Pet Adoption Asset endpoints
@app.route("/upload/pet_adoption/<int:pet_adoption_id>", methods=["POST"])
def upload_asset_to_pet_adoption(pet_adoption_id):
    """
    Endpoint for uploading an asset to a pet sitting
    """
    body = json.loads(request.data)
    image_data = body.get("image_data")
    if image_data is None:
        return failure_response("No base64 URL")
    
    pet_adoption = PetAdoptionRequest.query.filter_by(id=pet_adoption_id).first()
    if pet_adoption is None:
        return failure_response("Pet Adoption not found!")
    
    asset = Asset(image_data=image_data, pet_adoption_id = pet_adoption.id)
    db.session.add(asset)
    db.session.commit()

    return success_response(asset.serialize(), 201)

@app.route("/upload/pet_adoption/<int:pet_adoption_id>", methods=["GET"])
def get_pet_adoption_asset(pet_adoption_id):
    """
    Endpoint for getting an asset
    """
    pet_adoption = PetAdoptionRequest.query.filter_by(id=pet_adoption_id).first()
    if pet_adoption is None:
        return failure_response("Pet adoption not found!")
    asset = Asset.query.filter_by(pet_adoption_id=pet_adoption.id).first()
    if asset is None:
        return failure_response("Asset not found!")
    return success_response(asset.serialize())

@app.route("/upload/pet_adoption/<int:pet_adoption_id>/<int:asset_id>", methods=["DELETE"])
def delete_pet_adoption_asset(pet_adoption_id, asset_id):
    """
    Endpoint for deleting an asset
    """
    pet_adoption = PetAdoptionRequest.query.filter_by(id=pet_adoption_id).first()
    if pet_adoption is None:
        return failure_response("Pet adoption not found!")
    asset = Asset.query.filter_by(id=asset_id).first()
    if asset is None:
        return failure_response("Asset not found!")
    
    asset = Asset.query.filter_by(id=asset_id, pet_adoption_id=pet_adoption.id).first()
    if asset is None:
        return failure_response("Asset not found or not associated with the pet sitting request!")
    
    db.session.delete(asset)
    db.session.commit()
    return success_response(asset.serialize())


#Openai integration
def get_ai_help(user_id, pet_id, request_id, your_query_here):
    """
    Get openai response
    """
    user = User.query.get(user_id)
    pet = Pets.query.get(pet_id)
    pet_sitting_request = PetSittingRequest.query.get(request_id)

    prompt = f"User {user.first_name} has a pet named {pet.name} and a pet sitting request from {pet_sitting_request.start_date} to {pet_sitting_request.end_date}. {your_query_here}"
    ai_response = generate_ai_response(prompt)
    return ai_response

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=8000, debug=True)