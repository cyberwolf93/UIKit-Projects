//
//  HomeFeedCollectionViewCell.swift
//  linkedIn Replica
//
//  Created by Ahmed Mohiy on 02/02/2023.
//

import UIKit

protocol HomeFeedCollectionViewCellDelegate: NSObjectProtocol {
    func postTextDidExpand(indexPath: IndexPath)
}

class HomeFeedCollectionViewCell: UICollectionViewCell {
    
    
    //MARK: Views
    var headerView: HomeFeedPostHeaderView?
    var postText: UILabel?
    var buttonSeeMore: UIButton?
    var assetView: UIImageView?
    var footerView: HomeFeedPostFooterView?
    
    //MARK: Static Variables
    static var postTextLineHeight: CGFloat = 20
    static var postTextLineSpacing: CGFloat = 5
    static var postTextNumberOfline: Int = 2
    static var constraintPadding: CGFloat = 10
    static var assetViewAspectRatio: CGFloat = 3/2
    
    //MARK: Variables
    weak var delegate: HomeFeedCollectionViewCellDelegate?
    var indexPath: IndexPath?
    var assetViewHeight: CGFloat = 0
    var isPostLabelExtended = false
    var viewModel: HomeFeedCellViewModel? {
        didSet {
            if viewModel != nil {
                initUI()
            }
        }
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    override func prepareForReuse() {
        self.indexPath = nil
        self.delegate = nil
        self.viewModel = nil
        headerView?.removeFromSuperview()
        postText?.removeFromSuperview()
        buttonSeeMore?.removeFromSuperview()
        assetView?.removeFromSuperview()
        footerView?.removeFromSuperview()
    }
    
    // MARK: - Create UI
    func initUI() {
        // create post header
        createHeaderView()
        // create post text
        createPostText()
        
        // create post view (image, atricale, etc.)
        createAssetView()
        // create post footer
        createFooterView()
        
        self.contentView.backgroundColor = .appSecondaryBackground
    }
    
    func createHeaderView() {
        guard let viewModel  else {return}
        
        let image = UIImage.loadLocalImageWith(name: viewModel.headerImageName())
        headerView = HomeFeedPostHeaderView(title: viewModel.headerTitle(),
                                                subtitle: viewModel.headerSubTitle(),
                                                date: viewModel.headerPublishDate(),
                                            image: image)
        self.contentView.addSubview(headerView!)
        headerView?.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            headerView!.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: Self.constraintPadding),
            headerView!.leftAnchor.constraint(equalTo: self.contentView.leftAnchor, constant: Self.constraintPadding),
            headerView!.rightAnchor.constraint(equalTo: self.contentView.rightAnchor, constant: -Self.constraintPadding),
            headerView!.heightAnchor.constraint(greaterThanOrEqualToConstant: 50)
        ])
    }
    
    func createPostText() {
        guard let viewModel, let headerView  else {return}
        
        postText = UILabel()
        postText?.numberOfLines = Self.postTextNumberOfline
        postText?.font = .preferredFont(forTextStyle: .body)
        
        let attributedText = NSMutableAttributedString(string: viewModel.postData.description)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.minimumLineHeight = Self.postTextLineHeight
        paragraphStyle.maximumLineHeight = Self.postTextLineHeight
        paragraphStyle.lineSpacing = Self.postTextLineSpacing
        attributedText.addAttribute(NSAttributedString.Key.paragraphStyle, value: paragraphStyle, range: NSMakeRange(0, attributedText.length))
        postText?.attributedText = attributedText
        postText?.translatesAutoresizingMaskIntoConstraints = false
        self.contentView.addSubview(postText!)
        
        NSLayoutConstraint.activate([
            postText!.topAnchor.constraint(equalTo: headerView.bottomAnchor,constant: Self.constraintPadding/3),
            postText!.leftAnchor.constraint(equalTo: self.contentView.leftAnchor,constant: Self.constraintPadding),
            postText!.rightAnchor.constraint(equalTo: self.contentView.rightAnchor,constant: -Self.constraintPadding)
        ])
        
        if viewModel.isCellExtended {
            self.postText?.numberOfLines = 0
            self.buttonSeeMore?.isHidden = true
        } else if let height = viewModel.postData.description.textHeight(width: self.contentView.bounds.width, textStyle: .body),
           height > Self.getPostTextCollapsedHeight(), !viewModel.isCellExtended {
            buttonSeeMore = UIButton(type: .custom, primaryAction: UIAction(handler: {[weak self] action in
                self?.postText?.numberOfLines = 0
                self?.buttonSeeMore?.isHidden = true
                UIView.animate(withDuration: 0.2, delay: 0, options: .curveEaseOut) {
                    self?.contentView.setNeedsLayout()
                    self?.contentView.layoutIfNeeded()
                } completion: { _ in
                    self?.delegate?.postTextDidExpand(indexPath: self?.indexPath ?? IndexPath(row: 0, section: 0))
                }

            }))
            buttonSeeMore?.setTitle("...see more", for: .normal)
            buttonSeeMore?.setTitleColor(.label, for: .normal)
            self.contentView.addSubview(buttonSeeMore!)
            buttonSeeMore?.translatesAutoresizingMaskIntoConstraints = false
            
            NSLayoutConstraint.activate([
                buttonSeeMore!.topAnchor.constraint(equalTo: postText!.bottomAnchor, constant: -Self.constraintPadding),
                buttonSeeMore!.rightAnchor.constraint(equalTo: postText!.rightAnchor)
            ])
            
        }
    }
    
    func createAssetView() {
        guard let viewModel, let postText else {return}
        
        if viewModel.postData.type == .image {
            assetView = UIImageView()
            assetView?.image = UIImage.loadLocalImageWith(name: viewModel.postData.imageName)
            assetView?.contentMode = .scaleAspectFit
            self.contentView.addSubview(assetView!)
            assetView?.translatesAutoresizingMaskIntoConstraints = false
            assetViewHeight = self.contentView.frame.width * Self.assetViewAspectRatio
            NSLayoutConstraint.activate([
                assetView!.topAnchor.constraint(equalTo: postText.bottomAnchor, constant: Self.constraintPadding*2),
                assetView!.leftAnchor.constraint(equalTo: self.contentView.leftAnchor),
                assetView!.rightAnchor.constraint(equalTo: self.contentView.rightAnchor),
                assetView!.heightAnchor.constraint(equalToConstant: assetViewHeight)
            ])
        }
        
    }
    
    
    func createFooterView() {
        guard let viewModel, let postText else {return}
        footerView = HomeFeedPostFooterView(numberOfLikes: viewModel.postData.numberOfLikes,
                                            numberOfCeleberations: viewModel.postData.numberOfCeleberations,
                                            numberOfLove: viewModel.postData.numberOfLove,
                                            numberOfSupport: viewModel.postData.numberOfSupport,
                                            numberOfLaugh: viewModel.postData.numberOfLaugh,
                                            numberOfInsightful: viewModel.postData.numberOfInsightful,
                                            numberOfCurious: viewModel.postData.numberOfCurious,
                                            numberOfComments: viewModel.postData.numberOfComments,
                                            numberOfShares: viewModel.postData.numberOfShares)
        self.contentView.addSubview(footerView!)
        footerView?.translatesAutoresizingMaskIntoConstraints = false
        
        let topAnchore = assetView != nil ? assetView!.bottomAnchor : postText.bottomAnchor
        NSLayoutConstraint.activate([
            footerView!.topAnchor.constraint(equalTo: topAnchore, constant: Self.constraintPadding*2),
            footerView!.leftAnchor.constraint(equalTo: self.contentView.leftAnchor),
            footerView!.rightAnchor.constraint(equalTo: self.contentView.rightAnchor)
        ])
    }
    
    // MARK: - Helper methods
    static func getPostTextHeight(parentSize: CGSize, viewModel: HomeFeedCellViewModel) -> CGFloat {
        if viewModel.isCellExtended {
            return viewModel.postData.description.textHeight(width: parentSize.width - Self.constraintPadding*2, textStyle: .body) ?? 10
        }
        
        return Self.getPostTextCollapsedHeight()
    }
    
    static func getPostTextCollapsedHeight() -> CGFloat {
        return CGFloat(Self.postTextNumberOfline) * (Self.postTextLineHeight+Self.postTextLineSpacing)
    }
    
    static func cellSize(parentSize: CGSize, viewModel: HomeFeedCellViewModel) -> CGSize {
        let headerViewHeight = HomeFeedPostHeaderView.viewHeight(parentSize: parentSize)
        let footerViewHeight = HomeFeedPostFooterView.viewHeight()
        let postTextHeight = Self.getPostTextHeight(parentSize: parentSize, viewModel: viewModel)
        let assetViewHeight = parentSize.width * Self.assetViewAspectRatio
        let height = Self.constraintPadding + headerViewHeight
                    + (Self.constraintPadding/2) + postTextHeight
                    + (Self.constraintPadding*2) + assetViewHeight
                    + (Self.constraintPadding*2) + footerViewHeight
        
        return CGSize(width: parentSize.width, height: height)
    }
    
    
    
}

extension HomeFeedCollectionViewCell {
    class func cellIdentifier() -> String {
        return "HomeFeedCollectionViewCellIdentifier"
    }
}
