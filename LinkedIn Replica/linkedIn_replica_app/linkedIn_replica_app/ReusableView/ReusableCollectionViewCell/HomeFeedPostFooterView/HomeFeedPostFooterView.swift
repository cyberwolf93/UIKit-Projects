//
//  HomeFeedPostFooterView.swift
//  linkedIn Replica
//
//  Created by Ahmed Mohiy on 06/02/2023.
//

import UIKit
import linkedin_models

class HomeFeedPostFooterView: UIView {
    
    let numberOfLikes: Int64
    let numberOfCeleberations: Int64
    let numberOfLove: Int64
    let numberOfSupport: Int64
    let numberOfLaugh: Int64
    let numberOfInsightful: Int64
    let numberOfCurious: Int64
    let numberOfComments: Int64
    let numberOfShares: Int64
    var constraintPadding: CGFloat = 5
    var reactionImageWidth: CGFloat = 20
    
    //MARK: - Views
    var likesStack: UIStackView?
    var numberOfLikesLabel: UILabel?
    var numberOfSharesLabel: UILabel?
    var viewSeparator: UIView?
    var actionButtonsStack: UIStackView?
    
    init(numberOfLikes: Int64 = 0,
        numberOfCeleberations: Int64 = 0,
        numberOfLove: Int64 = 0,
         numberOfSupport: Int64 = 0,
         numberOfLaugh: Int64 = 0,
         numberOfInsightful: Int64 = 0,
         numberOfCurious: Int64 = 0,
         numberOfComments: Int64 = 0,
         numberOfShares: Int64 = 0) {
        self.numberOfLikes = numberOfLikes
        self.numberOfCeleberations = numberOfCeleberations
        self.numberOfLove = numberOfLove
        self.numberOfSupport = numberOfSupport
        self.numberOfLaugh = numberOfLaugh
        self.numberOfInsightful = numberOfInsightful
        self.numberOfCurious = numberOfCurious
        self.numberOfComments = numberOfComments
        self.numberOfShares = numberOfShares
        
        super.init(frame: .zero)
        initUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func initUI() {
        self.backgroundColor = .red
        createLikesAndShareView()
        createViewSeparator()
        createActionButtonsView()
    }
    
    func createLikesAndShareView() {
        likesStack = UIStackView()
        likesStack?.axis = .horizontal
        likesStack?.distribution = .fillProportionally
        likesStack?.spacing = -5
        
        if numberOfLikes > 0 {
            let image = UIImage.resizeImage(image: UIImage(named: "ic_like"), targetSize: CGSize(width: reactionImageWidth, height: reactionImageWidth))
            let imageView = UIImageView(image: image)
            imageView.contentMode = .scaleAspectFit
            imageView.frame = CGRect(x: 0, y: 0, width: reactionImageWidth, height: reactionImageWidth)
            likesStack?.addArrangedSubview(imageView)
        }
        
        if numberOfCeleberations > 0 {
            let image = UIImage.resizeImage(image: UIImage(named: "ic_celebrate"), targetSize: CGSize(width: reactionImageWidth, height: reactionImageWidth))
            let imageView = UIImageView(image: image)
            imageView.contentMode = .scaleAspectFit
            imageView.frame = CGRect(x: 0, y: 0, width: reactionImageWidth, height: reactionImageWidth)
            likesStack?.addArrangedSubview(imageView)
        }
        
        if numberOfSupport > 0 {
            let image = UIImage.resizeImage(image: UIImage(named: "ic_support"), targetSize: CGSize(width: reactionImageWidth, height: reactionImageWidth))
            let imageView = UIImageView(image: image)
            imageView.contentMode = .scaleAspectFit
            imageView.frame = CGRect(x: 0, y: 0, width: reactionImageWidth, height: reactionImageWidth)
            likesStack?.addArrangedSubview(imageView)
        }
        
        if numberOfLaugh > 0 {
            let image = UIImage.resizeImage(image: UIImage(named: "ic_laugh"), targetSize: CGSize(width: reactionImageWidth, height: reactionImageWidth))
            let imageView = UIImageView(image: image)
            imageView.contentMode = .scaleAspectFit
            imageView.frame = CGRect(x: 0, y: 0, width: reactionImageWidth, height: reactionImageWidth)
            likesStack?.addArrangedSubview(imageView)
        }
        
        if numberOfLove > 0 {
            let image = UIImage.resizeImage(image: UIImage(named: "ic_love"), targetSize: CGSize(width: reactionImageWidth, height: reactionImageWidth))
            let imageView = UIImageView(image: image)
            imageView.contentMode = .scaleAspectFit
            imageView.frame = CGRect(x: 0, y: 0, width: reactionImageWidth, height: reactionImageWidth)
            likesStack?.addArrangedSubview(imageView)
        }
        
        if numberOfInsightful > 0 {
            let image = UIImage.resizeImage(image: UIImage(named: "ic_insightful"), targetSize: CGSize(width: reactionImageWidth, height: reactionImageWidth))
            let imageView = UIImageView(image: image)
            imageView.contentMode = .scaleAspectFit
            imageView.frame = CGRect(x: 0, y: 0, width: reactionImageWidth, height: reactionImageWidth)
            likesStack?.addArrangedSubview(imageView)
        }
        
        if numberOfCurious > 0 {
            let image = UIImage.resizeImage(image: UIImage(named: "ic_curious"), targetSize: CGSize(width: reactionImageWidth, height: reactionImageWidth))
            let imageView = UIImageView(image: image)
            imageView.contentMode = .scaleAspectFit
            imageView.frame = CGRect(x: 0, y: 0, width: reactionImageWidth, height: reactionImageWidth)
            likesStack?.addArrangedSubview(imageView)
        }
        
        self.addSubview(likesStack!)
        likesStack?.translatesAutoresizingMaskIntoConstraints = false
        
        // create number of likes lable
        numberOfLikesLabel = UILabel()
        numberOfLikesLabel?.text = "\(numberOfLikes + numberOfCeleberations + numberOfSupport + numberOfLaugh + numberOfLove + numberOfInsightful + numberOfCurious)"
        numberOfLikesLabel?.font = UIFont.preferredFont(forTextStyle: .callout)
        numberOfLikesLabel?.textColor = .secondaryLabel
        self.addSubview(numberOfLikesLabel!)
        numberOfLikesLabel?.translatesAutoresizingMaskIntoConstraints = false
        
        
        // create number of comments and number of shares label
        var sharesAndCommentsNumberText = ""
        if numberOfComments > 0 {
            sharesAndCommentsNumberText += "\(numberOfComments) \("home_comment_plural".localizedString())"
        }
        
        if numberOfShares > 0 {
            sharesAndCommentsNumberText += "\(sharesAndCommentsNumberText.count > 0 ? " ・ " : "")"
            sharesAndCommentsNumberText += "\(numberOfShares) \("home_share_plural".localizedString())"
        }
        
        numberOfSharesLabel = UILabel()
        numberOfSharesLabel?.text = sharesAndCommentsNumberText
        numberOfSharesLabel?.font = UIFont.preferredFont(forTextStyle: .callout)
        numberOfSharesLabel?.textColor = .secondaryLabel
        self.addSubview(numberOfSharesLabel!)
        numberOfSharesLabel?.translatesAutoresizingMaskIntoConstraints = false
        
        
        NSLayoutConstraint.activate([
            likesStack!.topAnchor.constraint(equalTo: self.topAnchor),
            likesStack!.leftAnchor.constraint(equalTo: self.leftAnchor, constant: constraintPadding),
            
            numberOfLikesLabel!.topAnchor.constraint(equalTo: self.topAnchor),
            numberOfLikesLabel!.leftAnchor.constraint(equalTo: likesStack!.rightAnchor, constant: constraintPadding),
            
            numberOfSharesLabel!.topAnchor.constraint(equalTo: self.topAnchor),
            numberOfSharesLabel!.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -constraintPadding),
        ])
        
    }
    
    func createViewSeparator() {
        guard let likesStack else {return}
        viewSeparator = UIView()
        viewSeparator?.backgroundColor = UIColor.appUnselectedIcon
        self.addSubview(viewSeparator!)
        viewSeparator?.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            viewSeparator!.topAnchor.constraint(equalTo: likesStack.bottomAnchor, constant: constraintPadding*2),
            viewSeparator!.leftAnchor.constraint(equalTo: self.leftAnchor, constant: constraintPadding),
            viewSeparator!.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -constraintPadding),
            viewSeparator!.heightAnchor.constraint(equalToConstant: 1)
            
        ])
    }
    
    func createActionButtonsView() {
        guard let viewSeparator else {return}
        
        actionButtonsStack = UIStackView()
        actionButtonsStack?.axis = .horizontal
        actionButtonsStack?.distribution = .equalSpacing
        
        // like button stack
        let likeActionStack = UIStackView()
        likeActionStack.distribution = .equalSpacing
        likeActionStack.axis = .vertical
        likeActionStack.spacing = 0
        likeActionStack.tintColor = .label
        let imageLike = UIImageView(image: UIImage(systemName: "hand.thumbsup"))
        imageLike.contentMode = .top
        likeActionStack.addArrangedSubview(imageLike)
        let labelActionLike = UILabel()
        labelActionLike.text = "home_like".localizedString()
        labelActionLike.textColor = .appUnselectedIcon
        labelActionLike.font = .preferredFont(forTextStyle: .caption1)
        likeActionStack.addArrangedSubview(labelActionLike)
        actionButtonsStack?.addArrangedSubview(likeActionStack)
        
        // comment button stack
        let commentActionStack = UIStackView()
        commentActionStack.distribution = .equalSpacing
        commentActionStack.spacing = 0
        commentActionStack.tintColor = .label
        commentActionStack.axis = .vertical
        let imageComment = UIImageView(image: UIImage(systemName: "text.bubble"))
        imageComment.contentMode = .top
        commentActionStack.addArrangedSubview(imageComment)
        let labelActionComment = UILabel()
        labelActionComment.text = "home_comment_singular".localizedString()
        labelActionComment.textColor = .appUnselectedIcon
        labelActionComment.font = .preferredFont(forTextStyle: .caption1)
        commentActionStack.addArrangedSubview(labelActionComment)
        actionButtonsStack?.addArrangedSubview(commentActionStack)
        
        // share button stack
        let shareActionStack = UIStackView()
        shareActionStack.distribution = .equalSpacing
        shareActionStack.axis = .vertical
        shareActionStack.spacing = 0
        shareActionStack.tintColor = .label
        let imageShare = UIImageView(image: UIImage(systemName: "arrow.turn.up.right"))
        imageShare.contentMode = .top
        shareActionStack.addArrangedSubview(imageShare)
        let labelActionShare = UILabel()
        labelActionShare.text = "home_share_singular".localizedString()
        labelActionShare.textColor = .appUnselectedIcon
        labelActionShare.font = .preferredFont(forTextStyle: .caption1)
        shareActionStack.addArrangedSubview(labelActionShare)
        actionButtonsStack?.addArrangedSubview(shareActionStack)
        
        
        // comment button stack
        let sendActionStack = UIStackView()
        sendActionStack.distribution = .equalSpacing
        sendActionStack.axis = .vertical
        sendActionStack.spacing = 0
        sendActionStack.tintColor = .label
        let imageSend = UIImageView(image: UIImage(systemName: "paperplane.fill"))
        imageSend.contentMode = .top
        sendActionStack.addArrangedSubview(imageSend)
        let labelActionSend = UILabel()
        labelActionSend.text = "home_send".localizedString()
        labelActionSend.textColor = .appUnselectedIcon
        labelActionSend.font = .preferredFont(forTextStyle: .caption1)
        sendActionStack.addArrangedSubview(labelActionSend)
        actionButtonsStack?.addArrangedSubview(sendActionStack)
        
        self.addSubview(actionButtonsStack!)
        actionButtonsStack?.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            actionButtonsStack!.topAnchor.constraint(equalTo: viewSeparator.bottomAnchor, constant: constraintPadding),
            actionButtonsStack!.leftAnchor.constraint(equalTo: self.leftAnchor, constant: constraintPadding*5),
            actionButtonsStack!.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -constraintPadding*5)
        ])
        
    }
    
    static func viewHeight() -> CGFloat {
        return 80
    }
    
}
