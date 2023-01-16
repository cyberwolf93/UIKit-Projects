//
//  adasdasd.swift
//  CalTracker
//
//  Created by Ahmed Mohiy on 25/10/2022.
//

import UIKit

class FilterbyUserActionSheetCollectionViewCell: UICollectionViewCell {
    
    var labelTitle: UILabel?
    var imageView: UIImageView?
    var viewSeparator: UIView?
    var cellText: String = "" {
        didSet {
            self.labelTitle?.text = self.cellText
        }
    }
    override var isSelected: Bool {
        didSet {
            if isSelected {
                imageView?.image = UIImage(systemName: "checkmark")?.withTintColor(.greenColor, renderingMode: .alwaysOriginal)
            } else {
                imageView?.image = nil
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        createImageView()
        createLabelTitle()
        createViewSeparator()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        if !self.isSelected {
            self.imageView?.image = nil
        }
        
    }
    
    func createLabelTitle() {
        labelTitle = UILabel()
        labelTitle?.text = "test"
        labelTitle?.textColor = .mainTextReversed
        labelTitle?.frame = CGRect(x: 0, y: self.frame.height/2 - 10, width: self.frame.width, height: 20)
        self.addSubview(labelTitle!)
    }
    
    func createImageView() {
        imageView = UIImageView()
        imageView?.image = nil
        imageView?.frame = CGRect(x: self.frame.maxX - self.frame.height, y: self.frame.height/4  , width: self.frame.height/2, height: self.frame.height/2)
        self.addSubview(imageView!)
    }
    
    func createViewSeparator() {
        viewSeparator = UIView()
        viewSeparator?.frame = CGRect(x: 0, y: self.frame.height-1, width: self.frame.width, height: 1)
        viewSeparator?.backgroundColor = .lightGray1.withAlphaComponent(0.5)
        self.addSubview(viewSeparator!)
    }
    
    class func cellIdentifier() -> String{
        return "FilterbyUserActionSheetCollectionViewCellIdentifier"
    }

}
