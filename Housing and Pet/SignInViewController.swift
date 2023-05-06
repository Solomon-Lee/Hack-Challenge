//
//  SignInViewController.swift
//  Housing and Pet
//
//  Created by Wei Zheng on 4/29/23.
//

import UIKit

class SignInViewController: UIViewController{
        
    let loginPageCircle = UIView()
    let signInButton = UIButton()
    let loginPagePic = UIImageView()
    let loginLabel = UILabel()
    let email = PaddedTextField()
    let emailLabel = UILabel()
    let password = PaddedTextField()
    let passwordLabel = UILabel()
    let forgotPasswordButton = UIButton()
    let signUpButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.hidesBackButton = true
        view.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
        
        //login page circle
        loginPageCircle.clipsToBounds = true
        loginPageCircle.layer.cornerRadius = 380/2
        loginPageCircle.backgroundColor = UIColor(red: 0.91, green: 0.91, blue: 0.91, alpha: 1)
        loginPageCircle.translatesAutoresizingMaskIntoConstraints = false
        view.insertSubview(loginPageCircle, at: 0)
        
        
        //sign in button
        let signInButtonTitle = "Log in"
        let strokeTextAttributes: [NSAttributedString.Key: Any] = [
            .strokeColor: UIColor.white,
            .foregroundColor: UIColor.white,
            .strokeWidth: -1.0,
            .font: UIFont(name: "Ubuntu-Medium", size: 18) ?? .systemFont(ofSize: 18, weight: .regular),
            
        ]
        let signInAttributedTitle = NSAttributedString(string: signInButtonTitle, attributes: strokeTextAttributes)
        signInButton.backgroundColor = UIColor(red: 0.12, green: 0.12, blue: 0.13, alpha: 1)
        signInButton.clipsToBounds = true
        signInButton.layer.cornerRadius = 20
        signInButton.setAttributedTitle(signInAttributedTitle, for: .normal)
        signInButton.titleLabel?.textColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
        signInButton.titleLabel?.textAlignment = .center
        signInButton.translatesAutoresizingMaskIntoConstraints = false
        signInButton.addTarget(self, action: #selector(signIn), for: .touchUpInside)
        view.insertSubview(signInButton, at: 0)
        
        //image view
        loginPagePic.image = UIImage(named: "loginPagePic")
        loginPagePic.translatesAutoresizingMaskIntoConstraints = false
        view.insertSubview(loginPagePic, at: 2)
        
        //login label

        loginLabel.text = "Hello Again!"
        loginLabel.font = UIFont(name: "Ubuntu-Medium", size: 40)
        loginLabel.textColor = UIColor(red: 0.12, green: 0.12, blue: 0.13, alpha: 1)
        loginLabel.translatesAutoresizingMaskIntoConstraints = false
        view.insertSubview(loginLabel, at: 0)
        
        //Email field
        let emailFieldPlaceHolderText = "Enter email address"
        let emailFieldTextAttributes: [NSAttributedString.Key: Any] = [
            .font: UIFont(name: "Ubuntu-Regular", size: 14) ?? .systemFont(ofSize: 14, weight: .regular),
            .foregroundColor: UIColor(red: 0.48, green: 0.49, blue: 0.53, alpha: 1),
        ]
        let emailFieldAttributedTitle = NSAttributedString(string: emailFieldPlaceHolderText, attributes: emailFieldTextAttributes)
        email.translatesAutoresizingMaskIntoConstraints = false
        email.attributedPlaceholder = emailFieldAttributedTitle
        self.email.delegate = self
        email.textColor = UIColor(red: 0.07, green: 0.07, blue: 0.07, alpha: 1.0)
        email.autocapitalizationType = .none
        email.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
        email.layer.borderColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1).cgColor
        email.layer.borderWidth = 2
        email.font = UIFont(name: "Ubuntu-Regular", size: 14)
        email.clipsToBounds = true
        email.layer.cornerRadius = 15
        email.textAlignment = .center
        email.autocorrectionType = .no
        email.autocapitalizationType = .none
        self.email.delegate = self
        view.insertSubview(email, at: 0)
        
        //email label
        emailLabel.text = "Email"
        emailLabel.font = UIFont(name: "Ubuntu-Medium", size: 18)
        emailLabel.translatesAutoresizingMaskIntoConstraints = false
        emailLabel.textColor = UIColor(red: 0.07, green: 0.07, blue: 0.07, alpha: 1)

        view.insertSubview(emailLabel, at: 0)
        
        //password field
        let passwordFieldPlaceHolderText = "Enter your password"
        let passwordFieldTextAttributes: [NSAttributedString.Key: Any] = [
            .font: UIFont(name: "Ubuntu-Regular", size: 14) ?? .systemFont(ofSize: 14, weight: .regular),
            .foregroundColor: UIColor(red: 0.48, green: 0.49, blue: 0.53, alpha: 1),
        ]
        let passwordFieldAttributedTitle = NSAttributedString(string: passwordFieldPlaceHolderText, attributes: passwordFieldTextAttributes)
        password.translatesAutoresizingMaskIntoConstraints = false
        password.attributedPlaceholder = passwordFieldAttributedTitle
        self.password.delegate = self
        password.textColor = UIColor(red: 0.07, green: 0.07, blue: 0.07, alpha: 1.0)
        password.autocapitalizationType = .none
        password.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
        password.layer.borderColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1).cgColor
        password.layer.borderWidth = 2
        password.font = UIFont(name: "Ubuntu-Regular", size: 14)
        password.clipsToBounds = true
        password.layer.cornerRadius = 15
        self.password.delegate = self
        password.isSecureTextEntry = true
        password.autocapitalizationType = .none
        password.autocorrectionType = .no
        password.textAlignment = .center
        view.insertSubview(password, at: 0)
        
        //password label
        passwordLabel.text = "Password"
        passwordLabel.font = UIFont(name: "Ubuntu-Medium", size: 18)
        passwordLabel.translatesAutoresizingMaskIntoConstraints = false
        passwordLabel.textColor = UIColor(red: 0.07, green: 0.07, blue: 0.07, alpha: 1)
        view.insertSubview(passwordLabel, at: 0)
        
        //Forgot Password button
        let forgotPasswordText = "Forgot Password?"
        let forgotPasswordTextAttributes: [NSAttributedString.Key: Any] = [
            .font: UIFont(name: "Ubuntu-Regular", size: 10) ?? .systemFont(ofSize: 10, weight: .regular),
            .foregroundColor: UIColor(red: 0.07, green: 0.07, blue: 0.07, alpha: 1.0),
            .underlineStyle: NSUnderlineStyle.single.rawValue
        ]
        let forgotPasswordAttributedString = NSAttributedString(string: forgotPasswordText, attributes: forgotPasswordTextAttributes)
        
        forgotPasswordButton.setAttributedTitle(forgotPasswordAttributedString, for: .normal)
        forgotPasswordButton.translatesAutoresizingMaskIntoConstraints = false
        forgotPasswordButton.addTarget(self, action: #selector(forgotPass), for: .touchUpInside)
        view.insertSubview(forgotPasswordButton, at: 0)
        
        //Dont have account button
        let dontHaveTitle = "Don't have an account? Sign up"
        let dontHaveAttributedString = NSMutableAttributedString(string: dontHaveTitle)

        // Set attributes for reg text
        let regularAttributes: [NSAttributedString.Key: Any] = [
            .font: UIFont(name: "Ubuntu-Regular", size: 12) ?? .systemFont(ofSize: 12, weight: .regular),
        ]
        dontHaveAttributedString.setAttributes(regularAttributes, range: NSRange(location: 0, length: 22))

        // Set attributes for semibold text
        let mediumAttributes: [NSAttributedString.Key: Any] = [
            .font: UIFont(name: "Ubuntu-Medium", size: 12) ?? .systemFont(ofSize: 12, weight: .regular),
            
        ]
        dontHaveAttributedString.setAttributes(mediumAttributes, range: NSRange(location: 23, length: 7))

        signUpButton.setAttributedTitle(dontHaveAttributedString, for: .normal)
        signUpButton.titleLabel?.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        signUpButton.translatesAutoresizingMaskIntoConstraints = false
        signUpButton.addTarget(self, action: #selector(signUp), for: .touchUpInside)
        view.insertSubview(signUpButton, at: 0)

        //set constraints
        setCons()
    }
    
    private func setCons(){
        NSLayoutConstraint.activate([
            
        //Login page Circle
            loginPageCircle.widthAnchor.constraint(equalToConstant: 380),
            loginPageCircle.heightAnchor.constraint(equalToConstant: 380),
            loginPageCircle.topAnchor.constraint(equalTo: view.topAnchor,constant: -49),
            loginPageCircle.leftAnchor.constraint(equalTo: view.leftAnchor,constant: -131),
            
            
        //set up sign in button
            signInButton.widthAnchor.constraint(equalToConstant: 90),
            signInButton.heightAnchor.constraint(equalToConstant: 45),
            signInButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor,constant: -52),
            signInButton.topAnchor.constraint(equalTo: loginLabel.bottomAnchor,constant:166),
            
        //set up the image view
            loginPagePic.heightAnchor.constraint(equalToConstant: 261.69),
            loginPagePic.widthAnchor.constraint(equalToConstant: 308),
            loginPagePic.topAnchor.constraint(equalTo: loginPageCircle.topAnchor,constant: 119),
            loginPagePic.leftAnchor.constraint(equalTo: loginPageCircle.leftAnchor,constant: 165),
            
        //set up the login label
            loginLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor,constant: -25),
            loginLabel.topAnchor.constraint(equalTo: loginPageCircle.bottomAnchor,constant: 61),
            
        //set up the email textfield
            email.topAnchor.constraint(equalTo: loginLabel.bottomAnchor, constant: 53),
            email.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor,constant: -50),
            email.widthAnchor.constraint(equalToConstant: 178),
            email.heightAnchor.constraint(equalToConstant: 30),
            
        //set up the email label
            emailLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor,constant: 61),
            emailLabel.topAnchor.constraint(equalTo: loginLabel.bottomAnchor,constant: 58.5),
            
        //set up the password textfield
            password.topAnchor.constraint(equalTo: loginLabel.bottomAnchor, constant: 97),
            password.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor,constant: -50),
            password.widthAnchor.constraint(equalToConstant: 178),
            password.heightAnchor.constraint(equalToConstant: 30),
            
        //set up the password label
            passwordLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor,constant: 61),
            passwordLabel.topAnchor.constraint(equalTo: loginLabel.bottomAnchor,constant: 101.5),
            
        //set up the forgot password button
            forgotPasswordButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor,constant: 61),
            forgotPasswordButton.topAnchor.constraint(equalTo: passwordLabel.bottomAnchor,constant: 10),
            
            //dont have account
            signUpButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            signUpButton.widthAnchor.constraint(equalToConstant: 172),
            signUpButton.heightAnchor.constraint(equalToConstant: 14),
            signUpButton.topAnchor.constraint(equalTo: signInButton.bottomAnchor,constant: 106),

        ])
    }
    
    //push the forgot password page
    @objc func forgotPass(){
        navigationController?.pushViewController(ForgotPasswordViewController(), animated: true)
    }
    
    //push the sign up page
    @objc func signUp(){
        navigationController?.pushViewController(CreateAccountViewController(), animated: true)
    }
    
    //present and create tab bar controllers
    @objc func signIn(){
        
        let loginRequest = LoginUserRequest(email: self.email.text ?? "", password: self.password.text ?? "" )
        
        
        //email check
        if !Validator.isValidEmail(for: loginRequest.email){
            AlertManager.showInvalidEmailAlert(on: self)
            return
        }
        
        //password check
        if !Validator.isPasswordValid(for: loginRequest.password){
            AlertManager.showInvalidPasswordAlert(on: self)
            return
        }
        
        
        
        NetworkManager.shared.loginUser(email: self.email.text!, password: self.password.text ?? "", completion: { userResponse in
            print("ok")
            ProfileViewController.backEndToken = userResponse.session_token
            AuthService.shared.signIn(with: loginRequest) { [weak self] error in
                
                guard let self = self else {return}
                
                if let error = error{
                    
                    AlertManager.showSigninErrorAlert(on: self, with: error)
                    return
                }
                if let sceneDelegate = self.view.window?.windowScene?.delegate as? SceneDelegate{
                    sceneDelegate.checkAuthentication()
                }else{
                    AlertManager.showSigninErrorAlert(on: self)
                }
            }
        })
        
    }
}
extension SignInViewController: UITextFieldDelegate{
    
     func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
 
    }

