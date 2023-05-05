//
//  EmailCodeViewController.swift
//  Housing and Pet
//
//  Created by Wei Zheng on 5/4/23.
//

import UIKit

import UIKit

class EmailCodeViewController: UIViewController {
    
    let signUpPageCircle = UIView()
    let signUpPagePic = UIImageView()
    let forgotPassLabel = UILabel()
    let backToLoginButton = UIButton()
    let email = PaddedTextField()
    let nextButton = UIButton()
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
        forgotPassLabel.text = "Enter the confirmation code"
        forgotPassLabel.textColor = UIColor(red: 0.07, green: 0.07, blue: 0.07, alpha: 1.0)
        forgotPassLabel.font = UIFont(name: "Ubuntu-Medium", size: 18)
        forgotPassLabel.translatesAutoresizingMaskIntoConstraints = false
        view.insertSubview(forgotPassLabel, at: 0)
        
        //Email field
        let emailFieldPlaceHolderText = "Enter code"
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
        nextButton.addTarget(self, action: #selector(emailVeri), for: .touchUpInside)
        view.insertSubview(nextButton, at: 0)
        
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
            
            //set up next button
            nextButton.widthAnchor.constraint(equalToConstant: 81),
            nextButton.heightAnchor.constraint(equalToConstant: 45),
            nextButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor,constant: -52),
            nextButton.topAnchor.constraint(equalTo: email.bottomAnchor,constant:60),
            
            //backto Label
            backtoLabel.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor,constant: -30),
            backtoLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor,constant: -30),
        ])
    }
    
    @objc private func emailVeri(){
        navigationController?.pushViewController(EmailVerificationViewController(), animated: true)
    
    
    }
     @objc private func backToLogin(){
        navigationController?.pushViewController(SignInViewController(), animated: true)
    }

}
extension EmailCodeViewController: UITextFieldDelegate{
    
     func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
 
    }
