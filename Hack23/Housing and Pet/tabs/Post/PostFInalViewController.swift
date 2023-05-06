//
//  CongratsViewController.swift
//  Housing and Pet
//
//  Created by Eman Abdu on 5/4/23.
//

import Foundation
import UIKit

class CongratsViewController : UIViewController {
    
    let ellipse = UIImageView(image: UIImage(named: "eclipse"))
    let congrats = UIImageView(image: UIImage(named: "congrats"))
    let cong = UILabel()
    let explain = UILabel()
    let back = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 0.961, green: 0.961, blue: 0.961, alpha: 1)
        
        ellipse.frame = CGRect(x: 0, y: 0, width: 408, height: 400)
        ellipse.backgroundColor = .clear

//        ellipse.layer.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1).cgColor
//        ellipse.image = UIImage(named: "eclipse")

        view.addSubview(ellipse)
        ellipse.translatesAutoresizingMaskIntoConstraints = false
        ellipse.widthAnchor.constraint(equalToConstant: 408).isActive = true
        ellipse.heightAnchor.constraint(equalToConstant: 400).isActive = true
        ellipse.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: -111).isActive = true
        ellipse.topAnchor.constraint(equalTo: view.topAnchor, constant: -35).isActive = true
        
        view.addSubview(congrats)
        congrats.translatesAutoresizingMaskIntoConstraints = false
        congrats.widthAnchor.constraint(equalToConstant: 207.67).isActive = true
        congrats.heightAnchor.constraint(equalToConstant: 184.68).isActive = true
        congrats.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0.34).isActive = true
        congrats.topAnchor.constraint(equalTo: view.topAnchor, constant: 180).isActive = true
        
        cong.frame = CGRect(x: 0, y: 0, width: 242, height: 34)
//        cong.backgroundColor = .white

        cong.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        cong.font = UIFont(name: "Ubuntu-Medium", size: 30)
        // Line height: 34 pt
        cong.textAlignment = .center
        cong.text = "Congratulations !"
        view.addSubview(cong)
        cong.translatesAutoresizingMaskIntoConstraints = false
        cong.widthAnchor.constraint(equalToConstant: 242).isActive = true
        cong.heightAnchor.constraint(equalToConstant: 34).isActive = true
        cong.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0.5).isActive = true
        cong.topAnchor.constraint(equalTo: view.topAnchor, constant: 425).isActive = true
        
        explain.frame = CGRect(x: 0, y: 0, width: 206, height: 42)
//        explain.backgroundColor = .white

        explain.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        explain.font = UIFont(name: "Ubuntu-Regular", size: 18)
        explain.numberOfLines = 0
        explain.lineBreakMode = .byWordWrapping
        // Line height: 21 pt
        explain.textAlignment = .center
        explain.attributedText = NSMutableAttributedString(string: "Your request has been \nsent to the current owner", attributes: [NSAttributedString.Key.kern: -0.18])

        view.addSubview(explain)
        explain.translatesAutoresizingMaskIntoConstraints = false
        explain.widthAnchor.constraint(equalToConstant: 206).isActive = true
        explain.heightAnchor.constraint(equalToConstant: 42).isActive = true
        explain.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0.5).isActive = true
        explain.topAnchor.constraint(equalTo: view.topAnchor, constant: 474).isActive = true
        
        back.frame = CGRect(x: 0, y: 0, width: 216, height: 45)
        back.backgroundColor = .white

        back.layer.backgroundColor = UIColor(red: 0.118, green: 0.118, blue: 0.125, alpha: 1).cgColor
        back.layer.cornerRadius = 25
        back.setAttributedTitle(NSMutableAttributedString(string: "Return to Home Page", attributes: [NSAttributedString.Key.kern: -0.18]), for: .normal)
        back.setTitleColor(.white, for: .normal)
        back.addTarget(self, action: #selector(toHome), for: .touchUpInside)
        view.addSubview(back)
        back.translatesAutoresizingMaskIntoConstraints = false
        back.widthAnchor.constraint(equalToConstant: 216).isActive = true
        back.heightAnchor.constraint(equalToConstant: 45).isActive = true
        back.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 6.5).isActive = true
        back.topAnchor.constraint(equalTo: view.topAnchor, constant: 580).isActive = true
    }
    
    @objc func toHome() {
        navigationController?.pushViewController(HomeViewController(), animated: true)
    }
    
    
}
