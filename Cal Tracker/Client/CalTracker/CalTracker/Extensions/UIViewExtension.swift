//
//  UIViewExtension.swift
//  CalTracker
//
//  Created by Ahmed Mohiy on 23/10/2022.
//

import UIKit

enum UIViewTags: Int {
    case mainLoader = 111
}

extension UIView {
    
    func removeGradient() {
        if let layers = self.layer.sublayers {
            for layer in layers {
                if let layer = layer as? CAGradientLayer {
                    layer.removeFromSuperlayer()
                }
            }
        }
        
    }
    
    func addGradientBackground(with colors: [CGColor], alpha: Float = 1) {
        self.removeGradient()
        let gradient = CAGradientLayer()
        gradient.frame = self.bounds
        gradient.colors = colors
        gradient.opacity = alpha
        gradient.locations = [0.0 , 1.0]
        self.layer.insertSublayer(gradient, at: 0)
    }
    
    func addGradientLeftToRight(with colors: [CGColor]) {
        self.removeGradient()
        let gradient = CAGradientLayer()
        gradient.frame = self.bounds
        gradient.colors = colors
        gradient.locations = [0.0, 1.0]
        gradient.startPoint = CGPointMake(0.0, 1.0)
        gradient.endPoint = CGPointMake(1, 1.0)
        self.layer.insertSublayer(gradient, at: 0)
    }
    
    func addShadow() {
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOpacity = 0.5
        self.layer.shadowOffset = CGSize(width: -2, height: -2)
        self.layer.shadowRadius = 10
        self.layer.shadowPath = UIBezierPath(rect: self.bounds).cgPath
        self.layer.shouldRasterize = true
        self.layer.rasterizationScale = UIScreen.main.scale
        self.layer.masksToBounds = false
    }
    
    func addCornerRadius(with radius: CGFloat) {
        if let layers = self.layer.sublayers {
            for layer in layers {
                layer.cornerRadius = radius
            }
        }
        
        self.layer.cornerRadius = radius
        
    }
    
    func showLoading() {
        let activity = UIActivityIndicatorView()
        activity.translatesAutoresizingMaskIntoConstraints = false
        activity.color = UIColor.yellow2
        activity.startAnimating()
        
        let activityView = UIView(frame: self.frame)
        activityView.backgroundColor = UIColor.black.withAlphaComponent(0.3)
        activityView.addSubview(activity)
        activityView.tag = UIViewTags.mainLoader.rawValue
        self.addSubview(activityView)
        activity.centerXAnchor.constraint(equalTo: activityView.centerXAnchor).isActive = true
        activity.centerYAnchor.constraint(equalTo: activityView.centerYAnchor).isActive = true
        activity.transform = CGAffineTransform(scaleX: 2, y: 2)
        
    }
    
    func hideLoading() {
        for view in self.subviews {
            if view.tag == UIViewTags.mainLoader.rawValue {
                view.removeFromSuperview()
            }
        }
    }
    
}
