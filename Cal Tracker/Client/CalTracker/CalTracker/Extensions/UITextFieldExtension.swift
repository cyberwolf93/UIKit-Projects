//
//  UITextFieldExtension.swift
//  CalTracker
//
//  Created by Ahmed Mohiy on 23/10/2022.
//

import UIKit

extension UITextField {
    func addBottomBorder(frame: CGRect, color: UIColor) {
        let layer = CALayer()
        layer.frame = frame
        layer.backgroundColor = color.cgColor
        self.borderStyle = .none
        self.layer.addSublayer(layer)
    }
    
    func paddingLeftAndRight(with: CGFloat) {
        let padding = UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5)
        self.bounds.inset(by: padding)
    }
}

