//
//  FoodEntryCollectionViewCell.swift
//  CalTracker
//
//  Created by Ahmed Mohiy on 24/10/2022.
//

import UIKit
import NetworkCore

protocol FoodEntryCollectionViewCellDelegate: NSObjectProtocol {
    func buttonEditDidClicked(foodEntry: FoodEntry?)
    func buttonDeleteDidClicked(foodEntry: FoodEntry?)
}


class FoodEntryCollectionViewCell: UICollectionViewCell {

    // MARK: Outlets
    @IBOutlet weak var viewParent: UIView!
    @IBOutlet weak var imageViewFoodEntry: UIImageView!
    @IBOutlet weak var labelName: UILabel!
    @IBOutlet weak var labelDate: UILabel!
    @IBOutlet weak var labelTime: UILabel!
    @IBOutlet weak var labelCalories: UILabel!
    @IBOutlet weak var buttonEdit: UIButton!
    @IBOutlet weak var buttonDelete: UIButton!
    
    
    //MARK: Variables
    weak var delegate: FoodEntryCollectionViewCellDelegate?
    var viewModel: FoodEntryCollectionViewCellViewModel? {
        didSet {
            labelName.text = self.viewModel?.foodEntry.name
            labelDate.text = self.viewModel?.foodEntry.date
            labelTime.text = self.viewModel?.foodEntry.time
            labelCalories.text = "\(String.localizedString(with: "calories")): \(self.viewModel?.foodEntry.calValue ?? 0)"
            imageViewFoodEntry.sd_setImage(with: URL(string: PlistManager.shared.base_url + (self.viewModel?.foodEntry.thumbUrl ?? "")),
                                           placeholderImage: UIImage(systemName: "photo.fill")?.withTintColor(.lightGray2,
                                                                                                              renderingMode: .alwaysOriginal))
        }
    }
    
    // MARK: View lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        
        initUI()
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        self.addShadow()

        
    }

    //MARK: UI customization
    func initUI() {
        // Labels
        labelName.textColor = .mainTextReversed
        labelName.font = UIFont.systemFont(ofSize: 20)
        labelDate.textColor = .lightGray2
        labelDate.font = UIFont.systemFont(ofSize: 15)
        labelTime.textColor = .lightGray2
        labelTime.font = UIFont.systemFont(ofSize: 15)
        labelCalories.textColor = .mainTextReversed
        labelCalories.font = UIFont.systemFont(ofSize: 15)
        
        // View parent
        viewParent.addCornerRadius(with: 10)
        viewParent.backgroundColor = .white
        
        // Buttons
        buttonEdit.setTitle("", for: .normal)
        buttonEdit.imageView?.transform = CGAffineTransform(scaleX: 2, y: 2)
        
        buttonDelete.setTitle("", for: .normal)
        buttonDelete.imageView?.transform = CGAffineTransform(scaleX: 1.1, y: 1.1)
        
    }
    
    // MARK: Actions
    @IBAction func buttonEditClicked(_ sender: Any) {
        self.delegate?.buttonEditDidClicked(foodEntry: self.viewModel?.foodEntry)
    }
    
    @IBAction func buttonDeleteClicked(_ sender: Any) {
        self.delegate?.buttonDeleteDidClicked(foodEntry: self.viewModel?.foodEntry)
    }
    
    
    class func cellIdentifier() -> String {
        return "FoodEntryCollectionViewCell"
    }
    
    class func cellNib() -> UINib {
        return UINib(nibName: Self.cellIdentifier(), bundle: Bundle.main)
    }
    
    
}
