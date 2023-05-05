//
//  SavedPageCollectionViewCell.swift
//  Housing and Pet
//
//  Created by Wei Zheng on 5/2/23.
//

import UIKit

class SavedPageCollectionViewCell: UICollectionViewCell {
    
    let petName = UILabel()
    let ageAndGender = UILabel()
    let catAndBred = UILabel()
    let location = UILabel()
    let mapPic = UIImageView()
    let calendarPic = UIImageView()
    let time = UILabel()
    let profilePic = UIImageView()
    let sitAdpButton = UIButton()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.backgroundColor = .white
        contentView.clipsToBounds = true
        contentView.layer.cornerRadius = 30
        contentView.layer.borderColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1).cgColor
        contentView.layer.borderWidth = 3
        
        
        //setUp pet name
        petName.textColor = UIColor(red: 0.12, green: 0.12, blue: 0.13, alpha: 1)
        petName.font = UIFont(name: "Ubuntu-Medium", size: 25)
        petName.translatesAutoresizingMaskIntoConstraints = false
        contentView.insertSubview(petName, at: 0)
        
        //set up age and gender
        ageAndGender.textColor = UIColor(red: 0.12, green: 0.12, blue: 0.13, alpha: 1)
        ageAndGender.font = UIFont(name: "Ubuntu-Regular", size: 12)
        ageAndGender.translatesAutoresizingMaskIntoConstraints = false
        contentView.insertSubview(ageAndGender, at: 0)
        
        //set up category and breed
        catAndBred.textColor = UIColor(red: 0.12, green: 0.12, blue: 0.13, alpha: 1)
        catAndBred.font = UIFont(name: "Ubuntu-Regular", size: 12)
        catAndBred.translatesAutoresizingMaskIntoConstraints = false
        contentView.insertSubview(catAndBred, at: 0)
        
        //set up category and breed
        location.textColor = UIColor(red: 0.12, green: 0.12, blue: 0.13, alpha: 1)
        location.font = UIFont(name: "Ubuntu-Regular", size: 12)
        location.translatesAutoresizingMaskIntoConstraints = false
        contentView.insertSubview(location, at: 0)
        
        //set up category and breed
        time.textColor = UIColor(red: 0.12, green: 0.12, blue: 0.13, alpha: 1)
        time.font = UIFont(name: "Ubuntu-Regular", size: 12)
        time.translatesAutoresizingMaskIntoConstraints = false
        contentView.insertSubview(time, at: 0)
        
        //set up the map pin
        mapPic.image = UIImage(named: "map-pin")
        mapPic.translatesAutoresizingMaskIntoConstraints = false
        contentView.insertSubview(mapPic, at: 0)

        //set up the calendar
        calendarPic.image = UIImage(named: "calendar")
        calendarPic.translatesAutoresizingMaskIntoConstraints = false
        contentView.insertSubview(calendarPic, at: 0)
        
        //profilePic
        profilePic.translatesAutoresizingMaskIntoConstraints = false
        profilePic.clipsToBounds = true
        profilePic.layer.cornerRadius = 73/5
        contentView.insertSubview(profilePic, at: 0)
        
        //sitter or adopter button
        sitAdpButton.translatesAutoresizingMaskIntoConstraints = false
        sitAdpButton.backgroundColor = UIColor(red: 0.12, green: 0.12, blue: 0.13, alpha: 1)
        sitAdpButton.clipsToBounds = true
        sitAdpButton.titleLabel?.textColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
        sitAdpButton.titleLabel?.textAlignment = .center
        contentView.insertSubview(sitAdpButton, at: 0)
        
        //set up constraints
        setCons()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func configure(pet: SavedPagePets){
        petName.text = pet.petName
        ageAndGender.text = "Age: \(pet.age) | \(pet.gender)"
        catAndBred.text = "\(pet.category) | \(pet.breed)"
        location.text = pet.location
        time.text = pet.time
        profilePic.image = UIImage(named: pet.profilePic)
        
        let loginButtonTitle = pet.buttonTitle
        let strokeTextAttributes: [NSAttributedString.Key: Any] = [
            .strokeColor: UIColor.white,
            .foregroundColor: UIColor.white,
            .strokeWidth: -1.0,
            .font: UIFont(name: "Ubuntu-Medium", size: 14) ?? .systemFont(ofSize: 14, weight: .regular),
            
        ]
        let loginAttributedTitle = NSAttributedString(string: loginButtonTitle, attributes: strokeTextAttributes)
        sitAdpButton.setAttributedTitle(loginAttributedTitle, for: .normal)
        
        if sitAdpButton.titleLabel?.text == "Sitter"{
            sitAdpButton.layer.cornerRadius = 13
            NSLayoutConstraint.activate([
                sitAdpButton.widthAnchor.constraint(equalToConstant: 65.23),
                sitAdpButton.heightAnchor.constraint(equalToConstant: 29.77),
            ])
        }
        else{
            sitAdpButton.layer.cornerRadius = 15
            NSLayoutConstraint.activate([
                sitAdpButton.widthAnchor.constraint(equalToConstant: 82.23),
                sitAdpButton.heightAnchor.constraint(equalToConstant: 30.21),
            ])
        }

    }
    
    //set constraints
    private func setCons(){
        
        NSLayoutConstraint.activate([
            
            //petname
            petName.topAnchor.constraint(equalTo: self.contentView.topAnchor,constant: 20),
            petName.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor,constant: 46),
            
            //age and gender
            ageAndGender.topAnchor.constraint(equalTo: petName.bottomAnchor,constant: 17.94),
            ageAndGender.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor,constant: 46),
            
            //category and breed
            catAndBred.topAnchor.constraint(equalTo: ageAndGender.bottomAnchor,constant: 9.6),
            catAndBred.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor,constant: 46),
            
            //location
            location.topAnchor.constraint(equalTo: catAndBred.bottomAnchor,constant: 9.6),
            location.leadingAnchor.constraint(equalTo: mapPic.trailingAnchor,constant: 4),
            
            //time
            time.topAnchor.constraint(equalTo: location.bottomAnchor,constant: 9.6),
            time.leadingAnchor.constraint(equalTo: calendarPic.trailingAnchor,constant: 4),
            
            //map pin
            mapPic.widthAnchor.constraint(equalToConstant: 10.5),
            mapPic.heightAnchor.constraint(equalToConstant: 12.83),
            mapPic.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor,constant: 46),
            mapPic.topAnchor.constraint(equalTo: catAndBred.bottomAnchor,constant: 10.18),
            
            //calendar
            calendarPic.widthAnchor.constraint(equalToConstant: 10.5),
            calendarPic.heightAnchor.constraint(equalToConstant: 10.5),
            calendarPic.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor,constant: 46),
            calendarPic.topAnchor.constraint(equalTo: mapPic.bottomAnchor,constant: 12.52),
            
            //profile pic
            profilePic.widthAnchor.constraint(equalToConstant: 73),
            profilePic.heightAnchor.constraint(equalToConstant: 73),
            profilePic.topAnchor.constraint(equalTo: self.contentView.topAnchor,constant: 32),
            profilePic.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor,constant: 194.34),
            
            //sitter or adopter
            sitAdpButton.topAnchor.constraint(equalTo: self.contentView.topAnchor,constant: 118.94),
//            sitAdpButton.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor,constant: 198.8)
            sitAdpButton.centerXAnchor.constraint(equalTo: profilePic.centerXAnchor),
        ])
    }
}
