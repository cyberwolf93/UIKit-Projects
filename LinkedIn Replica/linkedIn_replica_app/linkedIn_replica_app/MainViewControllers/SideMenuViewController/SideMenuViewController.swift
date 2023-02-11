//
//  SideMenuViewController.swift
//  linkedIn Replica
//
//  Created by Ahmed Mohiy on 18/01/2023.
//

import UIKit

class SideMenuViewController: UIViewController, DescendantforContainerTransitionController {
    
    //MARK: Variables
    static let storyboardId: String = "SideMenuViewControllerVCID"
    weak var mainContainerTransitionController: MainContainerTransitionController?
    var viewModel: SideMenuViewControllerViewModel  = SideMenuViewControllerViewModel()
    
    //MARK: View
    var stackViewHeader: UIStackView?
    var stackViewMiddle: UIStackView?
    var stackViewFooter: UIStackView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.appSecondaryBackground
        let newSafeArea = UIEdgeInsets(top: 50, left: 20, bottom: 50, right: (view.frame.width*0.2)+15)
        additionalSafeAreaInsets = newSafeArea
        addViewTransitionPanGesture()
        addHeaderView()
        addMiddleView()
        addFooterView()
    }
    
    func addViewTransitionPanGesture(){
        if let transitionContainer = self.mainContainerTransitionController {
            let gesture = UIPanGestureRecognizer(target: transitionContainer, action: #selector(transitionContainer.handlePanGestureRecognizer(_:)))
            self.view.addGestureRecognizer(gesture)
        }
    }
    
    func addHeaderView() {
        stackViewHeader = UIStackView()
        stackViewHeader?.axis = .vertical
        stackViewHeader?.distribution = .equalSpacing
        stackViewHeader?.alignment = .leading
        stackViewHeader?.spacing = 0
        
        // adding profile image
        let image = UIImage.resizeImage(image: UIImage.loadLocalImageWith(name: viewModel.profilePictureName), targetSize: CGSize(width: 60, height: 60))
        let imageView = UIImageView(image: image)
        imageView.layer.cornerRadius = 30
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        stackViewHeader?.addArrangedSubview(imageView)
        
        let nameLabel = UILabel()
        nameLabel.text = viewModel.profileName
        nameLabel.font = .preferredFont(forTextStyle: .title2)
        nameLabel.textColor = .label
        stackViewHeader?.addArrangedSubview(nameLabel)
        
        let viewProfileButton = UIButton()
        let attributedString = NSAttributedString(string: "sidemenu_view_profile".localizedString(),
                                                  attributes: [NSAttributedString.Key.font : UIFont.preferredFont(forTextStyle: .caption1),
                                                               NSAttributedString.Key.foregroundColor: UIColor.secondaryLabel])

        var configuration = UIButton.Configuration.plain()
        configuration.contentInsets = .zero
        viewProfileButton.configuration = configuration
        viewProfileButton.setAttributedTitle(attributedString, for: .normal)
        stackViewHeader?.addArrangedSubview(viewProfileButton)
        
        stackViewHeader?.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(stackViewHeader!)

        let viewSeperator = UIView()
        viewSeperator.backgroundColor = .appViewSeparator
        viewSeperator.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(viewSeperator)
        
        NSLayoutConstraint.activate([
            stackViewHeader!.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            stackViewHeader!.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            
            viewSeperator.topAnchor.constraint(equalTo: stackViewHeader!.bottomAnchor, constant: 10),
            viewSeperator.leftAnchor.constraint(equalTo: stackViewHeader!.leftAnchor),
            viewSeperator.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
            viewSeperator.heightAnchor.constraint(equalToConstant: 1)
        ])
        
        
    }
    
    func addMiddleView() {
        guard let stackViewHeader else {return }
        
        let groupsButton = UIButton()
        var attributedString = NSAttributedString(string: "sidemenu_groups".localizedString(),
                                                  attributes: [NSAttributedString.Key.font : UIFont.preferredFont(forTextStyle: .title2),
                                                               NSAttributedString.Key.foregroundColor: UIColor.label])

        var configuration = UIButton.Configuration.plain()
        configuration.titleAlignment = .leading
        configuration.contentInsets = .zero
        groupsButton.configuration = configuration
        groupsButton.setAttributedTitle(attributedString, for: .normal)
        
        let eventsButton = UIButton()
        attributedString = NSAttributedString(string: "sidemenu_events".localizedString(),
                                                  attributes: [NSAttributedString.Key.font : UIFont.preferredFont(forTextStyle: .title2),
                                                               NSAttributedString.Key.foregroundColor: UIColor.label])

        eventsButton.configuration = configuration
        eventsButton.setAttributedTitle(attributedString, for: .normal)
        
        stackViewMiddle = UIStackView()
        stackViewMiddle?.axis = .vertical
        stackViewMiddle?.distribution = .equalSpacing
        stackViewMiddle?.alignment = .leading
        stackViewMiddle?.spacing = 20
        
        stackViewMiddle?.addArrangedSubview(groupsButton)
        stackViewMiddle?.addArrangedSubview(eventsButton)
        
        stackViewMiddle?.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(stackViewMiddle!)
        
        NSLayoutConstraint.activate([
            stackViewMiddle!.topAnchor.constraint(equalTo: stackViewHeader.bottomAnchor,constant: 40),
            stackViewMiddle!.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            stackViewMiddle!.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
        ])
        
    }
    
    func addFooterView() {
        let buttonSettings = UIButton()
        buttonSettings.setTitle("Settings".localizedString(), for: .normal)
        buttonSettings.setTitleColor(.label, for: .normal)
        buttonSettings.setImage(UIImage(systemName: "gearshape.fill"), for: .normal)
        buttonSettings.tintColor = .label
        var configuration = UIButton.Configuration.plain()
        configuration.titleAlignment = .leading
        configuration.contentInsets = .zero
        configuration.imagePadding = 5
        buttonSettings.configuration = configuration
        
        stackViewFooter = UIStackView()
        stackViewFooter?.axis = .vertical
        stackViewFooter?.distribution = .equalSpacing
        stackViewFooter?.alignment = .leading
        stackViewFooter?.spacing = 20
        
        stackViewFooter?.addArrangedSubview(buttonSettings)
        stackViewFooter?.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(stackViewFooter!)
        
        let viewSeperator = UIView()
        viewSeperator.backgroundColor = .appViewSeparator
        viewSeperator.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(viewSeperator)
        
        NSLayoutConstraint.activate([
            stackViewFooter!.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            stackViewFooter!.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            
            viewSeperator.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            viewSeperator.bottomAnchor.constraint(equalTo: stackViewFooter!.topAnchor, constant: -20),
            viewSeperator.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
            viewSeperator.heightAnchor.constraint(equalToConstant: 1)
        ])
        
        
        
    }
    
}
