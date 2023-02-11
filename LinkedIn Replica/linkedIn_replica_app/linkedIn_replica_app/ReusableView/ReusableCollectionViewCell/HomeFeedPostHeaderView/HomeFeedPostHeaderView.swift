//
//  HomeFeedPostHeaderView.swift
//  linkedIn Replica
//
//  Created by Ahmed Mohiy on 02/02/2023.
//

import UIKit
import linkedin_models

class HomeFeedPostHeaderView: UIView {
    let title: String
    let subtitle: String
    let date: Date
    let image: UIImage?
    static var iconWidth: CGFloat = 40
    var constraintPadding: CGFloat = 5
    
    //MARK: Views
    lazy var imageView: UIImageView =  {
        return UIImageView()
    }()
    lazy var labelTitle: UILabel = {
        return UILabel()
    }()
    lazy var labelSubTitle: UILabel = {
        return UILabel()
    }()
    lazy var labelDate: UILabel = {
        return UILabel()
    }()
    
    init(title: String, subtitle: String, date: Date, image: UIImage?) {
        self.title = title
        self.subtitle = subtitle
        self.date = date
        self.image = image
        super.init(frame: .zero)
        initUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func initUI() {
        imageView.image = image
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = HomeFeedPostHeaderView.iconWidth / 2
        imageView.contentMode = .scaleAspectFill
        
        
        labelTitle.text = title
        labelTitle.font = UIFont.preferredFont(forTextStyle: .body)
        labelTitle.textColor = .label
        labelTitle.numberOfLines = 1
        
        labelSubTitle.text = subtitle
        labelSubTitle.font = UIFont.preferredFont(forTextStyle: .caption1)
        labelSubTitle.textColor = .label
        labelSubTitle.numberOfLines = 2
        
        labelDate.text = date.dateForPost()
        labelDate.font = UIFont.preferredFont(forTextStyle: .caption2)
        labelDate.textColor = .label
        labelDate.numberOfLines = 1
        
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = -3
        
        stackView.addArrangedSubview(labelTitle)
        stackView.addArrangedSubview(labelSubTitle)
        stackView.addArrangedSubview(labelDate)
        
        let buttonMore = UIButton()
        buttonMore.setImage(UIImage(systemName: "ellipsis"), for: .normal)
        buttonMore.tintColor = .label
        
        self.addSubview(imageView)
        self.addSubview(stackView)
        self.addSubview(buttonMore)
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        stackView.translatesAutoresizingMaskIntoConstraints = false
        buttonMore.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: self.topAnchor),
            imageView.leftAnchor.constraint(equalTo: self.leftAnchor),
            imageView.widthAnchor.constraint(equalToConstant: Self.iconWidth),
            imageView.heightAnchor.constraint(equalToConstant: Self.iconWidth),
            
            stackView.leftAnchor.constraint(equalTo: imageView.rightAnchor, constant: constraintPadding),
            stackView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.5),
            stackView.centerYAnchor.constraint(equalTo: imageView.centerYAnchor),
            
            buttonMore.topAnchor.constraint(equalTo: self.topAnchor),
            buttonMore.rightAnchor.constraint(equalTo: self.rightAnchor)
        ])
        
    }
    
    
    static func viewHeight(parentSize: CGSize) -> CGFloat {
        let titleHeight = "text".textHeight(width: parentSize.width, textStyle: .body) ?? 0
        let subTitleHeight = "text".textHeight(width: parentSize.width, textStyle: .caption1) ?? 0
        let dateHeight = "text".textHeight(width: parentSize.width, textStyle: .caption2) ?? 0
        
        return max(Self.iconWidth, titleHeight + subTitleHeight + dateHeight)
    }
    
}
