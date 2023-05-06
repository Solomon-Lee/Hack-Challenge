//
//  FilterCollectionView.swift
//  hackaton
//
//  Created by Eman Abdu on 4/30/23.
//

import UIKit

class CustomFilterCollectionViewCell: UICollectionViewCell {
    let nameLabel =  UIButton()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .white
        contentView.addSubview(nameLabel)

        
        nameLabel.frame =  CGRect(x: 0, y: 10, width: frame.width + 5, height: 30)
        nameLabel.layer.cornerRadius = nameLabel.frame.height / 2
        nameLabel.layer.borderWidth = 1.0
        nameLabel.clipsToBounds = true
        nameLabel.layer.borderColor = UIColor.black.cgColor
        contentView.addSubview(nameLabel)
        nameLabel.setTitleColor(UIColor.black, for: .normal)
        nameLabel.backgroundColor = .white
        nameLabel.isUserInteractionEnabled = false
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        setUpConstraints()
        
    }
    
    func setUpConstraints(){
        
        NSLayoutConstraint.activate([
        ])
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(filterName: String){
//        nameLabel.text = filterName
        nameLabel.setTitle(filterName, for: .normal)
    }
    
    func up() -> Bool {
        if
            (self.nameLabel.titleColor(for: .normal) == .white){
            
            nameLabel.backgroundColor = .white
            nameLabel.setTitleColor(.black, for: .normal)
            return false
        }
        else {
            nameLabel.backgroundColor =  .black
            nameLabel.setTitleColor(.white, for: .normal)
            return true
        }
    }
}
