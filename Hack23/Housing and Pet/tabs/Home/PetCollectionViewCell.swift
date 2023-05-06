
//  PetCollectionViewCell.swift
//  hackaton
//
//  Created by Eman Abdu on 4/30/23.
//

import UIKit

class PetCollectionViewCell: UICollectionViewCell {
    let imageView = UIImageView()
    let nameLabel = UILabel()
    let age = UILabel()
    let species = UILabel()
    let saveb = UIButton()
    var time = ""
    var number = ""
    var saved = false
    
    let configuration = UIImage.SymbolConfiguration(pointSize: 30)

    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .white
        contentView.layer.cornerRadius = 10
        contentView.layer.borderWidth = 2.0
        contentView.layer.borderColor = UIColor.black.cgColor
        imageView.layer.cornerRadius = 5
        imageView.clipsToBounds = true
        contentView.addSubview(imageView)
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(imageView)
        
        nameLabel.font = .systemFont(ofSize: 15)
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(nameLabel)
        
        species.font = .systemFont(ofSize: 12)
        species.textColor = .darkGray
        species.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(species)
        
        age.font = .systemFont(ofSize: 12)
        age.textColor = .darkGray
        age.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(age)
        

        saveb.setImage(UIImage(systemName: "bookmark.circle.fill")?.withTintColor(.black, renderingMode: .alwaysOriginal).withConfiguration(configuration), for: .normal)
        
        saveb.contentMode = .scaleAspectFit

        saveb.translatesAutoresizingMaskIntoConstraints = false
//        saveb.backgroundColor = .red

        saveb.addTarget(self, action: #selector(changeColor), for: .touchUpInside)
        contentView.addSubview(saveb)
        
        
        setUpConstraints()
    }
    
    @objc func changeColor() {
        if (self.saved == false) {
            saveb.setImage(UIImage(systemName: "bookmark.circle.fill")?.withRenderingMode(.alwaysOriginal).withConfiguration(configuration), for: .normal)
            self.saved = true
//            saveb.imageView
        }
        else {
            saveb.setImage(UIImage(systemName: "bookmark.circle.fill")?.withTintColor(.black, renderingMode: .alwaysOriginal).withConfiguration(configuration), for: .normal)
            self.saved = false
        }
    }
    
    func setUpConstraints(){
        
        let buttonDim: CGFloat = 60
        
        NSLayoutConstraint.activate([])
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 5),
            imageView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 5),
            imageView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -5),
            imageView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -70)])
        
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 20),
            nameLabel.leadingAnchor.constraint(equalTo: imageView.leadingAnchor, constant: 5)
        ])
        
        NSLayoutConstraint.activate([
            age.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 5),
            age.trailingAnchor.constraint(equalTo: imageView.trailingAnchor)
        ])
        
        NSLayoutConstraint.activate([
            species.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 5),
            species.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor)
        ])
        
        NSLayoutConstraint.activate([
            saveb.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -7),
            saveb.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 10),
            saveb.widthAnchor.constraint(equalToConstant: buttonDim),
            saveb.heightAnchor.constraint(equalToConstant: buttonDim)
            
        ])
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func update(pet: Pet){
        imageView.image = UIImage(named:pet.assets?[0].base_url ?? "")
        nameLabel.text = pet.name
        time = (pet.start_time ?? "") + " - " + (pet.end_time ?? "")
        nameLabel.font = UIFont(name: "Ubuntu-Medium", size: 16)
        age.text = (pet.age) + " Year old"
        age.font = UIFont(name: "Ubuntu-Medium", size: 12)
        species.text = pet.breed
        species.font = UIFont(name: "Ubuntu-Medium", size: 12)
    }
    
    func update(pet: AdoptionPet){
        imageView.image = UIImage(named:pet.assets?[0].base_url ?? "")
        nameLabel.text = pet.name
        time = (pet.end_time ?? "")
        nameLabel.font = UIFont(name: "Ubuntu-Medium", size: 16)
        age.text = (pet.age) + " Year old"
        age.font = UIFont(name: "Ubuntu-Medium", size: 12)
        species.text = pet.breed
        species.font = UIFont(name: "Ubuntu-Medium", size: 12)
    }
    }
