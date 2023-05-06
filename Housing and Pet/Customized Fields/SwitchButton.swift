//
//  SwitchButton.swift
//  Housing and Pet
//
//  Created by Wei Zheng on 5/3/23.
//

import UIKit

class SwitchButton: UIButton {

    var isOn = false {
            didSet {
                updateUI()
            }
        }
        
        override init(frame: CGRect) {
            super.init(frame: frame)
            configureUI()
        }
        
        required init?(coder aDecoder: NSCoder) {
            super.init(coder: aDecoder)
            configureUI()
        }
        
        private func configureUI() {
            layer.cornerRadius = frame.height / 2
            layer.masksToBounds = true
            layer.borderWidth = 1
            layer.borderColor = UIColor.lightGray.cgColor
            backgroundColor = .white
            
            setTitleColor(.gray, for: .normal)
            titleLabel?.font = UIFont.systemFont(ofSize: 14)
            
            addTarget(self, action: #selector(toggleSwitch), for: .touchUpInside)
        }
        
        private func updateUI() {
            if isOn {
                backgroundColor = UIColor.systemGreen
                layer.borderColor = UIColor.systemGreen.cgColor
                setTitleColor(.white, for: .normal)
                setTitle("YES", for: .normal)
                contentHorizontalAlignment = .left
            } else {
                backgroundColor = .white
                layer.borderColor = UIColor.lightGray.cgColor
                setTitleColor(.gray, for: .normal)
                setTitle("NO", for: .normal)
                contentHorizontalAlignment = .right
            }
        }
        
        @objc func toggleSwitch() {
            isOn.toggle()
        }
}
