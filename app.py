import json

from db import db
from flask import Flask, redirect, request, session, url_for
from google.oauth2 import id_token
from urllib.parse import urlencode
from google.auth.transport import requests
import users_dao
import datetime

db_filename = "auth.db"
app = Flask(__name__)

app.config["SQLALCHEMY_DATABASE_URI"] = "sqlite:///%s" % db_filename
app.config["SQLALCHEMY_TRACK_MODIFICATIONS"] = False
app.config["SQLALCHEMY_ECHO"] = True

#Make env file for google shit
app.secret_key = 'your-secret-key-here'
app.config['GOOGLE_CLIENT_ID'] = 'your-client-id-here'
app.config['GOOGLE_CLIENT_SECRET'] = 'your-client-secret-here'
app.config['GOOGLE_DISCOVERY_URL'] = (
    'https://accounts.google.com/.well-known/openid-configuration'
)

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

def get_google_provider_cfg():
    return requests.get(app.config['GOOGLE_DISCOVERY_URL']).json()

def get_google_token_url(code):
    google_provider_cfg = get_google_provider_cfg()
    token_url = google_provider_cfg['token_endpoint']
    headers = {'content-type': 'application/x-www-form-urlencoded'}
    body = {
        'grant_type': 'authorization_code',
        'code': code,
        'redirect_uri': url_for('google_callback', _external=True),
        'client_id': app.config['GOOGLE_CLIENT_ID'],
        'client_secret': app.config['GOOGLE_CLIENT_SECRET'],
    }
    return token_url, headers, body

@app.route('/login/google', methods=['GET'])
def login_google():
    session.clear()
    return redirect(url_for('google_authorize'))

@app.route('/authorize/google', methods=['GET'])
def google_authorize():
    return redirect(get_google_provider_cfg().get('authorization_endpoint') + '?' + urlencode({
        'response_type': 'code',
        'client_id': app.config['GOOGLE_CLIENT_ID'],
        'redirect_uri': url_for('google_callback', _external=True),
        'scope': 'openid email profile'
    }))

@app.route('/callback/google', methods=['GET'])
def google_callback():
    code = request.args.get('code')

    token_url, headers, body = get_google_token_url(code)

    # Fetch token
    token_response = requests.post(
        token_url,
        headers=headers,
        data=body,
        auth=(app.config['GOOGLE_CLIENT_ID'], app.config['GOOGLE_CLIENT_SECRET']),
    )

    # Parse token
    id_token_jwt = token_response.json()['id_token']
    google_user_info = id_token.verify_oauth2_token(id_token_jwt, requests.Request(), app.config['GOOGLE_CLIENT_ID'])

    # Get or create user
    user_email = google_user_info['email']
    user_given_name = google_user_info['given_name']
    user_family_name = google_user_info['family_name']
    user_picture_url = google_user_info['picture']
    created, user = users_dao.get_or_create_user_by_email(
        email=user_email,
        given_name=user_given_name,
        family_name=user_family_name,
        picture_url=user_picture_url,
    )

    # Log in user
    session['user_id'] = user.id

    return redirect(url_for('index'))

def login_with_google_oauth(google_token):
    """
    Logs in a user with Google OAuth

    Returns if the login was successful, and the User object
    """
    try:
        google_info = requests.get(f"https://www.googleapis.com/oauth2/v3/userinfo?access_token={google_token}").json()
        email = google_info["email"]
        first_name = google_info["given_name"]
        last_name = google_info["family_name"]
        google_id = google_info["sub"]
    except:
        return False, None

    # check if user with this Google ID already exists
    user = get_user_by_google_id(google_id)

    if user is None:
        # create a new user with Google ID and access token
        created, user = create_user(email, None, first_name, last_name, None, google_id=google_id, access_token=google_token)
        if not created:
            return False, None

    # renew the session and return the user
    user.renew_session()
    db.session.commit()

    return True, user

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

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=8000, debug=True)
