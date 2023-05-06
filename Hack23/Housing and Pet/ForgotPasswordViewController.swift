//
//  ForgotPasswordViewController.swift
//  Housing and Pet
//
//  Created by Wei Zheng on 4/30/23.
//

import UIKit

class ForgotPasswordViewController: UIViewController {
    
    let signUpPageCircle = UIView()
    let signUpPagePic = UIImageView()
    let forgotPassLabel = UILabel()
    let backToLoginButton = UIButton()
    let email = PaddedTextField()
    let sendReset = UIButton()
    let backtoLabel = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
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
        
        //back to login button
        backToLoginButton.setTitleColor(.black, for: .normal)
        let backToLoginattributedString = NSAttributedString(string: "Login", attributes: [
            .underlineStyle: NSUnderlineStyle.single.rawValue
        ])
        backToLoginButton.setAttributedTitle(backToLoginattributedString, for: .normal)
        backToLoginButton.titleLabel?.font = .systemFont(ofSize: 15)
        backToLoginButton.translatesAutoresizingMaskIntoConstraints = false
        backToLoginButton.addTarget(self, action: #selector(backToLogin), for: .touchUpInside)
        view.insertSubview(backToLoginButton, at: 0)
        
        //Forgot pass label
        forgotPassLabel.text = "Forgot Password"
        forgotPassLabel.textColor = UIColor(red: 0.07, green: 0.07, blue: 0.07, alpha: 1.0)
        forgotPassLabel.font = UIFont(name: "Ubuntu-Medium", size: 18)
        forgotPassLabel.translatesAutoresizingMaskIntoConstraints = false
        view.insertSubview(forgotPassLabel, at: 0)
        
        //Email field
        let emailFieldPlaceHolderText = "Enter email address"
        let emailFieldTextAttributes: [NSAttributedString.Key: Any] = [
            .font: UIFont(name: "Ubuntu-Regular", size: 14) ?? .systemFont(ofSize: 14, weight: .regular),
            .foregroundColor: UIColor(red: 0.48, green: 0.49, blue: 0.53, alpha: 1),
        ]
        let emailFieldAttributedTitle = NSAttributedString(string: emailFieldPlaceHolderText, attributes: emailFieldTextAttributes)
        email.translatesAutoresizingMaskIntoConstraints = false
        email.attributedPlaceholder = emailFieldAttributedTitle
        email.delegate = self
        email.textColor = UIColor(red: 0.07, green: 0.07, blue: 0.07, alpha: 1.0)
        email.autocapitalizationType = .none
        email.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
        email.layer.borderColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1).cgColor
        email.autocorrectionType = .no
        email.layer.borderWidth = 2
        email.font = UIFont(name: "Ubuntu-Regular", size: 14)
        email.clipsToBounds = true
        email.layer.cornerRadius = 15
        email.textAlignment = .center
        email.autocapitalizationType = .none
        email.delegate = self
        view.insertSubview(email, at: 0)
        
        //send reset button
        sendReset.setTitle("Send Reset Link", for: .normal)
        sendReset.backgroundColor = .black
        sendReset.setTitleColor(.white, for: .normal)
        sendReset.clipsToBounds = true
        sendReset.layer.cornerRadius = 25
        sendReset.translatesAutoresizingMaskIntoConstraints = false
        sendReset.addTarget(self, action: #selector(sendResetLink), for: .touchUpInside)
        view.insertSubview(sendReset, at: 0)
        
        //set uo backto label
        backtoLabel.text = "Back to"
        backtoLabel.font = .systemFont(ofSize: 10)
        backtoLabel.textColor = .black
        backtoLabel.translatesAutoresizingMaskIntoConstraints = false
        view.insertSubview(backtoLabel, at: 0)

        setCons()
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
            
            //back to login
            backToLoginButton.leadingAnchor.constraint(equalTo: backtoLabel.trailingAnchor,constant: 2),
            backToLoginButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor,constant: -23),
        
            //forgot pass label
            forgotPassLabel.topAnchor.constraint(equalTo: signUpPageCircle.bottomAnchor,constant: 137.5),
            forgotPassLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            //set up the email textfield
            email.topAnchor.constraint(equalTo: forgotPassLabel.bottomAnchor, constant: 25.5),
            email.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            email.widthAnchor.constraint(equalToConstant: 272),
            email.heightAnchor.constraint(equalToConstant: 30),
            
            //resetPass button
            sendReset.widthAnchor.constraint(equalToConstant: 200),
            sendReset.heightAnchor.constraint(equalToConstant: 50),
            sendReset.topAnchor.constraint(equalTo: email.bottomAnchor,constant: 50),
            sendReset.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            //backto Label
            backtoLabel.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor,constant: -30),
            backtoLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor,constant: -30),
        ])
    }
    
    @objc private func sendResetLink(){
        
        let email = self.email.text ?? ""
        if !Validator.isValidEmail(for: email){
            AlertManager.showInvalidEmailAlert(on: self)
            return
        }
        
        AuthService.shared.forgotPassword(with: email) { [weak self] error in
            guard let self = self else {return}
            if let error = error{
                AlertManager.showErrorSendingPasswordReset(on: self, with: error)
                return
            }
            
            AlertManager.showPasswordResetSent(on: self)
            self.navigationController?.pushViewController(CheckEmailViewController(), animated: true)
        }
    
    }
     @objc private func backToLogin(){
        navigationController?.pushViewController(SignInViewController(), animated: true)
    }

}
extension ForgotPasswordViewController: UITextFieldDelegate{
    
     func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
 
    }
