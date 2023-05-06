//
//  WelcomeViewController.swift
//  Housing and Pet
//
//  Created by Wei Zheng on 5/1/23.
//

import UIKit

class WelcomeViewController: UIViewController {

    let backgroundCircle = UIView()
    let welcomePic = UIImageView()
    let welcomeLabel = UILabel()
    let loginEmailBut = UIButton()
    let dontHaveAccoutButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 0.91, green: 0.91, blue: 0.91, alpha: 1.0)
        
        //backgrund circle
        backgroundCircle.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
        backgroundCircle.layer.cornerRadius = 449/2
        backgroundCircle.clipsToBounds = true
        backgroundCircle.translatesAutoresizingMaskIntoConstraints = false
        view.insertSubview(backgroundCircle, at: 0)
        
        //Welcome pic
        welcomePic.image = UIImage(named: "welcomePic")
        welcomePic.translatesAutoresizingMaskIntoConstraints = false
        view.insertSubview(welcomePic, at: 1)
        
        //Welcome Label
        welcomeLabel.numberOfLines = 2
        welcomeLabel.text = "Welcome to\nPetPal"
        welcomeLabel.font = UIFont(name: "Ubuntu-Medium", size: 40)
        welcomeLabel.translatesAutoresizingMaskIntoConstraints = false
        welcomeLabel.textColor = UIColor(red: 0.12, green: 0.12, blue: 0.13, alpha: 1.0)
        view.insertSubview(welcomeLabel, at: 0)
        
        //login button
        let loginButtonTitle = "Login with Email"
        let strokeTextAttributes: [NSAttributedString.Key: Any] = [
            .strokeColor: UIColor.white,
            .foregroundColor: UIColor.white,
            .strokeWidth: -1.0,
            .font: UIFont(name: "Ubuntu-Medium", size: 18) ?? .systemFont(ofSize: 18, weight: .regular),
            
        ]
        let loginAttributedTitle = NSAttributedString(string: loginButtonTitle, attributes: strokeTextAttributes)
        loginEmailBut.translatesAutoresizingMaskIntoConstraints = false
        loginEmailBut.backgroundColor = UIColor(red: 0.12, green: 0.12, blue: 0.13, alpha: 1)
        loginEmailBut.clipsToBounds = true
        loginEmailBut.layer.cornerRadius = 20
        loginEmailBut.setAttributedTitle(loginAttributedTitle, for: .normal)
        loginEmailBut.titleLabel?.textColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
        loginEmailBut.titleLabel?.textAlignment = .center
        loginEmailBut.addTarget(self, action: #selector(loginButtonFunc), for: .touchUpInside)
        view.insertSubview(loginEmailBut, at: 0)
        
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

        dontHaveAccoutButton.setAttributedTitle(dontHaveAttributedString, for: .normal)
        dontHaveAccoutButton.titleLabel?.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        dontHaveAccoutButton.translatesAutoresizingMaskIntoConstraints = false
        dontHaveAccoutButton.addTarget(self, action: #selector(signupButtonFunc), for: .touchUpInside)
        view.insertSubview(dontHaveAccoutButton, at: 0)
        setCons()
    }
    
    @objc private func loginButtonFunc(){
        navigationController?.pushViewController(SignInViewController(), animated: true)
    }
    
    @objc private func signupButtonFunc(){
        navigationController?.pushViewController(CreateAccountViewController(), animated: true)
    }
    
    private func setCons(){
        NSLayoutConstraint.activate([
            
            //background circle
            backgroundCircle.widthAnchor.constraint(equalToConstant: 449),
            backgroundCircle.heightAnchor.constraint(equalToConstant: 449),
            backgroundCircle.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            backgroundCircle.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor,constant: 37),
            
            //welcome pic
            welcomePic.topAnchor.constraint(equalTo: backgroundCircle.topAnchor,constant: 117),
            welcomePic.leftAnchor.constraint(equalTo: backgroundCircle.leftAnchor,constant: 62),
            welcomePic.widthAnchor.constraint(equalToConstant: 233),
            welcomePic.heightAnchor.constraint(equalToConstant: 274),
            
            //welcome label
            welcomeLabel.topAnchor.constraint(equalTo: backgroundCircle.bottomAnchor,constant: 26),
            welcomeLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor,constant: 48),
            
            //login email but
            loginEmailBut.topAnchor.constraint(equalTo: welcomeLabel.bottomAnchor,constant: 33),
            loginEmailBut.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loginEmailBut.widthAnchor.constraint(equalToConstant: 180),
            loginEmailBut.heightAnchor.constraint(equalToConstant: 45),
            
            //dont have account
            dontHaveAccoutButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            dontHaveAccoutButton.widthAnchor.constraint(equalToConstant: 172),
            dontHaveAccoutButton.heightAnchor.constraint(equalToConstant: 14),
            dontHaveAccoutButton.topAnchor.constraint(equalTo: loginEmailBut.bottomAnchor,constant: 9),
            
        ])
    }
    


}
