//
//  CheckEmailViewController.swift
//  Housing and Pet
//
//  Created by Wei Zheng on 4/30/23.
//

import UIKit

class CheckEmailViewController: UIViewController {
    
    let checkEmailLabel = UILabel()
    let backtoLabel = UILabel()
    let backToLoginButton = UIButton()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.hidesBackButton = true
        view.backgroundColor = .white
        
        //check email label
        checkEmailLabel.textColor = .black
        checkEmailLabel.font = .systemFont(ofSize: 40,weight: .bold)
        checkEmailLabel.text = "Check Your Email"
        checkEmailLabel.translatesAutoresizingMaskIntoConstraints = false
        view.insertSubview(checkEmailLabel, at: 0)
        
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
        
        //set uo backto label
        backtoLabel.text = "Back to"
        backtoLabel.font = .systemFont(ofSize: 10)
        backtoLabel.textColor = .black
        backtoLabel.translatesAutoresizingMaskIntoConstraints = false
        view.insertSubview(backtoLabel, at: 0)
        
        setCons()
    }
    
    func setCons(){
        NSLayoutConstraint.activate([
            
            //check email label
            checkEmailLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            checkEmailLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor,constant: 200),
        
            //back to login
            backToLoginButton.leadingAnchor.constraint(equalTo: backtoLabel.trailingAnchor,constant: 2),
            backToLoginButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor,constant: -23),
            
            //backto Label
            backtoLabel.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor,constant: -30),
            backtoLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor,constant: -30),
            
        ])
    }
    @objc func backToLogin(){
        navigationController?.pushViewController(SignInViewController(), animated: true)
    }
    


}
