//
//  MyNetworkHeaderReusableView.swift
//  linkedIn_replica_app
//
//  Created by Ahmed Mohiy on 12/02/2023.
//

import UIKit

class MyNetworkHeaderReusableView: UICollectionReusableView {

    @IBOutlet weak var labelTitle: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        self.backgroundColor = .appSecondaryBackground
        self.labelTitle.font = .preferredFont(forTextStyle: .title3)
    }
    
    func configureCell(title: String) {
        labelTitle.text = title
    }
    
    class func cellIdentifier() -> String {
        return "MyNetworkHeaderReusableViewIdentifier"
    }
    
    class func cellNib() -> UINib {
        return UINib(nibName: "MyNetworkHeaderReusableView", bundle: nil)
    }
    
    class func cellHeight() -> CGFloat {
        return 45
    }

    
}
