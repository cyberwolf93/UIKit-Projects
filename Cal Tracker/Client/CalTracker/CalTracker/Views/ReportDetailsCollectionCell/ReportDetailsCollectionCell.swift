//
//  ReportDetailsCollectionCell.swift
//  CalTracker
//
//  Created by Ahmed Mohiy on 26/10/2022.
//

import UIKit
protocol ReportDetailsCollectionCellDelegate: NSObjectProtocol {
    func buttonMoreDidClikced()
}

class ReportDetailsCollectionCell: UICollectionViewCell {

    //MARK: - Outlets
    @IBOutlet weak var labelFirst: UILabel!
    @IBOutlet weak var labelSecond: UILabel!
    @IBOutlet weak var buttonMoreInfo: UIButton!
    
    //MARK: Delegates
    weak var delegate: ReportDetailsCollectionCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        labelFirst.textColor = .mainTextReversed
        labelFirst.font = UIFont.systemFont(ofSize: 25)
        
        labelSecond.textColor = .lightGray2
        labelSecond.font = UIFont.systemFont(ofSize: 20)
        
        self.addCornerRadius(with: 10)
        self.backgroundColor = .white
        buttonMoreInfo.isHidden = true
    }
    
    func configureCell(labelFirst: String, labelSecond: String, showMore: Bool = false) {
        self.labelFirst.text = labelFirst
        self.labelSecond.text = labelSecond
        self.buttonMoreInfo.isHidden = !showMore
    }
    
    //MARK: - Action
    
    @IBAction func buttonMoreClicked(_ sender: Any) {
        self.delegate?.buttonMoreDidClikced()
    }
    
    //MARK: - Class functions
    class func cellIdentifier() -> String {
        return "ReportDetailsCollectionCellIdentifier"
    }
    
    class func cellNib() -> UINib {
        return UINib(nibName: "ReportDetailsCollectionCell", bundle: .main)
    }
}
