//
//  MyNetworkCollectionViewCell.swift
//  linkedIn_replica_app
//
//  Created by Ahmed Mohiy on 12/02/2023.
//

import UIKit

class MyNetworkCollectionViewCell: UIView {
    
    
    @IBOutlet weak var imageViewCover: UIImageView!
    @IBOutlet weak var imageViewLogo: UIImageView!
    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var labelSubtitle: UILabel!
    @IBOutlet weak var buttonAction: UIButton!
    @IBOutlet weak var labelConnection: UILabel!
    @IBOutlet weak var widthConstraintLogo: NSLayoutConstraint!
    @IBOutlet weak var topConstraintLogo: NSLayoutConstraint!
    
    var viewModel: MyNetworkCollectionViewCellViewModel? {
        didSet {
            guard let viewModel else {return}
            imageViewCover.image = UIImage.loadLocalImageWith(name: viewModel.person.coverImageUrl)
            imageViewLogo.image = UIImage.loadLocalImageWith(name: viewModel.person.profileImageUrl)
            labelTitle.text = viewModel.person.name
            labelSubtitle.text = viewModel.person.jobTitle
            labelConnection.text = "\(Int.random(in: 1...100)) \("mynetwork_screen_mutual_connection".localizedString())"
        }
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        initUI()
    }
    
    func initUI() {
        imageViewCover.contentMode = .top
        imageViewCover.clipsToBounds = true
        
        let logoWidth:CGFloat = self.bounds.width * 0.2
        widthConstraintLogo.constant = logoWidth
        topConstraintLogo.constant = -(logoWidth/2)
        imageViewLogo.contentMode = .scaleAspectFill
        imageViewLogo.layer.cornerRadius = logoWidth / 2
        
        labelTitle.font = .preferredFont(forTextStyle: .title3)
        labelSubtitle.font = .preferredFont(forTextStyle: .body)
        labelConnection.font = .preferredFont(forTextStyle: .caption2)
        
        buttonAction.layer.borderWidth = 1
        buttonAction.layer.cornerRadius = 20
        buttonAction.layer.borderColor = UIColor.systemBlue.cgColor
        buttonAction.setTitleColor(.systemBlue, for: .normal)
        buttonAction.setTitle("mynetwork_screen_connect".localizedString(), for: .normal)
    }
    
    class func nibName() -> String {
        return "MyNetworkCollectionViewCell"
    }

}
