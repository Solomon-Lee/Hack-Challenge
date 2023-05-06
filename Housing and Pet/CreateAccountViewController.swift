//
//  CreateAccountViewController.swift
//  Housing and Pet
//
//  Created by Wei Zheng on 4/30/23.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore
import FirebaseCore


class CreateAccountViewController: UIViewController {
    
    let signUpPageCircle = UIView()
    let signUpPagePic = UIImageView()
    let createAccountLabel = UILabel()
    static let username = PaddedTextField()
    let userNameLabel = UILabel()
    static let email = PaddedTextField()
    let emailLabel = UILabel()
    let usernameReq = UILabel()
    let verifyEmailButton = UIButton()
    let loginButton = UIButton()
    var Indicator: Bool = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
        navigationItem.hidesBackButton = true
        
        //sign up circle
        signUpPageCircle.clipsToBounds = true
        signUpPageCircle.layer.cornerRadius = 380/2
        signUpPageCircle.translatesAutoresizingMaskIntoConstraints = false
        signUpPageCircle.backgroundColor = UIColor(red: 0.91, green: 0.91, blue: 0.91, alpha: 1)
        view.insertSubview(signUpPageCircle, at: 0)
        
        //pic
        signUpPagePic.image = UIImage(named: "signupPic")
        signUpPagePic.translatesAutoresizingMaskIntoConstraints = false
        view.insertSubview(signUpPagePic, at: 1)
        
        //welcome label
        createAccountLabel.numberOfLines = 2
        createAccountLabel.text = "Nice to\nmeet you!"
        createAccountLabel.font = UIFont(name: "Ubuntu-Medium", size: 40)
        createAccountLabel.translatesAutoresizingMaskIntoConstraints = false
        createAccountLabel.textColor = UIColor(red: 0.12, green: 0.12, blue: 0.13, alpha: 1.0)
        view.insertSubview(createAccountLabel, at: 0)
        
        //username field
        let usernameFieldPlaceHolderText = "Enter username"
        let usernameFieldTextAttributes: [NSAttributedString.Key: Any] = [
            .font: UIFont(name: "Ubuntu-Regular", size: 14) ?? .systemFont(ofSize: 14, weight: .regular),
            .foregroundColor: UIColor(red: 0.48, green: 0.49, blue: 0.53, alpha: 1),
        ]
        let usernameFieldAttributedTitle = NSAttributedString(string: usernameFieldPlaceHolderText, attributes: usernameFieldTextAttributes)
        CreateAccountViewController.username.translatesAutoresizingMaskIntoConstraints = false
        CreateAccountViewController.username.attributedPlaceholder = usernameFieldAttributedTitle
        CreateAccountViewController.username.delegate = self
        CreateAccountViewController.username.textColor = UIColor(red: 0.07, green: 0.07, blue: 0.07, alpha: 1.0)
        CreateAccountViewController.username.autocorrectionType = .no
        CreateAccountViewController.username.autocapitalizationType = .none
        CreateAccountViewController.username.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
        CreateAccountViewController.username.layer.borderColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1).cgColor
        CreateAccountViewController.username.layer.borderWidth = 2
        CreateAccountViewController.username.font = UIFont(name: "Ubuntu-Regular", size: 14)
        CreateAccountViewController.username.clipsToBounds = true
        CreateAccountViewController.username.layer.cornerRadius = 15
        CreateAccountViewController.username.textAlignment = .center
        CreateAccountViewController.username.autocapitalizationType = .none
        CreateAccountViewController.username.delegate = self
        view.insertSubview(CreateAccountViewController.username, at: 0)
        
        //username label
        userNameLabel.text = "Username"
        userNameLabel.font = UIFont(name: "Ubuntu-Medium", size: 18)
        userNameLabel.translatesAutoresizingMaskIntoConstraints = false
        userNameLabel.textColor = UIColor(red: 0.07, green: 0.07, blue: 0.07, alpha: 1)
        view.insertSubview(userNameLabel, at: 0)
        
        //username requirements
        usernameReq.text = "*Username must be at least 4 characters & no space"
        usernameReq.textColor = UIColor(red: 0.48, green: 0.49, blue: 0.53, alpha: 1.0)
        usernameReq.font = UIFont(name: "Ubuntu-Regular", size: 12)
        usernameReq.translatesAutoresizingMaskIntoConstraints = false
        view.insertSubview(usernameReq, at: 0)
        
        //Email field
        let emailFieldPlaceHolderText = "Enter email address"
        let emailFieldTextAttributes: [NSAttributedString.Key: Any] = [
            .font: UIFont(name: "Ubuntu-Regular", size: 14) ?? .systemFont(ofSize: 14, weight: .regular),
            .foregroundColor: UIColor(red: 0.48, green: 0.49, blue: 0.53, alpha: 1),
        ]
        let emailFieldAttributedTitle = NSAttributedString(string: emailFieldPlaceHolderText, attributes: emailFieldTextAttributes)
        CreateAccountViewController.email.translatesAutoresizingMaskIntoConstraints = false
        CreateAccountViewController.email.attributedPlaceholder = emailFieldAttributedTitle
        CreateAccountViewController.email.delegate = self
        CreateAccountViewController.email.textColor = UIColor(red: 0.07, green: 0.07, blue: 0.07, alpha: 1.0)
        CreateAccountViewController.email.autocapitalizationType = .none
        CreateAccountViewController.email.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
        CreateAccountViewController.email.layer.borderColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1).cgColor
        CreateAccountViewController.email.autocorrectionType = .no
        CreateAccountViewController.email.layer.borderWidth = 2
        CreateAccountViewController.email.font = UIFont(name: "Ubuntu-Regular", size: 14)
        CreateAccountViewController.email.clipsToBounds = true
        CreateAccountViewController.email.layer.cornerRadius = 15
        CreateAccountViewController.email.textAlignment = .center
        CreateAccountViewController.email.autocapitalizationType = .none
        CreateAccountViewController.email.delegate = self
        view.insertSubview(CreateAccountViewController.email, at: 0)
        
        //email label
        emailLabel.text = "Email"
        emailLabel.font = UIFont(name: "Ubuntu-Medium", size: 18)
        emailLabel.translatesAutoresizingMaskIntoConstraints = false
        emailLabel.textColor = UIColor(red: 0.07, green: 0.07, blue: 0.07, alpha: 1)
        view.insertSubview(emailLabel, at: 0)
        
        
        //verify email button
        let verifyEmailButtonTitle = "Verify Email"
        let strokeTextAttributes: [NSAttributedString.Key: Any] = [
            .strokeColor: UIColor.white,
            .foregroundColor: UIColor.white,
            .strokeWidth: -1.0,
            .font: UIFont(name: "Ubuntu-Medium", size: 18) ?? .systemFont(ofSize: 18, weight: .regular),
            
        ]
        let verifyEmailAttributedTitle = NSAttributedString(string: verifyEmailButtonTitle, attributes: strokeTextAttributes)
        verifyEmailButton.backgroundColor = UIColor(red: 0.12, green: 0.12, blue: 0.13, alpha: 1)
        verifyEmailButton.clipsToBounds = true
        verifyEmailButton.layer.cornerRadius = 20
        verifyEmailButton.setAttributedTitle(verifyEmailAttributedTitle, for: .normal)
        verifyEmailButton.titleLabel?.textColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
        verifyEmailButton.titleLabel?.textAlignment = .center
        verifyEmailButton.translatesAutoresizingMaskIntoConstraints = false
        verifyEmailButton.addTarget(self, action: #selector(emailVerif), for: .touchUpInside)
        view.insertSubview(verifyEmailButton, at: 0)
        
        
        //already have account button
        let alreadyHaveTitle = "Already have an account? Log in"
        let alreadyHaveAttributedString = NSMutableAttributedString(string: alreadyHaveTitle)

        // Set attributes for reg text
        let regularAttributes: [NSAttributedString.Key: Any] = [
            .font: UIFont(name: "Ubuntu-Regular", size: 12) ?? .systemFont(ofSize: 12, weight: .regular),
        ]
        alreadyHaveAttributedString.setAttributes(regularAttributes, range: NSRange(location: 0, length: 24))

        // Set attributes for semibold text
        let mediumAttributes: [NSAttributedString.Key: Any] = [
            .font: UIFont(name: "Ubuntu-Medium", size: 12) ?? .systemFont(ofSize: 12, weight: .regular),
            
        ]
        alreadyHaveAttributedString.setAttributes(mediumAttributes, range: NSRange(location: 25, length: 6))

        loginButton.setAttributedTitle(alreadyHaveAttributedString, for: .normal)
        loginButton.titleLabel?.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        loginButton.addTarget(self, action: #selector(login), for: .touchUpInside)
        view.insertSubview(loginButton, at: 0)
        
        setCons()
    }
    
     @objc private func emailVerif(){
        
        let username = CreateAccountViewController.username.text ?? ""
        let email = CreateAccountViewController.email.text ?? ""
        
        //username check
        if !Validator.isValidUsername(for: username){
            AlertManager.showInvalidUsernameAlert(on: self)
            return
        }
        
        //email check
        if !Validator.isValidEmail(for: email){
            AlertManager.showInvalidEmailAlert(on: self)
            return
        }
        
         navigationController?.pushViewController(EmailCodeViewController(), animated: true)
         
     }
         

    
    @objc private func login(){
        navigationController?.pushViewController(SignInViewController(), animated: true)
    }
    private func setCons(){
        NSLayoutConstraint.activate([
            
            //set up signup circle
            signUpPageCircle.topAnchor.constraint(equalTo: view.topAnchor,constant: -122),
            signUpPageCircle.rightAnchor.constraint(equalTo: view.rightAnchor,constant: 65),
            signUpPageCircle.widthAnchor.constraint(equalToConstant: 380),
            signUpPageCircle.heightAnchor.constraint(equalToConstant: 380),
            
            //set up the image view
            signUpPagePic.widthAnchor.constraint(equalToConstant: 326.18),
            signUpPagePic.heightAnchor.constraint(equalToConstant: 261),
            signUpPagePic.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            signUpPagePic.topAnchor.constraint(equalTo: signUpPageCircle.topAnchor,constant: 189),
            
            //set up the create account label
                createAccountLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor,constant: 48),
                createAccountLabel.topAnchor.constraint(equalTo: signUpPageCircle.bottomAnchor,constant: 134),
            
            //set up the username textfield
            CreateAccountViewController.username.topAnchor.constraint(equalTo: createAccountLabel.bottomAnchor, constant: 55),
            CreateAccountViewController.username.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor,constant: -50),
            CreateAccountViewController.username.widthAnchor.constraint(equalToConstant: 178),
            CreateAccountViewController.username.heightAnchor.constraint(equalToConstant: 30),
                
            //set up the username label
            userNameLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor,constant: 61),
            userNameLabel.topAnchor.constraint(equalTo: createAccountLabel.bottomAnchor,constant: 58.5),
            
            //set up the user name requirements label
            usernameReq.topAnchor.constraint(equalTo: userNameLabel.bottomAnchor,constant: 11.5),
            usernameReq.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor,constant: 58.5),
                
            //set up the email textfield
            CreateAccountViewController.email.topAnchor.constraint(equalTo: createAccountLabel.bottomAnchor, constant: 127),
            CreateAccountViewController.email.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor,constant: -50),
            CreateAccountViewController.email.widthAnchor.constraint(equalToConstant: 178),
            CreateAccountViewController.email.heightAnchor.constraint(equalToConstant: 30),
                
            //set up the email label
            emailLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor,constant: 61),
            emailLabel.topAnchor.constraint(equalTo: createAccountLabel.bottomAnchor,constant: 130.5),
            
            //set up verify email button
            verifyEmailButton.widthAnchor.constraint(equalToConstant: 140),
            verifyEmailButton.heightAnchor.constraint(equalToConstant: 45),
            verifyEmailButton.topAnchor.constraint(equalTo: CreateAccountViewController.email.bottomAnchor,constant: 38),
            verifyEmailButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor,constant: -50),
            
            //already have account
            loginButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loginButton.widthAnchor.constraint(equalToConstant: 176),
            loginButton.heightAnchor.constraint(equalToConstant: 14),
            loginButton.topAnchor.constraint(equalTo: verifyEmailButton.bottomAnchor,constant: 29),
        ])
    }

}
extension CreateAccountViewController: UITextFieldDelegate{
    
     func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
 
    }
