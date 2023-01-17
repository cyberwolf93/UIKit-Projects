//
//  ProfileTabBarButtonItem.swift
//  linkedIn Replica
//
//  Created by Ahmed Mohiy on 17/01/2023.
//

import UIKit

class ProfileBarButtonItem: UIBarButtonItem {
    
    var viewModel: ProfileBarButtonItemViewModel? {
        didSet {
            createBarButton()
        }
    }
    
    let size: CGSize
    
    init(size: CGSize) {
        self.size = size
        super.init()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func createBarButton() {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: self.size.width, height: self.size.height))
        let imageView = UIImageView()
        imageView.frame = view.frame
        imageView.clipsToBounds = true
        view.addSubview(imageView)
        view.layer.cornerRadius = imageView.frame.width / 2
        self.customView = view
        
        self.viewModel?.getImageData(completion: { [weak self] data in
            DispatchQueue.main.async {
                guard let data, let view = self?.customView?.subviews.first! as? UIImageView  else {
                    return
                }

                view.image = UIImage(data: data)
            }
        })
    }
}
