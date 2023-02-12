//
//  MyNetworkCellContainer.swift
//  linkedIn_replica_app
//
//  Created by Ahmed Mohiy on 12/02/2023.
//

import UIKit

class MyNetworkCellContainer: UICollectionViewCell {
    
    var firstView: UIView = UIView()
    var secondView: UIView = UIView()
    var thirdView: UIView = UIView()
    var fourthView: UIView = UIView()
    
    //MARK: Variables
    let constraintPading: CGFloat = 10
    let numberOfViews = 4
    let cardWidthMultiplier:CGFloat = 0.46
    let cardHeightMultiplier:CGFloat = 0.47
    lazy var parentViews: [UIView] = {
       return [firstView, secondView, thirdView, fourthView]
    }()
    var viewModel: MyNetworkCellContainerViewModel? {
        didSet {
            initUI()
            createPersonsUI()
        }
    }
    
    //MARK: view initialization
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.contentView.backgroundColor = .appSecondaryBackground
    }
    
    override func prepareForReuse() {
        removeAllSubviews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func initUI() {
        self.contentView.addSubview(firstView)
        self.contentView.addSubview(secondView)
        self.contentView.addSubview(thirdView)
        self.contentView.addSubview(fourthView)
        
        firstView.translatesAutoresizingMaskIntoConstraints = false
        secondView.translatesAutoresizingMaskIntoConstraints = false
        thirdView.translatesAutoresizingMaskIntoConstraints = false
        fourthView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            firstView.topAnchor.constraint(equalTo: self.contentView.topAnchor,constant: constraintPading),
            firstView.leftAnchor.constraint(equalTo: self.contentView.leftAnchor, constant: constraintPading),
            firstView.heightAnchor.constraint(equalTo: self.contentView.heightAnchor, multiplier: cardHeightMultiplier),
            firstView.widthAnchor.constraint(equalTo: self.contentView.widthAnchor, multiplier: cardWidthMultiplier),
            
            secondView.topAnchor.constraint(equalTo: self.contentView.topAnchor,constant: constraintPading),
            secondView.rightAnchor.constraint(equalTo: self.contentView.rightAnchor, constant: -constraintPading),
            secondView.heightAnchor.constraint(equalTo: self.contentView.heightAnchor, multiplier: cardHeightMultiplier),
            secondView.widthAnchor.constraint(equalTo: self.contentView.widthAnchor, multiplier: cardWidthMultiplier),
            
            thirdView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor,constant: -constraintPading),
            thirdView.leftAnchor.constraint(equalTo: self.contentView.leftAnchor, constant: constraintPading),
            thirdView.heightAnchor.constraint(equalTo: self.contentView.heightAnchor, multiplier: cardHeightMultiplier),
            thirdView.widthAnchor.constraint(equalTo: self.contentView.widthAnchor, multiplier: cardWidthMultiplier),
            
            fourthView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor,constant: -constraintPading),
            fourthView.rightAnchor.constraint(equalTo: self.contentView.rightAnchor, constant: -constraintPading),
            fourthView.heightAnchor.constraint(equalTo: self.contentView.heightAnchor, multiplier: cardHeightMultiplier),
            fourthView.widthAnchor.constraint(equalTo: self.contentView.widthAnchor, multiplier: cardWidthMultiplier),
        ])
        
        for view in parentViews {
            view.layer.cornerRadius = 15
            view.layer.borderWidth = 1
            view.layer.borderColor = UIColor.appViewSeparator.cgColor
            view.clipsToBounds = true
        }
    }
    
    func createPersonsUI() {
        guard let viewModel else {return}
        removeAllSubviews()
        let count = min(numberOfViews, viewModel.persons.count)
        for i in 0 ..< count {
            let person = viewModel.persons[i]
            let personViewModel = MyNetworkCollectionViewCellViewModel(person: person)
            if let viewPerson = Bundle.main.loadNibNamed(MyNetworkCollectionViewCell.nibName(), owner: MyNetworkCollectionViewCell.self)?.first as? MyNetworkCollectionViewCell {
                
                viewPerson.viewModel = personViewModel
                let parentView = parentViews[i]
                parentView.addSubview(viewPerson)
                viewPerson.translatesAutoresizingMaskIntoConstraints = false
                NSLayoutConstraint.activate([
                    viewPerson.topAnchor.constraint(equalTo: parentView.topAnchor),
                    viewPerson.rightAnchor.constraint(equalTo: parentView.rightAnchor),
                    viewPerson.bottomAnchor.constraint(equalTo: parentView.bottomAnchor),
                    viewPerson.leftAnchor.constraint(equalTo: parentView.leftAnchor),
                ])
            }
            
            
        }
    }
    
    
    func removeAllSubviews() {
        for view in parentViews {
            for subView in view.subviews {
                subView.removeFromSuperview()
            }
        }
    }
    
    class func cellIdentifier() -> String {
        return "MyNetworkCellContainerIdentifier"
    }
    
    class func cellHeight() -> CGFloat {
        return 550
    }
}
