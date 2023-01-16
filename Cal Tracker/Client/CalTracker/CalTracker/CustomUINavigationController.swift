//
//  CustomUINavigationController.swift
//  CalTracker
//
//  Created by Ahmed Mohiy on 24/10/2022.
//

import UIKit

class CustomUINavigationController: UINavigationController {
    override var childForStatusBarStyle: UIViewController? {
        return visibleViewController
    }
    
}
