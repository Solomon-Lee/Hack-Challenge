//
//  CustomTableViewCell.swift
//  hackathon
//
//  Created by Eman Abdu on 5/1/23.
//

import UIKit

class CustomTableViewCell: UITableViewCell {

    let name = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.contentView.backgroundColor = .white
        
        name.translatesAutoresizingMaskIntoConstraints = false
        name.font = UIFont(name: "Helvetica-Bold", size: 17.0)
        name.textColor = .black
        self.contentView.addSubview(name)
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

}
