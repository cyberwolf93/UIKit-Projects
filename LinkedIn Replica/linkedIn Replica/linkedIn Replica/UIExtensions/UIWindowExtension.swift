//
//  UIWindowExtention.swift
//  linkedIn Replica
//
//  Created by Ahmed Mohiy on 20/01/2023.
//

import UIKit

extension UIWindow {
    static var currentWindow: UIWindow? {
        return UIApplication.shared.connectedScenes
                .filter({$0.activationState == .foregroundActive})
                .compactMap({$0 as? UIWindowScene})
                .first?.windows
                .filter({$0.isKeyWindow}).first
    }
}
