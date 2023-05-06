//
//  EmailVerificationViewController.swift
//  Housing and Pet
//
//  Created by Wei Zheng on 4/30/23.
//

import UIKit

class EmailVerificationViewController: UIViewController {
    
    let emailConfPageCircle = UIView()
    let emailConfPagePic = UIImageView()
    let confLabel = UILabel()
    let nextButton = UIButton()
    let loginButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        navigationItem.hidesBackButton = true
        
        //sign up circle
        emailConfPageCircle.clipsToBounds = true
        emailConfPageCircle.layer.cornerRadius = 380/2
        emailConfPageCircle.translatesAutoresizingMaskIntoConstraints = false
        emailConfPageCircle.backgroundColor = UIColor(red: 0.91, green: 0.91, blue: 0.91, alpha: 1)
        view.insertSubview(emailConfPageCircle, at: 0)
        
        //pic
        emailConfPagePic.image = UIImage(named: "signupPic")
        emailConfPagePic.translatesAutoresizingMaskIntoConstraints = false
        view.insertSubview(emailConfPagePic, at: 1)
        
        //Email conf label
        confLabel.numberOfLines = 2
        confLabel.text = "Email Address\n Confirmed!"
        confLabel.font = UIFont(name: "Ubuntu-Medium", size: 40)
        confLabel.translatesAutoresizingMaskIntoConstraints = false
        confLabel.textColor = UIColor(red: 0.12, green: 0.12, blue: 0.13, alpha: 1.0)
        view.insertSubview(confLabel, at: 0)
        
        
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
        nextButton.addTarget(self, action: #selector(passwordSetUp), for: .touchUpInside)
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
        
        //set constraints
        setCons()
    }
    
    @objc func passwordSetUp(){
        navigationController?.pushViewController(PasswordSetupViewController(), animated: true)
    }
    @objc private func login(){
        navigationController?.pushViewController(SignInViewController(), animated: true)
    }
    
    func setCons(){
        NSLayoutConstraint.activate([
        
            //set up email conf circle
            emailConfPageCircle.topAnchor.constraint(equalTo: view.topAnchor,constant: -122),
            emailConfPageCircle.rightAnchor.constraint(equalTo: view.rightAnchor,constant: 65),
            emailConfPageCircle.widthAnchor.constraint(equalToConstant: 380),
            emailConfPageCircle.heightAnchor.constraint(equalToConstant: 380),
            
            //set up the image view
            emailConfPagePic.widthAnchor.constraint(equalToConstant: 326.18),
            emailConfPagePic.heightAnchor.constraint(equalToConstant: 261),
            emailConfPagePic.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            emailConfPagePic.topAnchor.constraint(equalTo: emailConfPageCircle.topAnchor,constant: 189),
            
            //set up the enter code label
            confLabel.topAnchor.constraint(equalTo: emailConfPageCircle.bottomAnchor,constant: 134),
            confLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            
            //set up next button
            nextButton.widthAnchor.constraint(equalToConstant: 81),
            nextButton.heightAnchor.constraint(equalToConstant: 45),
            nextButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor,constant: -52),
            nextButton.topAnchor.constraint(equalTo: confLabel.bottomAnchor,constant:60),
            
            //already have account
            loginButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loginButton.widthAnchor.constraint(equalToConstant: 176),
            loginButton.heightAnchor.constraint(equalToConstant: 14),
            loginButton.topAnchor.constraint(equalTo: nextButton.bottomAnchor,constant: 176),
        ])
    }
    


}

extension EmailVerificationViewController: UITextFieldDelegate{
    
     func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
 
    }
