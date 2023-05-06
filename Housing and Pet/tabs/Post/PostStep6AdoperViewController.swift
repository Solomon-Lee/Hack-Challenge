//
//  PostStep6AdoperViewController.swift
//  Housing and Pet
//
//  Created by Wei Zheng on 5/3/23.
//

import UIKit

class PostStep6AdoperViewController: UIViewController {

    let bigPic = UIImageView()
    var imageArray = [UIImage]()
    let bottomLine = UIImageView()
    let cancelButton = UIButton()
    let nextButton = UIButton()
    let PetName = UILabel()
    let ageAndGender = UILabel()
    let catAndBred = UILabel()
    let mapPic = UIImageView()
    let location = UILabel()
    let calPic = UIImageView()
    let time = UILabel()
    let infoTextView = UITextView()
    let bigPicLabel = UIButton()
    let aboutPetLabel = UILabel()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        bigPic.backgroundColor = UIColor(red: 0.85, green: 0.85, blue: 0.85, alpha: 0.6)
        bigPic.image = PostStep3AdopterViewController.bigPic.image
        bigPicLabel.setTitle(PostStep3AdopterViewController.bigPicLabel.titleLabel?.text, for: .normal)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        navigationItem.hidesBackButton = true
        navigationController?.navigationBar.isHidden = true
        
        //big pic
        imageArray = [UIImage(),UIImage(),UIImage(),UIImage(),UIImage()]
        bigPic.clipsToBounds = true
        bigPic.backgroundColor = UIColor(red: 0.85, green: 0.85, blue: 0.85, alpha: 0.6)
        bigPic.translatesAutoresizingMaskIntoConstraints = false
        bigPic.layer.cornerRadius = 30
        view.insertSubview(bigPic, at: 0)
        
        //bigPic Label
        bigPicLabel.titleLabel?.font = UIFont(name: "Ubuntu-Regular", size: 14)
        bigPicLabel.translatesAutoresizingMaskIntoConstraints = false
        bigPicLabel.setTitleColor(UIColor(red: 1, green: 1, blue: 1, alpha: 1), for: .normal)
        bigPicLabel.clipsToBounds = true
        bigPicLabel.layer.cornerRadius = 15
        bigPicLabel.layer.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1).cgColor
        view.insertSubview(bigPicLabel, at: 1)
        
        //bottom line
        bottomLine.image = UIImage(named: "postPagesLine")
        bottomLine.translatesAutoresizingMaskIntoConstraints = false
        view.insertSubview(bottomLine, at: 0)
        
        //exitbutton
        cancelButton.setTitle("Cancel", for: .normal)
        cancelButton.setTitleColor(UIColor(red: 0, green: 0, blue: 0, alpha: 1), for: .normal)
        cancelButton.titleLabel?.font = UIFont(name: "Ubuntu-Medium", size: 18)
        cancelButton.translatesAutoresizingMaskIntoConstraints = false
        cancelButton.addTarget(self, action: #selector(xbutton), for: .touchUpInside)
        view.insertSubview(cancelButton, at: 1)
        
        //next button
        let nextButtonTitle = "Submit"
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
        
        //pet name
        PetName.text = PostStep2AdopterViewController.nameField.text!
        PetName.textColor = UIColor(red: 0.12, green: 0.12, blue: 0.123, alpha: 1)
        PetName.font = UIFont(name: "Ubuntu-Medium", size: 30)
        PetName.translatesAutoresizingMaskIntoConstraints = false
        view.insertSubview(PetName, at: 0)
        
        //set up age and gender
        ageAndGender.text = "Age: \(PostStep2AdopterViewController.ageField.text!) | \(PostStep2AdopterViewController.genderField.text!)"
        ageAndGender.textColor = UIColor(red: 0.12, green: 0.12, blue: 0.13, alpha: 1)
        ageAndGender.font = UIFont(name: "Ubuntu-Regular", size: 18)
        ageAndGender.translatesAutoresizingMaskIntoConstraints = false
        view.insertSubview(ageAndGender, at: 0)
        
        //set up category and breed
        catAndBred.text = "\(PostStep2AdopterViewController.categoryField.text!) | \(PostStep2AdopterViewController.breedField.text!)"
        catAndBred.textColor = UIColor(red: 0.12, green: 0.12, blue: 0.13, alpha: 1)
        catAndBred.font = UIFont(name: "Ubuntu-Regular", size: 18)
        catAndBred.translatesAutoresizingMaskIntoConstraints = false
        view.insertSubview(catAndBred, at: 0)
        
        //set up the map pin
        mapPic.image = UIImage(named: "map-pin2")
        mapPic.translatesAutoresizingMaskIntoConstraints = false
        view.insertSubview(mapPic, at: 0)
        
        //location
        
        if PostStep2AdopterViewController.onCampusButton.backgroundColor == UIColor(red: 0.12, green: 0.12, blue: 0.13, alpha: 1){
            location.text = "On-Campus"
        }
        
        if PostStep2AdopterViewController.offCampusButton.backgroundColor == UIColor(red: 0.12, green: 0.12, blue: 0.13, alpha: 1){
            location.text = "Off-Campus | Ithaca "
        }
        
        if PostStep2AdopterViewController.outsideIthacaButton.backgroundColor == UIColor(red: 0.12, green: 0.12, blue: 0.13, alpha: 1){
            location.text = "Outside Ithaca"
        }
        
        location.font = UIFont(name: "Ubuntu-Regular", size: 18)
        location.textColor = UIColor(red: 0.12, green: 0.12, blue: 0.13, alpha: 1)
        location.translatesAutoresizingMaskIntoConstraints = false
        view.insertSubview(location, at: 0)
        
        //calendar pic
        calPic.image = UIImage(named: "calendar2")
        calPic.translatesAutoresizingMaskIntoConstraints = false
        view.insertSubview(calPic, at: 0)
        
        //time
        time.text = "Need an adopter by \(PostStep2AdopterViewController.durationEndField.text!)"
        time.font = UIFont(name: "Ubuntu-Regular", size: 18)
        time.textColor = UIColor(red: 0.12, green: 0.12, blue: 0.13, alpha: 1)
        time.translatesAutoresizingMaskIntoConstraints = false
        view.insertSubview(time, at: 0)
        
        //info textview
        infoTextView.text = PostStep4AdopterViewController.step4TextView.text!
        infoTextView.isEditable = false
        infoTextView.translatesAutoresizingMaskIntoConstraints = false
        infoTextView.textColor = UIColor(red: 0.12, green: 0.12, blue: 0.13, alpha: 1)
        infoTextView.font = UIFont(name: "Ubuntu-Regular", size: 14)
        infoTextView.layer.cornerRadius = 30
        infoTextView.textContainerInset = UIEdgeInsets(top: 70, left: 33, bottom: -10, right: -40)
        infoTextView.layer.borderColor = UIColor(red: 0.12, green: 0.12, blue: 0.13, alpha: 1).cgColor
        infoTextView.layer.borderWidth = 2
        view.insertSubview(infoTextView, at: 0)
        
        //about pet Label
        aboutPetLabel.text = "About the pet"
        aboutPetLabel.font = UIFont(name: "Ubuntu-Medium", size: 25)
        aboutPetLabel.textColor = UIColor(red: 0.12, green: 0.12, blue: 0.13, alpha: 1)
        aboutPetLabel.translatesAutoresizingMaskIntoConstraints = false
        view.insertSubview(aboutPetLabel, at: 1)
        
        //constraints
        setCons()
    }
    
    @objc private func xbutton(){
        self.tabBarController?.selectedIndex = 0
        self.tabBarController?.tabBar.isHidden = false
        navigationController?.setViewControllers([PostViewController()], animated: true)
    }
    
    @objc private func nextClicked(){
        navigationController?.pushViewController(CongratsViewController(), animated: true)
    }
    
    private func setCons(){
        NSLayoutConstraint.activate([
        
            //big pic
            bigPic.widthAnchor.constraint(equalToConstant: 342),
            bigPic.heightAnchor.constraint(equalToConstant: 262),
            bigPic.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            bigPic.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            
            //big pic label
            bigPicLabel.bottomAnchor.constraint(equalTo: bigPic.bottomAnchor,constant: -17),
            bigPicLabel.trailingAnchor.constraint(equalTo: bigPic.trailingAnchor,constant: -15),
            bigPicLabel.widthAnchor.constraint(equalToConstant: 50),
            bigPicLabel.heightAnchor.constraint(equalToConstant: 30),
            
            //bottom line
            bottomLine.leftAnchor.constraint(equalTo: view.leftAnchor),
            bottomLine.rightAnchor.constraint(equalTo: view.rightAnchor),
            bottomLine.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            bottomLine.heightAnchor.constraint(equalToConstant: 60),
            
            //cancel button
            cancelButton.centerYAnchor.constraint(equalTo: bottomLine.centerYAnchor),
            cancelButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor,constant: 64),
            cancelButton.widthAnchor.constraint(equalToConstant: 57),
            cancelButton.heightAnchor.constraint(equalToConstant: 21),
            
            //next button
            nextButton.widthAnchor.constraint(equalToConstant: 81),
            nextButton.heightAnchor.constraint(equalToConstant: 41),
            nextButton.centerYAnchor.constraint(equalTo: bottomLine.centerYAnchor,constant: 3),
            nextButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor,constant: -57),
            
            //pet name
            PetName.topAnchor.constraint(equalTo: bigPic.bottomAnchor,constant: 38),
            PetName.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor,constant: 45),
            
            //age and gender
            ageAndGender.topAnchor.constraint(equalTo: PetName.bottomAnchor,constant: 25),
            ageAndGender.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor,constant: 45),
            
            //category and breed
            catAndBred.topAnchor.constraint(equalTo: ageAndGender.bottomAnchor,constant: 9.6),
            catAndBred.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor,constant: 45),
            
            //map pin
            mapPic.widthAnchor.constraint(equalToConstant: 24),
            mapPic.heightAnchor.constraint(equalToConstant: 24),
            mapPic.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor,constant: 45),
            mapPic.topAnchor.constraint(equalTo: catAndBred.bottomAnchor,constant: 9.6),
            
            //location
            location.centerYAnchor.constraint(equalTo: mapPic.centerYAnchor),
            location.leadingAnchor.constraint(equalTo: mapPic.trailingAnchor,constant: 13),
            
            //calendar pin
            calPic.widthAnchor.constraint(equalToConstant: 24),
            calPic.heightAnchor.constraint(equalToConstant: 24),
            calPic.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor,constant: 45),
            calPic.topAnchor.constraint(equalTo: mapPic.bottomAnchor,constant: 10.6),
            
            //time
            time.centerYAnchor.constraint(equalTo: calPic.centerYAnchor),
            time.leadingAnchor.constraint(equalTo: calPic.trailingAnchor,constant: 10),
            
            //info textview
            infoTextView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            infoTextView.topAnchor.constraint(equalTo: time.bottomAnchor,constant: 40),
            infoTextView.widthAnchor.constraint(equalToConstant: 342),
            infoTextView.heightAnchor.constraint(equalToConstant: 157),
            
            //about pet label
            aboutPetLabel.topAnchor.constraint(equalTo: infoTextView.topAnchor,constant: 20),
            aboutPetLabel.leadingAnchor.constraint(equalTo: infoTextView.leadingAnchor,constant: 40),
            
        ])
    }
    

  
}
