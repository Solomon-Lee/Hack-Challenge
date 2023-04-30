"""
DAO (Data Access Object) file

Helper file containing functions for accessing data in our database
"""

from db import User
from db import db


def get_user_by_email(email):
    """
    Returns a user object from the database given an email
    """
    return User.query.filter(User.email == email).first()


def get_user_by_session_token(session_token):
    """
    Returns a user object from the database given a session token
    """
    return User.query.filter(User.session_token == session_token).first()


def get_user_by_update_token(update_token):
    """
    Returns a user object from the database given an update token
    """
    return User.query.filter(User.update_token == update_token).first()


def verify_credentials(email, password):
    """
    Returns true if the credentials match, otherwise returns false
    """
    optional_user = get_user_by_email(email)

    if optional_user is None:
        return False, None
    
    return optional_user.verify_password(password), optional_user


def create_user(email, password, first_name, last_name, phone, google_id=None, access_token=None):
    """
    Creates a User object in the database

    Returns if creation was successful, and the User object
    """
    
    optional_user = get_user_by_email(email)

    if optional_user is not None:
        return False, optional_user
    
    user = User(email=email, password=password, first_name=first_name, last_name=last_name, phone=phone)

    if google_id is not None:
        user.google_id = google_id
    if access_token is not None:
        user.access_token = access_token

    db.session.add(user)
    db.session.commit()

    return True, user


def renew_session(update_token):
    """
    Renews a user's session token
    
    Returns the User object
    """
    
    user = get_user_by_update_token(update_token)

    if user is None:
        return None
    
    user.renew_session()

    db.session.commit()

    return user

def get_user_by_google_id(google_user_id):
    return User.query.filter_by(google_user_id=google_user_id).first()

def create_user_with_google_id(google_user_id, email, first_name, last_name):
    user = User(
        google_user_id=google_user_id,
        email=email,
        first_name=first_name,
        last_name=last_name
    )

    db.session.add(user)
    db.session.commit()
    return user

