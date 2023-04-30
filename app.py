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
from db import User, Pets, PetSittingRequest


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
    first_name = body.get("first_name")
    last_name = body.get("last_name")
    phone = body.get("phone")

    if email is None or password is None or first_name is None or last_name is None or phone is None:
        return failure_response("Email, password, first name, last name, or phone not provided")
    
    created, user = users_dao.create_user(email, password, first_name, last_name, phone)

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
    
    return success_response(
        {
            "email": user.email,
            "first_name": user.first_name,
            "last_name": user.last_name,
            "phone": user.phone
        }
    )

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
