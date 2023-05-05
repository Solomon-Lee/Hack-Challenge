//
//  PaddedTextFields.swift
//  Housing and Pet
//
//  Created by Wei Zheng on 4/29/23.
//

import UIKit

class PaddedTextField: UITextField {
    

    let placeholderPadding = UIEdgeInsets(top: 5, left: 25, bottom: 5, right: 5)
    let padding = UIEdgeInsets(top: 5, left: 15, bottom: 5, right: 5)

    override open func textRect(forBounds bounds: CGRect) -> CGRect {
        super.textRect(forBounds: bounds)
        return bounds.inset(by: padding)
    }

    override open func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        super.editingRect(forBounds: bounds)
        return bounds.inset(by: placeholderPadding)
    }

    override open func editingRect(forBounds bounds: CGRect) -> CGRect {
        super.editingRect(forBounds: bounds)
        return bounds.inset(by: padding)
    }

}
