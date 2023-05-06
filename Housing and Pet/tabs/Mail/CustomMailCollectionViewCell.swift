//
//  CustomMailCollectionViewCell.swift
//  Housing and Pet
//
//  Created by Eman Abdu on 5/3/23.
//

import UIKit

class CustomMailCollectionViewCell: UICollectionViewCell {
    
    let userName = UILabel()
    let phoneNumber = UILabel()
    let petName = UILabel()
    let image = UIImage(named: "profilePicTemp")
    var imageView = UIImageView()
    let profileButton = UIButton()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .white
        contentView.layer.cornerRadius = 20
        contentView.layer.borderWidth = 3.0
        contentView.layer.borderColor = UIColor.black.cgColor
        
        userName.font = UIFont(name: "Ubuntu-Medium", size: 25)
        userName.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(userName)
        
        phoneNumber.font = UIFont(name: "Ubuntu-Medium", size: 16)
        phoneNumber.textColor = .darkGray
        phoneNumber.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(phoneNumber)
        
        petName.font = UIFont(name: "Ubuntu-Medium", size: 18)
        petName.textColor = .darkGray
        petName.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(petName)
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "profilePicTemp")
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 73/5
        contentView.insertSubview(imageView, at: 0)
        contentView.addSubview(imageView)
        
        profileButton.frame =  CGRect(x: 0, y: 10, width: frame.width + 5, height: 30)
        profileButton.layer.cornerRadius = profileButton.frame.height / 2
        profileButton.layer.borderWidth = 1.0
        profileButton.clipsToBounds = true
        contentView.addSubview(profileButton)
        profileButton.setTitleColor(UIColor.white, for: .normal)
        profileButton.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        profileButton.setTitle("View Profile", for: .normal)
        profileButton.backgroundColor = .black
        profileButton.translatesAutoresizingMaskIntoConstraints = false
        
        setUpConstranints()
        
    }
    
    func setUpConstranints() {
        NSLayoutConstraint.activate([
            userName.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 10),
            userName.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 20)
        ])
        
        NSLayoutConstraint.activate([
            phoneNumber.topAnchor.constraint(equalTo: userName.bottomAnchor, constant: 20),
            phoneNumber.leadingAnchor.constraint(equalTo: userName.leadingAnchor)
        ])
        
        NSLayoutConstraint.activate([
            petName.topAnchor.constraint(equalTo: phoneNumber.bottomAnchor, constant: 5),
            petName.leadingAnchor.constraint(equalTo: phoneNumber.leadingAnchor)
        ])
        
        NSLayoutConstraint.activate([
            imageView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -20),
            imageView.topAnchor.constraint(equalTo: userName.topAnchor),
            imageView.heightAnchor.constraint(equalToConstant: 70),
            imageView.widthAnchor.constraint(equalToConstant: 70)
        ])
        
        NSLayoutConstraint.activate([
            profileButton.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 10),
            profileButton.leadingAnchor.constraint(equalTo: imageView.leadingAnchor, constant: -7)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func update(person: Person){
        userName.text = person.userName
        userName.font = UIFont.boldSystemFont(ofSize: 16.0)
        phoneNumber.text = person.phoneNumber//pet.breed
        phoneNumber.font = UIFont.boldSystemFont(ofSize: 12.0)
        petName.text = "Applied to be the sitter of"   // !! implement
        petName.font = UIFont.boldSystemFont(ofSize: 12.0)
    }
}

