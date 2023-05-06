//
//  PasswordSetupViewController.swift
//  Housing and Pet
//
//  Created by Wei Zheng on 4/30/23.
//

import UIKit

class PasswordSetupViewController: UIViewController {
    
    let passwordSetupPageCircle = UIView()
    let passwordSetupPagePic = UIImageView()
    let setUpPasswordLabel = UILabel()
    let passwordField = PaddedTextField()
    let passwordDesLabel = UILabel()
    let confPassword = PaddedTextField()
    let nextButton = UIButton()
    let loginButton = UIButton()
    var waitInd: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        navigationItem.hidesBackButton = true
        
        //sign up circle
        passwordSetupPageCircle.clipsToBounds = true
        passwordSetupPageCircle.layer.cornerRadius = 380/2
        passwordSetupPageCircle.translatesAutoresizingMaskIntoConstraints = false
        passwordSetupPageCircle.backgroundColor = UIColor(red: 0.91, green: 0.91, blue: 0.91, alpha: 1)
        view.insertSubview(passwordSetupPageCircle, at: 0)
        
        //pic
        passwordSetupPagePic.image = UIImage(named: "signupPic")
        passwordSetupPagePic.translatesAutoresizingMaskIntoConstraints = false
        view.insertSubview(passwordSetupPagePic, at: 1)
        
        //Setup password Label
        setUpPasswordLabel.text = "Create a password"
        setUpPasswordLabel.font = UIFont(name: "Ubuntu-Medium", size: 18)
        setUpPasswordLabel.textColor = UIColor(red: 0.07, green: 0.07, blue: 0.07, alpha: 1.0)
        setUpPasswordLabel.translatesAutoresizingMaskIntoConstraints = false
        view.insertSubview(setUpPasswordLabel, at: 0)
        
        //password field
        let passwordFieldPlaceHolderText = "Enter password"
        let passwordFieldTextAttributes: [NSAttributedString.Key: Any] = [
            .font: UIFont(name: "Ubuntu-Regular", size: 14) ?? .systemFont(ofSize: 14, weight: .regular),
            .foregroundColor: UIColor(red: 0.48, green: 0.49, blue: 0.53, alpha: 1),
        ]
        let passwordFieldAttributedTitle = NSAttributedString(string: passwordFieldPlaceHolderText, attributes: passwordFieldTextAttributes)
        passwordField.translatesAutoresizingMaskIntoConstraints = false
        passwordField.attributedPlaceholder = passwordFieldAttributedTitle
        passwordField.delegate = self
        passwordField.textColor = UIColor(red: 0.07, green: 0.07, blue: 0.07, alpha: 1)
        passwordField.autocapitalizationType = .none
        passwordField.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
        passwordField.layer.borderColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1).cgColor
        passwordField.layer.borderWidth = 2
        passwordField.font = UIFont(name: "Ubuntu-Regular", size: 14)
        passwordField.clipsToBounds = true
        passwordField.layer.cornerRadius = 15
        passwordField.isSecureTextEntry = true
        passwordField.autocorrectionType = .no
        passwordField.autocapitalizationType = .none
        passwordField.delegate = self
        view.insertSubview(passwordField, at: 0)
        
        
        //password description label
        passwordDesLabel.numberOfLines = 3
        let passwordDesLabelTitle = "*Password must be at least 6 characters with 1\nspecial character, 1 upper case, one lower case, and\n1 number."
        let passwordDesTextAttributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor(red: 0.48, green: 0.49, blue: 0.53, alpha: 1.0),
            .font: UIFont(name: "Ubuntu-Medium", size: 12) ?? .systemFont(ofSize: 12, weight: .regular),
        ]
        let passwordDesAttributedTitle = NSAttributedString(string: passwordDesLabelTitle, attributes: passwordDesTextAttributes)
        passwordDesLabel.attributedText = passwordDesAttributedTitle
        passwordDesLabel.translatesAutoresizingMaskIntoConstraints = false
        view.insertSubview(passwordDesLabel, at: 0)
        
        //confirm password field
        let confPasswordFieldPlaceHolderText = "Confirm password"
        let confPasswordFieldTextAttributes: [NSAttributedString.Key: Any] = [
            .font: UIFont(name: "Ubuntu-Regular", size: 14) ?? .systemFont(ofSize: 14, weight: .regular),
            .foregroundColor: UIColor(red: 0.48, green: 0.49, blue: 0.53, alpha: 1),
        ]
        let confPasswordFieldAttributedTitle = NSAttributedString(string: confPasswordFieldPlaceHolderText, attributes: confPasswordFieldTextAttributes)
        confPassword.translatesAutoresizingMaskIntoConstraints = false
        confPassword.attributedPlaceholder = confPasswordFieldAttributedTitle
        confPassword.delegate = self
        confPassword.textColor = UIColor(red: 0.07, green: 0.07, blue: 0.07, alpha: 1)
        confPassword.autocapitalizationType = .none
        confPassword.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
        confPassword.layer.borderColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1).cgColor
        confPassword.layer.borderWidth = 2
        confPassword.font = UIFont(name: "Ubuntu-Regular", size: 14)
        confPassword.clipsToBounds = true
        confPassword.autocorrectionType = .no
        confPassword.layer.cornerRadius = 15
        confPassword.isSecureTextEntry = true
        confPassword.autocapitalizationType = .none
        confPassword.delegate = self
        view.insertSubview(confPassword, at: 0)
        
        
        //next button
        let nextButtonTitle = "Next"
        let strokeTextAttributes: [NSAttributedString.Key: Any] = [
            .strokeColor: UIColor.white,
            .foregroundColor: UIColor.white,
            .strokeWidth: -1.0,
            .font: UIFont(name: "Ubuntu-Medium", size: 18) ?? .systemFont(ofSize: 18, weight: .regular),
            
        ]
        let nextAttributedTitle = NSAttributedString(string: nextButtonTitle, attributes: strokeTextAttributes)
        nextButton.backgroundColor = UIColor(red: 0.12, green: 0.12, blue: 0.13, alpha: 1)
        nextButton.clipsToBounds = true
        nextButton.layer.cornerRadius = 20
        nextButton.setAttributedTitle(nextAttributedTitle, for: .normal)
        nextButton.titleLabel?.textColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
        nextButton.titleLabel?.textAlignment = .center
        nextButton.translatesAutoresizingMaskIntoConstraints = false
        nextButton.addTarget(self, action: #selector(backToLogin), for: .touchUpInside)
        view.insertSubview(nextButton, at: 0)
        
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
        
        //constraints
        setCons()
    }
    
    @objc private func login(){
        navigationController?.pushViewController(SignInViewController(), animated: true)
    }
    
    @objc private func backToLogin(){
        
        let registerUserRequest = RegisterUserRequest(username: CreateAccountViewController.username.text ?? "", email: CreateAccountViewController.email.text ?? "", password: self.passwordField.text ?? "")
        
        //password check
        if !Validator.isPasswordValid(for: registerUserRequest.password){
            AlertManager.showInvalidPasswordAlert(on: self)
            return
        }
        
        NetworkManager.shared.createUser(email: CreateAccountViewController.email.text!, password: self.confPassword.text!, username: CreateAccountViewController.username.text!, phone: "3456") { UserReq in
            print("good")
            DispatchQueue.main.async {
                NetworkManager.shared.loginUser(email: CreateAccountViewController.email.text!, password: self.confPassword.text!, completion: { userResponse in
                    print("ok")
                    ProfileViewController.backEndToken = userResponse.session_token
                })
            }
        }
            
            
            AuthService.shared.registerUser(with: registerUserRequest) { [weak self] wasRegistered, error in
                
                guard let self = self else {return}
                
                if let error = error {
                    AlertManager.showRegistrationErrorAlert(on: self, with: error)
                    return
                }
                
                if wasRegistered{
                    if let sceneDelegate = self.view.window?.windowScene?.delegate as? SceneDelegate{
                        sceneDelegate.checkAuthentication()
                    }
                } else{
                    AlertManager.showRegistrationErrorAlert(on: self)
                }
            }
        
    }
        
    

    
    
    private func setCons(){
        NSLayoutConstraint.activate([
            
            //set up email conf circle
            passwordSetupPageCircle.topAnchor.constraint(equalTo: view.topAnchor,constant: -122),
            passwordSetupPageCircle.rightAnchor.constraint(equalTo: view.rightAnchor,constant: 65),
            passwordSetupPageCircle.widthAnchor.constraint(equalToConstant: 380),
            passwordSetupPageCircle.heightAnchor.constraint(equalToConstant: 380),
        
            //set up the image view
            passwordSetupPagePic.widthAnchor.constraint(equalToConstant: 326.18),
            passwordSetupPagePic.heightAnchor.constraint(equalToConstant: 261),
            passwordSetupPagePic.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            passwordSetupPagePic.topAnchor.constraint(equalTo: passwordSetupPageCircle.topAnchor,constant: 189),
            
            //set up the password label
            setUpPasswordLabel.topAnchor.constraint(equalTo: passwordSetupPageCircle.bottomAnchor,constant: 137.5),
            setUpPasswordLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor,constant: 61),
            
            //set up the password textfield
            passwordField.topAnchor.constraint(equalTo: setUpPasswordLabel.bottomAnchor, constant: 25.5),
            passwordField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            passwordField.widthAnchor.constraint(equalToConstant: 272),
            passwordField.heightAnchor.constraint(equalToConstant: 30),
            
            
            //set up the password description text
            passwordDesLabel.topAnchor.constraint(equalTo: passwordField.bottomAnchor,constant: 8),
            passwordDesLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            //set up the confpassword textfield
            confPassword.topAnchor.constraint(equalTo: setUpPasswordLabel.bottomAnchor, constant: 127.5),
            confPassword.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            confPassword.widthAnchor.constraint(equalToConstant: 272),
            confPassword.heightAnchor.constraint(equalToConstant: 30),
            
            //set up next button
            nextButton.widthAnchor.constraint(equalToConstant: 81),
            nextButton.heightAnchor.constraint(equalToConstant: 45),
            nextButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor,constant: -52),
            nextButton.topAnchor.constraint(equalTo: confPassword.bottomAnchor,constant:59),
            
            //already have account
            loginButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loginButton.widthAnchor.constraint(equalToConstant: 176),
            loginButton.heightAnchor.constraint(equalToConstant: 14),
            loginButton.topAnchor.constraint(equalTo: nextButton.bottomAnchor,constant: 79),
            
        ])
    }
}
extension PasswordSetupViewController: UITextFieldDelegate{
    
     func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
 
    }

