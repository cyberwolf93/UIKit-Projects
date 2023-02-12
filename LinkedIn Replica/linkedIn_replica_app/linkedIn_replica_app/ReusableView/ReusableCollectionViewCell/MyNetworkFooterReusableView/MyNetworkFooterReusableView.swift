//
//  MyNetworkFooterReusableView.swift
//  linkedIn_replica_app
//
//  Created by Ahmed Mohiy on 12/02/2023.
//

import UIKit

class MyNetworkFooterReusableView: UICollectionReusableView {

    @IBOutlet weak var buttonSeeAll: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        buttonSeeAll.setTitle("mynetwork_screen_see_all".localizedString(), for: .normal)
        buttonSeeAll.setTitleColor(.systemBlue, for: .normal)
        self.backgroundColor = .appSecondaryBackground
    }
    
    
    class func cellIdentifier() -> String {
        return "MyNetworkFooterReusableViewIdentifier"
    }
    
    class func cellNib() -> UINib {
        return UINib(nibName: "MyNetworkFooterReusableView", bundle: nil)
    }
    
    class func cellHeight() -> CGFloat {
        return 70
    }

}
