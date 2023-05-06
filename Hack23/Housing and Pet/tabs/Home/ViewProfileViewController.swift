
//
//  ViewProfileViewController.swift
//  Housing and Pet
//
//  Created by Eman Abdu on 5/4/23.
//

import Foundation
import UIKit

class ViewProfileViewController2: UIViewController {
    let pet : PetCollectionViewCell
    var pView = UIImageView()
    var backButton = UIButton()
    var name = UILabel()
    var age = UILabel()
    var category = UILabel()
    var mapPic = UIImageView()
    var location = UILabel()
    var calendarPic = UIImageView()
    var number = UILabel()
    var owner = UIView()
    var ownerName = UILabel()
    var viewProfile = UIButton()
    var ownerNumber = UILabel()
    var ownerEmail = UILabel()
    var numPets = UILabel()
    var saveb = UIButton()
    var applyb = UIButton()
    var saved = false

    let configuration = UIImage.SymbolConfiguration(pointSize: 40)
    let userName = UILabel()
    let phoneNumber = UILabel()
    let email = UILabel()
    let image = UIImage(named: "profilePicTemp")
    var imageView = UIImageView()
    let profileButton = UIButton()
    let bottomLine = UIImageView()

    
    
    init?(pet : PetCollectionViewCell){
        self.pet = pet
        super.init(nibName: nil, bundle: nil)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.tabBarController?.tabBar.isHidden = true
        
    }
    
    override func viewDidLoad() {
        
        view.backgroundColor = .white
        navigationItem.hidesBackButton = true
        super.viewDidLoad()
        
        //pView
        pView.image = pet.imageView.image
        pView.frame = CGRect(x: 0, y: 0, width: 342, height: 262)
        pView.backgroundColor = .white
        pView.layer.backgroundColor = UIColor(red: 0.851, green: 0.851, blue: 0.851, alpha: 0.6).cgColor
        pView.clipsToBounds = true
        pView.translatesAutoresizingMaskIntoConstraints = false
        pView.layer.cornerRadius = 30
        pView.layer.borderWidth = 2.0
        pView.layer.borderColor = UIColor.black.cgColor
        view.addSubview(pView)
        
        //chevron
        let chevronImage = UIImage(systemName: "chevron.left")
        backButton.setImage(chevronImage, for: .normal)
        backButton.addTarget(self, action: #selector(editProfilePage), for: .touchUpInside)
        backButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(backButton)
        
        //name
        name.frame = CGRect(x: 0, y: 0, width: 82, height: 34)
        name.backgroundColor = .white
        name.textColor = UIColor(red: 0.118, green: 0.118, blue: 0.125, alpha: 1)
        name.font = UIFont(name: "Ubuntu-Medium", size: 30)
        name.text = self.pet.nameLabel.text
        name.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(name)
        
        //age
        age.frame = CGRect(x: 0, y: 0, width: 104, height: 21)
        age.backgroundColor = .white
        age.textColor = UIColor(red: 0.118, green: 0.118, blue: 0.125, alpha: 1)
        age.font = UIFont(name: "Ubuntu-Regular", size: 18)
        age.attributedText = NSMutableAttributedString(string: (self.pet.age.text ?? "Age") + ("| Gender"), attributes: [NSAttributedString.Key.kern: -0.18])
        view.addSubview(age)
        age.translatesAutoresizingMaskIntoConstraints = false
        
        //category
        category.frame = CGRect(x: 0, y: 0, width: 135, height: 21)
        category.backgroundColor = .white
        category.textColor = UIColor(red: 0.118, green: 0.118, blue: 0.125, alpha: 1)
        category.font = UIFont(name: "Ubuntu-Regular", size: 18)
        category.attributedText = NSMutableAttributedString(string: (self.pet.species.text ?? "Category | Breed") , attributes: [NSAttributedString.Key.kern: -0.18])
        view.addSubview(category)
        category.translatesAutoresizingMaskIntoConstraints = false
        category.heightAnchor.constraint(equalToConstant: 21).isActive = true
        
        //mapPic
        mapPic.image = UIImage(named: "map-pin")
        mapPic.translatesAutoresizingMaskIntoConstraints = false
        view.insertSubview(mapPic, at: 0)
        
        //location
        location.frame = CGRect(x: 0, y: 0, width: 83, height: 21)
        location.backgroundColor = .white
        location.textColor = UIColor(red: 0.118, green: 0.118, blue: 0.125, alpha: 1)
        location.font = UIFont(name: "Ubuntu-Regular", size: 18)
        location.attributedText = NSMutableAttributedString(string: pet.time , attributes: [NSAttributedString.Key.kern: -0.18])
        location.translatesAutoresizingMaskIntoConstraints = false
        location.heightAnchor.constraint(equalToConstant: 21).isActive = true
        view.addSubview(location)
        
        //calendarPic
        calendarPic.image = UIImage(named: "calendar")
        calendarPic.translatesAutoresizingMaskIntoConstraints = false
        view.insertSubview(calendarPic, at: 0)
        
        //number
        number.frame = CGRect(x: 0, y: 0, width: 240, height: 21)
        number.backgroundColor = .white
        number.textColor = UIColor(red: 0.118, green: 0.118, blue: 0.125, alpha: 1)
        number.font = UIFont(name: "Ubuntu-Regular", size: 18)
        number.attributedText = NSMutableAttributedString(string: "Need an adopter by " + pet.time, attributes: [NSAttributedString.Key.kern: -0.18])
        number.translatesAutoresizingMaskIntoConstraints = false
        number.heightAnchor.constraint(equalToConstant: 21).isActive = true
        view.addSubview(number)
        
        // owner
        owner.frame = CGRect(x: 0, y: 0, width: 342, height: 202)
        owner.backgroundColor = .white
//        owner.layer.backgroundColor = UIColor(red: 0.851, green: 0.851, blue: 0.851, alpha: 0.6).cgColor
        owner.clipsToBounds = true
        owner.translatesAutoresizingMaskIntoConstraints = false
        owner.layer.borderWidth = 2.0
        owner.layer.borderColor = UIColor.black.cgColor
        owner.layer.cornerRadius = 30
        view.addSubview(owner)
        
        userName.font = UIFont(name: "Ubuntu-Medium", size: 25)
        userName.text = "Owner Name"       // PLACEHOLDER
        userName.translatesAutoresizingMaskIntoConstraints = false
        owner.addSubview(userName)
        
        phoneNumber.font = UIFont(name: "Ubuntu-Medium", size: 16)
        phoneNumber.textColor = .darkGray
        phoneNumber.text = "###-###-####"  //PLACEHOLDER
        phoneNumber.translatesAutoresizingMaskIntoConstraints = false
        owner.addSubview(phoneNumber)
        
        email.font = UIFont(name: "Ubuntu-Medium", size: 18)
        email.textColor = .darkGray
        email.text = "netid@cornell.edu"
        email.translatesAutoresizingMaskIntoConstraints = false
        owner.addSubview(email)
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "profilePicTemp")   //PLACEHOLDER
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 73/5
        owner.insertSubview(imageView, at: 0)
        owner.addSubview(imageView)
        
        profileButton.frame =  CGRect(x: 0, y: 10, width: profileButton.frame.width + 5, height: 30)
        profileButton.layer.cornerRadius = profileButton.frame.height / 2
        profileButton.layer.borderWidth = 1.0
        profileButton.clipsToBounds = true
        owner.addSubview(profileButton)
        profileButton.setTitleColor(UIColor.white, for: .normal)
        profileButton.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        profileButton.setTitle("View Profile", for: .normal)
        profileButton.backgroundColor = .black
        profileButton.translatesAutoresizingMaskIntoConstraints = false
        
        //bottom line
        bottomLine.image = UIImage(named: "postPagesLine")
        bottomLine.translatesAutoresizingMaskIntoConstraints = false
        view.insertSubview(bottomLine, at: 0)
        
        numPets.frame = CGRect(x: 0, y: 0, width: 121, height: 21)
        numPets.backgroundColor = .white

        numPets.textColor = UIColor(red: 0.118, green: 0.118, blue: 0.125, alpha: 1)
        numPets.font = UIFont(name: "Ubuntu-Regular", size: 18)
        // Line height: 21 pt
        // (identical to box height)
        numPets.attributedText = NSMutableAttributedString(string: "Reward", attributes: [NSAttributedString.Key.kern: -0.18])

        view.addSubview(numPets)
        numPets.translatesAutoresizingMaskIntoConstraints = false
        numPets.widthAnchor.constraint(equalToConstant: 121).isActive = true
        numPets.heightAnchor.constraint(equalToConstant: 21).isActive = true
        
        applyb.frame = CGRect(x: 0, y: 0, width: 143, height: 45)
        applyb.backgroundColor = .white

        applyb.layer.backgroundColor = UIColor(red: 0.118, green: 0.118, blue: 0.125, alpha: 1).cgColor
        applyb.layer.cornerRadius = 25
        applyb.setAttributedTitle(NSMutableAttributedString(string: "Be the sitter", attributes: [NSAttributedString.Key.kern: -0.18]), for: .normal)
        applyb.addTarget(self, action: #selector(showDetails), for: .touchUpInside)
        applyb.setTitleColor(.white, for: .normal)

        view.addSubview(applyb)
        applyb.translatesAutoresizingMaskIntoConstraints = false
        applyb.widthAnchor.constraint(equalToConstant: 143).isActive = true
        applyb.heightAnchor.constraint(equalToConstant: 45).isActive = true
        
        if (self.pet.saved == false) {
            saveb.setImage(UIImage(systemName: "bookmark.circle.fill")?.withTintColor(.black, renderingMode: .alwaysOriginal).withConfiguration(configuration), for: .normal)
        } else {
                self.saved = true
                saveb.setImage(UIImage(systemName: "bookmark.circle.fill")?.withRenderingMode(.alwaysOriginal).withConfiguration(configuration), for: .normal)
                saveb.setImage(UIImage(systemName: "bookmark.circle.fill")?.withRenderingMode(.alwaysOriginal).withConfiguration(configuration), for: .normal)
            }
        saveb.contentMode = .scaleAspectFit
        saveb.translatesAutoresizingMaskIntoConstraints = false
        saveb.addTarget(self, action: #selector(changeColor), for: .touchUpInside)
        view.addSubview(saveb)
        
        setUpConstraints()
    }
    
    @objc func showDetails() {
        navigationController?.pushViewController(TaskViewController(), animated: true)
    }
    
    @objc func changeColor() {
        if (self.saved == false) {
            saveb.setImage(UIImage(systemName: "bookmark.circle.fill")?.withRenderingMode(.alwaysOriginal).withConfiguration(configuration), for: .normal)
            self.pet.saveb.setImage(UIImage(systemName: "bookmark.circle.fill")?.withRenderingMode(.alwaysOriginal).withConfiguration(UIImage.SymbolConfiguration(pointSize: 30)), for: .normal)
            self.saved = true
            self.pet.saved = true
        }
        else {
            saveb.setImage(UIImage(systemName: "bookmark.circle.fill")?.withTintColor(.black, renderingMode: .alwaysOriginal).withConfiguration(configuration), for: .normal)
            self.pet.saveb.setImage(UIImage(systemName: "bookmark.circle.fill")?.withTintColor(.black, renderingMode: .alwaysOriginal).withConfiguration(UIImage.SymbolConfiguration(pointSize: 30)), for: .normal)
            self.saved = false
            self.pet.saved = false
        }
    }
    
    func setUpConstraints() {
        let buttonDim: CGFloat = 60
        
        //pView
        pView.widthAnchor.constraint(equalToConstant: 342).isActive = true
        pView.heightAnchor.constraint(equalToConstant: 262).isActive = true
        pView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 17).isActive = true
        pView.topAnchor.constraint(equalTo: view.topAnchor, constant: 62).isActive = true
        
        //owner
        NSLayoutConstraint.activate([
            owner.leadingAnchor.constraint(equalTo: pView.leadingAnchor),
            owner.topAnchor.constraint(equalTo: calendarPic.bottomAnchor, constant: 17),
            owner.widthAnchor.constraint(equalToConstant: 342),
            owner.heightAnchor.constraint(equalToConstant: 202)
        ])
        
        //backButton
        NSLayoutConstraint.activate([
            backButton.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 91.06),
            backButton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 31)
        ])
        
        //name
        NSLayoutConstraint.activate([
            name.widthAnchor.constraint(equalToConstant: 400),
            name.heightAnchor.constraint(equalToConstant: 34),
            name.topAnchor.constraint(equalTo: view.topAnchor, constant: 352),
            name.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 45)
        ])
        
        //age
        NSLayoutConstraint.activate([
            age.widthAnchor.constraint(equalToConstant: 400),
            age.heightAnchor.constraint(equalToConstant: 21),
            age.topAnchor.constraint(equalTo: view.topAnchor, constant: 411),
            age.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 45)
        ])
        
        //category
        category.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 45).isActive = true
        category.topAnchor.constraint(equalTo: view.topAnchor, constant: 441.6).isActive = true
        
        //mapPic
        mapPic.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 48).isActive = true
        mapPic.topAnchor.constraint(equalTo: view.topAnchor, constant: 473.2).isActive = true
        
        //location
        location.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 79).isActive = true
        location.topAnchor.constraint(equalTo: view.topAnchor, constant: 472.5).isActive = true
        
        //calendarPic
        calendarPic.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 48).isActive = true
        calendarPic.topAnchor.constraint(equalTo: view.topAnchor, constant: 509).isActive = true
        
        //number
        number.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 79).isActive = true
        number.topAnchor.constraint(equalTo: view.topAnchor, constant: 506.8).isActive = true
        
        NSLayoutConstraint.activate([
            userName.topAnchor.constraint(equalTo: owner.topAnchor, constant: 10),
            userName.leadingAnchor.constraint(equalTo: owner.leadingAnchor, constant: 20)
        ])
        
        NSLayoutConstraint.activate([
            phoneNumber.topAnchor.constraint(equalTo: profileButton.bottomAnchor, constant: 20),
            phoneNumber.leadingAnchor.constraint(equalTo: profileButton.leadingAnchor)
        ])
        
        NSLayoutConstraint.activate([
            email.topAnchor.constraint(equalTo: phoneNumber.bottomAnchor, constant: 5),
            email.leadingAnchor.constraint(equalTo: phoneNumber.leadingAnchor)
        ])
        
        NSLayoutConstraint.activate([
            imageView.trailingAnchor.constraint(equalTo: owner.trailingAnchor, constant: -20),
            imageView.topAnchor.constraint(equalTo: userName.topAnchor),
            imageView.heightAnchor.constraint(equalToConstant: 70),
            imageView.widthAnchor.constraint(equalToConstant: 70)
        ])
        
        NSLayoutConstraint.activate([
            profileButton.topAnchor.constraint(equalTo: userName.bottomAnchor, constant: 10),
            profileButton.leadingAnchor.constraint(equalTo: userName.leadingAnchor),
            bottomLine.leftAnchor.constraint(equalTo: view.leftAnchor),
            bottomLine.rightAnchor.constraint(equalTo: view.rightAnchor),
            bottomLine.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            bottomLine.heightAnchor.constraint(equalToConstant: 60)
        ])
        
        NSLayoutConstraint.activate([
            numPets.leadingAnchor.constraint(equalTo: owner.leadingAnchor),
            numPets.topAnchor.constraint(equalTo: owner.bottomAnchor, constant: 50)
        ])
        
        NSLayoutConstraint.activate([
            applyb.topAnchor.constraint(equalTo: numPets.topAnchor, constant: -7),
            applyb.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
        
        NSLayoutConstraint.activate([
            saveb.trailingAnchor.constraint(equalTo: pView.trailingAnchor, constant: -7),
            saveb.topAnchor.constraint(equalTo: pView.topAnchor, constant: 10),
            saveb.widthAnchor.constraint(equalToConstant: buttonDim),
            saveb.heightAnchor.constraint(equalToConstant: buttonDim)
            
        ])
    }
    
    @objc func editProfilePage() {
        self.tabBarController?.selectedIndex = 0
        self.tabBarController?.tabBar.isHidden = false
        navigationController?.popViewController(animated: true)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
}
