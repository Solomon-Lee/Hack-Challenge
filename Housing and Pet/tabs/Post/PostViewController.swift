//
//  PostViewController.swift
//  Housing and Pet
//
//  Created by Wei Zheng on 4/29/23.
//

import UIKit

class PostViewController: UIViewController {
    
    let cancelButton = UIButton()
    let step1Label = UILabel()
    let sitterButton = UIButton()
    let adopterButton = UIButton()
    let bottomLine = UIImageView()
    let nextButton = UIButton()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.tabBarController?.tabBar.isHidden = true
        adopterButton.setTitleColor(UIColor(red: 0.12, green: 0.12, blue: 0.13, alpha: 1), for: .normal)
        adopterButton.backgroundColor = .white
        sitterButton.setTitleColor(UIColor(red: 0.12, green: 0.12, blue: 0.13, alpha: 1), for: .normal)
        sitterButton.backgroundColor = .white
        
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        view.backgroundColor = .white
        navigationItem.hidesBackButton = true
        
        //exitbutton
        cancelButton.setTitle("Cancel", for: .normal)
        cancelButton.setTitleColor(UIColor(red: 0, green: 0, blue: 0, alpha: 1), for: .normal)
        cancelButton.titleLabel?.font = UIFont(name: "Ubuntu-Medium", size: 18)
        cancelButton.translatesAutoresizingMaskIntoConstraints = false
        cancelButton.addTarget(self, action: #selector(xbutton), for: .touchUpInside)
        view.insertSubview(cancelButton, at: 1)
        
        //Step1 Label
        let step1Text = NSMutableAttributedString()

        let firstLine = NSAttributedString(string: "Step 1", attributes: [
            .font: UIFont(name: "Ubuntu-Medium", size: 40.0)!
        ])

        let thirdLine = NSAttributedString(string: "Tell us about your", attributes: [
            .font: UIFont(name: "Ubuntu-Medium", size: 30.0)!
        ])

        let fourthLine = NSAttributedString(string: "needs", attributes: [
            .font: UIFont(name: "Ubuntu-Medium", size: 30.0)!
        ])


        step1Text.append(firstLine)
        step1Text.append(NSAttributedString(string: "\n"))
        step1Text.append(NSAttributedString(string: "\n"))
        step1Text.append(NSAttributedString(string: "\n"))
        step1Text.append(thirdLine)
        step1Text.append(NSAttributedString(string: "\n"))
        step1Text.append(fourthLine)
        
        step1Label.numberOfLines = 5
        step1Label.attributedText = step1Text
        step1Label.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        step1Label.translatesAutoresizingMaskIntoConstraints = false
        view.insertSubview(step1Label, at: 0)
        
        //sitter label
        sitterButton.setTitle("I am looking for a pet sitter", for: .normal)
        sitterButton.titleLabel?.font = UIFont(name: "Ubuntu-Medium", size: 18)
        sitterButton.setTitleColor(UIColor(red: 0.12, green: 0.12, blue: 0.13, alpha: 1), for: .normal)
        sitterButton.translatesAutoresizingMaskIntoConstraints = false
        sitterButton.clipsToBounds = true
        sitterButton.layer.cornerRadius = 20
        sitterButton.backgroundColor = .white
        sitterButton.layer.borderColor = UIColor(red: 0.12, green: 0.12, blue: 0.13, alpha: 1).cgColor
        sitterButton.addTarget(self, action: #selector(sitterClicked), for: .touchUpInside)
        sitterButton.layer.borderWidth = 2
        view.insertSubview(sitterButton, at: 0)
        
        //adopter button
        adopterButton.setTitle("I want an adopter", for: .normal)
        adopterButton.titleLabel?.font = UIFont(name: "Ubuntu-Medium", size: 18)
        adopterButton.setTitleColor(UIColor(red: 0.12, green: 0.12, blue: 0.13, alpha: 1), for: .normal)
        adopterButton.translatesAutoresizingMaskIntoConstraints = false
        adopterButton.clipsToBounds = true
        adopterButton.addTarget(self, action: #selector(adopterClicked), for: .touchUpInside)
        adopterButton.layer.cornerRadius = 20
        adopterButton.backgroundColor = .white
        adopterButton.layer.borderColor = UIColor(red: 0.12, green: 0.12, blue: 0.13, alpha: 1).cgColor
        adopterButton.layer.borderWidth = 2
        view.insertSubview(adopterButton, at: 0)
        
        //bottom line
        bottomLine.image = UIImage(named: "postPagesLine")
        bottomLine.translatesAutoresizingMaskIntoConstraints = false
        view.insertSubview(bottomLine, at: 0)
        
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
        nextButton.addTarget(self, action: #selector(nextClicked), for: .touchUpInside)
        view.insertSubview(nextButton, at: 1)
        
        //set constraints
        setCons()
        
    }
    
    @objc private func sitterClicked(){
        sitterButton.backgroundColor = UIColor(red: 0.12, green: 0.12, blue: 0.13, alpha: 1)
        sitterButton.setTitleColor(.white, for: .normal)
        adopterButton.backgroundColor = .white
        adopterButton.setTitleColor(UIColor(red: 0.12, green: 0.12, blue: 0.13, alpha: 1), for: .normal)
        
    }
    
    @objc private func adopterClicked(){
        adopterButton.backgroundColor = UIColor(red: 0.12, green: 0.12, blue: 0.13, alpha: 1)
        adopterButton.setTitleColor(.white, for: .normal)
        sitterButton.backgroundColor = .white
        sitterButton.setTitleColor(UIColor(red: 0.12, green: 0.12, blue: 0.13, alpha: 1), for: .normal)
    }
    
    @objc private func nextClicked(){
        if adopterButton.backgroundColor == UIColor(red: 0.12, green: 0.12, blue: 0.13, alpha: 1){
            navigationController?.pushViewController(PostStep2AdopterViewController(), animated: true)
        }
        else if sitterButton.backgroundColor == UIColor(red: 0.12, green: 0.12, blue: 0.13, alpha: 1){
            navigationController?.pushViewController(PostStep2SitterViewController(), animated: true)
        }
        else{
            return
        }
    }
    
    @objc private func xbutton(){
        self.tabBarController?.selectedIndex = 0
        self.tabBarController?.tabBar.isHidden = false
        
    }
    
    private func setCons(){
        NSLayoutConstraint.activate([
            
            //cancel button
            cancelButton.centerYAnchor.constraint(equalTo: bottomLine.centerYAnchor),
            cancelButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor,constant: 64),
            cancelButton.widthAnchor.constraint(equalToConstant: 57),
            cancelButton.heightAnchor.constraint(equalToConstant: 21),
           
            //Step1
            step1Label.topAnchor.constraint(equalTo: view.topAnchor,constant: 166),
            step1Label.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 31),
            
            //sitter button
            sitterButton.widthAnchor.constraint(equalToConstant: 263),
            sitterButton.heightAnchor.constraint(equalToConstant: 45),
            sitterButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            sitterButton.topAnchor.constraint(equalTo: step1Label.bottomAnchor,constant: 64),
            
            //adopter button
            adopterButton.widthAnchor.constraint(equalToConstant: 184),
            adopterButton.heightAnchor.constraint(equalToConstant: 45),
            adopterButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            adopterButton.topAnchor.constraint(equalTo: sitterButton.bottomAnchor,constant: 16),
            
            //bottom line
            bottomLine.leftAnchor.constraint(equalTo: view.leftAnchor),
            bottomLine.rightAnchor.constraint(equalTo: view.rightAnchor),
            bottomLine.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            bottomLine.heightAnchor.constraint(equalToConstant: 60),
            
            
            //next button
            nextButton.widthAnchor.constraint(equalToConstant: 81),
            nextButton.heightAnchor.constraint(equalToConstant: 41),
            nextButton.centerYAnchor.constraint(equalTo: bottomLine.centerYAnchor,constant: 3),
            nextButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor,constant: -57),
        ])
        
    }
    
    


}
