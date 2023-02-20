//
//  MessageTableViewCell.swift
//  linkedIn_replica_app
//
//  Created by Ahmed Mohiy on 13/02/2023.
//

import UIKit

protocol MessageTableViewCellDatasource: NSObjectProtocol {
    func getParentPanGesture() -> UIPanGestureRecognizer
}

class MessageTableViewCell: UITableViewCell {
    
    //MARK: Outlets
    @IBOutlet weak var viewParent: UIView!
    @IBOutlet weak var logoImage: UIImageView!
    @IBOutlet weak var labelName: UILabel!
    @IBOutlet weak var labelMessage: UILabel!
    @IBOutlet weak var labelDate: UILabel!
    @IBOutlet weak var viewSeparator: UIView!
    
    //MARK: Views
    lazy var markAsReadView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 62/255, green: 160/255, blue: 85/255, alpha: 1)
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(markAsReadViewClicked))
        view.isUserInteractionEnabled = true
        view.addGestureRecognizer(tapRecognizer)
        contentView.isUserInteractionEnabled = true
        view.translatesAutoresizingMaskIntoConstraints = false
        self.contentView.insertSubview(view, at: 0)
        let width = Self.cellHeight()
        NSLayoutConstraint.activate([
            view.topAnchor.constraint(equalTo: contentView.topAnchor),
            view.rightAnchor.constraint(equalTo: contentView.rightAnchor),
            view.widthAnchor.constraint(equalToConstant: width),
            view.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
        return view
    }()
    
    lazy var archiveView: UIView = {
        let view = UIView()
        view.backgroundColor = .lightGray
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(archiveViewClicked))
        view.isUserInteractionEnabled = true
        view.addGestureRecognizer(tapRecognizer)
        contentView.isUserInteractionEnabled = true
        view.translatesAutoresizingMaskIntoConstraints = false
        self.contentView.insertSubview(view, at: 0)
        let width = Self.cellHeight()
        NSLayoutConstraint.activate([
            view.topAnchor.constraint(equalTo: contentView.topAnchor),
            view.rightAnchor.constraint(equalTo: contentView.rightAnchor),
            view.widthAnchor.constraint(equalToConstant: width),
            view.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
        return view
    }()
    
    //MARK: Variables
    var datasource: MessageTableViewCellDatasource?
    let cellGesture:UIPanGestureRecognizer = UIPanGestureRecognizer()
    var viewModel: MessageTableViewCellViewModel? {
        didSet {
            guard let viewModel else {return}
            labelName.text = viewModel.message.person.name
            labelMessage.text = viewModel.message.message.last
            logoImage.image = UIImage.loadLocalImageWith(name: viewModel.message.person.profileImageUrl)
            labelDate.text = viewModel.message.date.dateForMessage()
            
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        initUI()
        creatActionButtons()
        cellGesture.addTarget(self, action: #selector(contentViewPanGesture(_:)))
        cellGesture.delegate = self
        self.contentView.addGestureRecognizer(cellGesture)
    }
    
    override func prepareForReuse() {
        labelName.text = nil
        labelMessage.text = nil
        labelDate.text = nil
        logoImage.image = nil
    }
    
    // MARK: - UI customization
    func initUI() {
        viewParent.backgroundColor = .appSecondaryBackground
        logoImage.layer.cornerRadius = (Self.cellHeight() * 0.7) / 2
        logoImage.contentMode = .scaleAspectFill
        
        labelName.textColor = .label
        labelName.font = .preferredFont(forTextStyle: .body)
        
        labelMessage.textColor = .secondaryLabel
        labelMessage.font = .preferredFont(forTextStyle: .caption1)
        
        labelDate.textColor = .secondaryLabel
        labelDate.font = .preferredFont(forTextStyle: .caption1)
    }
    
    func creatActionButtons() {
        // create mark as read view
        let imageViewMarkAsRead = UIImageView(image: UIImage(systemName: "envelope.open"))
        imageViewMarkAsRead.tintColor = .label
        imageViewMarkAsRead.contentMode = .center
        let labelMarkAsRead = UILabel()
        labelMarkAsRead.text = "message_mark_as_read".localizedString()
        labelMarkAsRead.font = .preferredFont(forTextStyle: .body)
        labelMarkAsRead.textColor = .label
        labelMarkAsRead.numberOfLines = 0
        labelMarkAsRead.textAlignment = .center
        let stackViewMarkAsRead = UIStackView()
        stackViewMarkAsRead.axis = .vertical
        stackViewMarkAsRead.distribution = .fillProportionally
        stackViewMarkAsRead.spacing = 0
        stackViewMarkAsRead.addArrangedSubview(imageViewMarkAsRead)
        stackViewMarkAsRead.addArrangedSubview(labelMarkAsRead)
        stackViewMarkAsRead.translatesAutoresizingMaskIntoConstraints = false
        markAsReadView.addSubview(stackViewMarkAsRead)
        NSLayoutConstraint.activate([
            stackViewMarkAsRead.topAnchor.constraint(equalTo: markAsReadView.topAnchor, constant: 5),
            stackViewMarkAsRead.bottomAnchor.constraint(equalTo: markAsReadView.bottomAnchor, constant: -5),
            stackViewMarkAsRead.leftAnchor.constraint(equalTo: markAsReadView.leftAnchor,constant: 5),
            stackViewMarkAsRead.rightAnchor.constraint(equalTo: markAsReadView.rightAnchor,constant: -5),
        ])
        
        
        
        // create Archive view
        let imageViewArchive = UIImageView(image: UIImage(systemName: "square.and.arrow.down"))
        imageViewArchive.tintColor = .label
        imageViewArchive.contentMode = .center
        let labelArchive = UILabel()
        labelArchive.text = "message_archive".localizedString()
        labelArchive.font = .preferredFont(forTextStyle: .body)
        labelArchive.textColor = .label
        labelArchive.numberOfLines = 0
        labelArchive.textAlignment = .center
        let stackViewArchive = UIStackView()
        stackViewArchive.axis = .vertical
        stackViewArchive.distribution = .fillProportionally
        stackViewArchive.spacing = 0
        stackViewArchive.addArrangedSubview(imageViewArchive)
        stackViewArchive.addArrangedSubview(labelArchive)
        stackViewArchive.translatesAutoresizingMaskIntoConstraints = false
        archiveView.addSubview(stackViewArchive)
        NSLayoutConstraint.activate([
            stackViewArchive.topAnchor.constraint(equalTo: archiveView.topAnchor, constant: 5),
            stackViewArchive.bottomAnchor.constraint(equalTo: archiveView.bottomAnchor,constant: -5),
            stackViewArchive.leftAnchor.constraint(equalTo: archiveView.leftAnchor,constant: 5),
            stackViewArchive.rightAnchor.constraint(equalTo: archiveView.rightAnchor,constant: -5),
        ])
        
    }
    
    // MARK: - Actions
    @objc
    func markAsReadViewClicked() {
        
    }
    
    @objc
    func archiveViewClicked() {
        
    }
    
    @objc
    func contentViewPanGesture(_ gesture: UIPanGestureRecognizer) {
        switch gesture.state{
        case .began, .changed:
            let viewParentX = self.viewParent.frame.origin.x + gesture.translation(in: gesture.view).x
            let markAsReadX = self.markAsReadView.frame.origin.x + (gesture.translation(in: gesture.view).x / 2)
            
            self.markAsReadView.frame.origin.x  = (markAsReadX + markAsReadView.frame.width)  > archiveView.frame.origin.x ?
                                                    markAsReadX :
                                                archiveView.frame.origin.x-markAsReadView.frame.width
            
            self.viewParent.frame.origin.x = viewParentX + viewParent.frame.width > markAsReadView.frame.origin.x ? viewParentX : markAsReadView.frame.origin.x - viewParent.frame.width
            
            break
        case .ended:
            if self.viewParent.center.x < (contentView.center.x / 2) {
                UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseOut) {
                    self.markAsReadView.frame.origin.x = self.contentView.frame.maxX - (self.markAsReadView.frame.width * 2)
                    self.viewParent.frame.origin.x = self.markAsReadView.frame.origin.x - self.viewParent.frame.width
                }
            } else {
                UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseOut) {
                    self.viewParent.frame.origin.x = self.contentView.frame.origin.x
                    self.markAsReadView.frame.origin.x = self.contentView.frame.maxX - self.markAsReadView.frame.width
                }
            }
            
            break
            
        default:
            break
        }
        
        gesture.setTranslation(.zero, in: self.viewParent)
        gesture.setTranslation(.zero, in: self.markAsReadView)
    }
    
    
    //MARK: - Static helper functions
    
    class func cellIdentifier() -> String {
        return "MessageTableViewCellIdentifier"
    }
    
    class func cellNib() -> UINib {
        return UINib(nibName: "MessageTableViewCell", bundle: nil)
    }
    
    class func cellHeight() -> CGFloat {
        return 80
    }
    
}

extension MessageTableViewCell {
    
    override func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        if cellGesture == gestureRecognizer,
           cellGesture.velocity(in: cellGesture.view).x > 0,
           viewParent.frame.origin.x == 0 {
            return false
        }
        
        return true
    }
    
//    override func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRequireFailureOf otherGestureRecognizer: UIGestureRecognizer) -> Bool {
//
//        guard let parentGesture = datasource?.getParentPanGesture() else {return false}
//
//        if parentGesture == otherGestureRecognizer &&  cellGesture == gestureRecognizer {
//            return true
//        }
//
//        return false
//    }
}
