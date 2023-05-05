//
//  TaskViewController.swift
//  Housing and Pet
//
//  Created by Eman Abdu on 5/5/23.
//

import Foundation
import UIKit

class TaskViewController : UIViewController {
    
    var aboutBox = UIView()
    var taskBox = UIView()
    var about = UILabel()
    var aboutDetail = UILabel()
    var task = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        aboutBox.frame = CGRect(x: 0, y: 0, width: 342, height: 157)
        aboutBox.backgroundColor = .white

        aboutBox.layer.cornerRadius = 30
        aboutBox.layer.borderWidth = 3
        aboutBox.layer.borderColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1).cgColor

        view.addSubview(aboutBox)
        aboutBox.translatesAutoresizingMaskIntoConstraints = false
        aboutBox.widthAnchor.constraint(equalToConstant: 342).isActive = true
        aboutBox.heightAnchor.constraint(equalToConstant: 157).isActive = true
        aboutBox.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0.5).isActive = true
        aboutBox.topAnchor.constraint(equalTo: view.topAnchor, constant: 52).isActive = true
        
        taskBox.frame = CGRect(x: 0, y: 0, width: 342, height: 289)
        taskBox.backgroundColor = .white

        taskBox.layer.cornerRadius = 30
        taskBox.layer.borderWidth = 3
        taskBox.layer.borderColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1).cgColor

        view.addSubview(taskBox)
        taskBox.translatesAutoresizingMaskIntoConstraints = false
        taskBox.widthAnchor.constraint(equalToConstant: 342).isActive = true
        taskBox.heightAnchor.constraint(equalToConstant: 289).isActive = true
        taskBox.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 17).isActive = true
        taskBox.topAnchor.constraint(equalTo: view.topAnchor, constant: 229).isActive = true
        
        about.frame = CGRect(x: 0, y: 0, width: 160, height: 29)
        about.backgroundColor = .white

        about.textColor = UIColor(red: 0.118, green: 0.118, blue: 0.125, alpha: 1)
        about.font = UIFont(name: "Ubuntu-Medium", size: 25)
        // Line height: 29 pt
        // (identical to box height)
        about.attributedText = NSMutableAttributedString(string: "About the pet", attributes: [NSAttributedString.Key.kern: -0.25])

        view.addSubview(about)
        about.translatesAutoresizingMaskIntoConstraints = false
        about.widthAnchor.constraint(equalToConstant: 160).isActive = true
        about.heightAnchor.constraint(equalToConstant: 29).isActive = true
        about.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 72).isActive = true
        about.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 57).isActive = true
        
        // PLACEHOLDER
        aboutDetail.frame = CGRect(x: 0, y: 0, width: 262, height: 63)
        aboutDetail.backgroundColor = .white

        aboutDetail.textColor = UIColor(red: 0.118, green: 0.118, blue: 0.125, alpha: 1)
        aboutDetail.font = UIFont(name: "Ubuntu-Regular", size: 14)
        aboutDetail.numberOfLines = 0
        aboutDetail.lineBreakMode = .byWordWrapping
        var paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 1.31
        // Line height: 21 pt
        aboutDetail.attributedText = NSMutableAttributedString(string: "xxx xxxx xxxxx xxxxx xxxxx xxx xxx xxxx xxxxx xxxxx xxxx  xxxxxxxxxxxxx xxxxx xxxxx xxxxxxxxxxxx xxxxxxxxxxxx ", attributes: [NSAttributedString.Key.paragraphStyle: paragraphStyle])

        view.addSubview(aboutDetail)
        aboutDetail.translatesAutoresizingMaskIntoConstraints = false
        aboutDetail.widthAnchor.constraint(equalToConstant: 262).isActive = true
        aboutDetail.heightAnchor.constraint(equalToConstant: 63).isActive = true
        aboutDetail.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 57).isActive = true
        aboutDetail.topAnchor.constraint(equalTo: view.topAnchor, constant: 126).isActive = true
        
        task.frame = CGRect(x: 0, y: 0, width: 237, height: 29)
        task.backgroundColor = .white
        task.textColor = UIColor(red: 0.118, green: 0.118, blue: 0.125, alpha: 1)
        task.font = UIFont(name: "Ubuntu-Medium", size: 25)
        task.attributedText = NSMutableAttributedString(string: "What you need to do", attributes: [NSAttributedString.Key.kern: -0.25])
        view.addSubview(task)
        task.translatesAutoresizingMaskIntoConstraints = false
        task.widthAnchor.constraint(equalToConstant: 237).isActive = true
        task.heightAnchor.constraint(equalToConstant: 29).isActive = true
        task.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 57).isActive = true
        task.topAnchor.constraint(equalTo: view.topAnchor, constant: 249).isActive = true
    }
}
