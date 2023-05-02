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
from db import User, Pets, PetSittingRequest, Role, Message

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
@app.route("/user/", methods=["GET"])
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

@app.route("/user/<string:session_token>/", methods=["PUT"])
def update_user(session_token):
    """
    Endpoint for updating a user
    """
    user = users_dao.get_user_by_session_token(session_token)
    if user is None:
        return failure_response("User not found!")

    data = request.get_json()
    if "phone" in data:
        user.phone = data["phone"]
    if "gender" in data:
        user.gender = data["gender"]

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

@app.route("/user/pet/<string:session_token>/", methods = ["POST"])
def create_pet(session_token):
    body = json.loads(request.data)
    name = body.get("name")
    age = body.get("age")
    species = body.get('species')
    breed = body.get('breed')
    color = body.get('color')
    medical_conditions = body.get('medical_conditions')
    user = users_dao.get_user_by_session_token(session_token)
    if user is None:
        return failure_response("User not found!")
    if name is None or age is None or species is None or breed is None or color is None or medical_conditions is None:
        return failure_response("Missing information!")
    pet = Pets(name = name, age = age, species = species, breed = breed, color = color, medical_conditions = medical_conditions, user_id = user.id)
    user.pets.append(pet)
    db.session.add(pet)
    db.session.commit()
    return success_response(pet.simple_serialize())

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
    return success_response(pet.simple_serialize())

@app.route("/user/<string:session_token>/pets/", methods = ["GET"])
def get_user_pets(session_token):
    """
    Endpoint for getting all pets of a user
    """
    user = users_dao.get_user_by_session_token(session_token)
    if user is None:
        return failure_response("User not found!")
    pets = [pet.simple_serialize() for pet in user.pets]
    return success_response({"pets": pets})

@app.route("/user/<string:session_token>/pet/<int:pet_id>/", methods = ["DELETE"])
def remove_pet_from_user(session_token, pet_id):
    """
    Endpoint for removing a pet from a user
    """
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
    if "species" in data:
        pet.species = data["species"]
    if "breed" in data:
        pet.breed = data["breed"]
    if "color" in data:
        pet.color = data["color"]
    if "medical_conditions" in data:
        pet.medical_conditions = data["medical_conditions"]
    db.session.commit()
    return success_response(pet.simple_serialize())

#Pet Sitting Request endpoints
@app.route("/user/<string:session_token>/pet/<string:pet_id>/pet_sitting_request/", methods = ["POST"])
def create_pet_sitting_request(session_token, pet_id):
    """
    Endpoint for creating a pet sitting request
    """
    body = json.loads(request.data)
    start_time = body.get('start_time')
    end_time = body.get("end_time")
    additional_info = body.get("additional_info")
    user = users_dao.get_user_by_session_token(session_token)
    pet = Pets.query.filter_by(id = pet_id).first()

    if user is None:
        return failure_response("User not found!")
    if pet is None:
        return failure_response("Pet not found!")
    pet_sitting_request = PetSittingRequest(pet_id = pet.id, pet_owner_id = user.id, start_time = start_time, end_time = end_time, additional_info = additional_info)
    user.pet_owner_requests.append(pet_sitting_request)
    db.session.add(pet_sitting_request)
    db.session.commit()
    return success_response(pet_sitting_request.serialize())

@app.route("/user/<string:session_token>/pet_sitting_request/<int:pet_sitting_request_id>/", methods = ["POST"])
def add_user_as_pet_sitter(session_token, pet_sitting_request_id):
    """
    Endpoint for adding a pet sitter to a pet sitting request
    """
    user = users_dao.get_user_by_session_token(session_token)
    pet_sitting_request = PetSittingRequest.query.filter_by(id = pet_sitting_request_id).first()
    if user is None:
        return failure_response("User not found!")
    if pet_sitting_request is None:
        return failure_response("Pet sitting request not found!")
    pet_sitting_request.pet_sitter_id = user.id
    db.session.commit()
    return success_response(pet_sitting_request.serialize())

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
    return success_response(pet_sitting_request.serialize())

@app.route("/pet_sitting_request/<int:pet_sitting_request_id>/", methods = ["PUT"])
def update_pet_sitting_request(pet_sitting_request_id):
    """
    Endpoint for updating a pet sitting request
    """
    pet_sitting_request = PetSittingRequest.query.filter_by(id = pet_sitting_request_id).first()
    if pet_sitting_request is None:
        return failure_response("Pet sitting request not found!")
    data = request.get_json()
    if "start_date" in data:
        pet_sitting_request.start_date = data["start_date"]
    if "end_date" in data:
        pet_sitting_request.end_date = data["end_date"]
    if "additional_info" in data:
        pet_sitting_request.additional_info = data["additional_info"]
    db.session.commit()
    return success_response(pet_sitting_request.serialize())

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

@app.route("/user/<string:session_token>/pet_sitting_requests/", methods=["GET"])
def get_user_pet_sitting_requests(session_token):
    """
    Endpoint for getting all pet sitting requests of a user
    """
    user = users_dao.get_user_by_session_token(session_token)
    if user is None:
        return failure_response("User not found!")
    pet_owner_requests = [r.serialize() for r in user.pet_owner_requests]
    pet_sitter_requests = [r.serialize() for r in user.pet_sitter_requests]
    return success_response({
        "pet_owner_requests": pet_owner_requests,
        "pet_sitter_requests": pet_sitter_requests
    })

#Role Request endpoints
@app.route("/roles/", methods=["GET"])
def get_all_roles():
    """
    Endpoint for getting all roles
    """
    roles = Role.query.all()
    serialized_roles = [r.serialize() for r in roles]
    return success_response({"roles": serialized_roles})

@app.route("/role/<int:role_id>/", methods=["GET"])
def get_role_by_id(role_id):
    """
    Endpoint for getting a role
    """
    role = Role.query.filter_by(id=role_id).first()
    if role is None:
        return failure_response("Role not found!")
    return success_response(role.serialize())

@app.route("/role/<int:role_id>/", methods=["DELETE"])
def delete_role(role_id):
    """
    Endpoint for deleting a role
    """
    role = Role.query.filter_by(id=role_id).first()
    if role is None:
        return failure_response("Role not found!")
    db.session.delete(role)
    db.session.commit()
    return success_response(role.serialize())

@app.route("/role/", methods=["POST"])
def create_roles():
    """
    Ednpoint for creating roles
    """
    roles = [
        {"name": "pet_owner", "description": "Pet owner role"},
        {"name": "pet_sitter", "description": "Pet sitter role"}
    ]
    for role in roles:
        existing_role = Role.query.filter_by(name=role["name"]).first()
        if not existing_role:
            new_role = Role(name=role["name"], description=role["description"])
            db.session.add(new_role)
    db.session.commit()
    return success_response("Roles created successfully!")

@app.route("/role/<string:session_token>/", methods=["POST"])
def add_role_to_user(session_token):
    """
    Endpoint for adding a role to a user
    """
    body = json.loads(request.data)
    role_id = body.get("role_id")
    user = users_dao.get_user_by_session_token(session_token)
    if user is None:
        return failure_response("User not found!")
    role = Role.query.filter_by(id=role_id).first()
    if role is None:
        return failure_response("Role not found!")
    user.roles.append(role)
    db.session.commit()
    return success_response(user.serialize())

@app.route("/role/<string:session_token>/", methods=["DELETE"])
def remove_role_from_user(session_token):
    """
    Endpoint for removing a role from a user
    """
    body = json.loads(request.data)
    role_id = body.get("role_id")
    user = users_dao.get_user_by_session_token(session_token)
    if user is None:
        return failure_response("User not found!")
    role = Role.query.filter_by(id=role_id).first()
    if role is None:
        return failure_response("Role not found!")
    user.roles.remove(role)
    db.session.commit()
    return success_response(user.serialize())

@app.route("/role/<string:session_token>/", methods=["GET"])
def get_user_roles(session_token):
    """
    Endpoint for getting all roles of a user
    """
    user = users_dao.get_user_by_session_token(session_token)
    if user is None:
        return failure_response("User not found!")
    roles = [r.serialize() for r in user.roles]
    return success_response({"roles": roles})

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

@app.route("/message/<string:sender_email>/<string:recipient_email>/", methods=["POST"])
def create_message(sender_email, recipient_email):
    """
    Endpoint for creating a message
    """
    body = json.loads(request.data)
    content = body.get("content")
    sender = users_dao.get_user_by_email(sender_email)
    recipient = users_dao.get_user_by_email(recipient_email)
    if sender is None or recipient is None:
        return failure_response("Sender or recipient not found!")
    new_message = Message(content=content, sender_id=sender.id, recipient_id=recipient.id)
    db.session.add(new_message)
    db.session.commit()
    return success_response(new_message.serialize())

@app.route("/message/<string:session_token>/", methods=["GET"])
def get_user_messages(session_token):
    """
    Endpoint for getting all messages of a user
    """
    user = users_dao.get_user_by_session_token(session_token)
    if user is None:
        return failure_response("User not found!")
    messages = Message.query.filter_by(recipient_id=user.id).all()
    serialized_messages = [m.serialize() for m in messages]
    return success_response({"messages": serialized_messages})

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
