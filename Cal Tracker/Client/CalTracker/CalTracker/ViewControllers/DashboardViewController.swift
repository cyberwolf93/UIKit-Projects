//
//  DashboardViewController.swift
//  CalTracker
//
//  Created by Ahmed Mohiy on 23/10/2022.
//
import NetworkCore
import UIKit

class DashboardViewController: UIViewController {
    
    //MARK: Outlets
    
    @IBOutlet weak var viewParent: UIView!
    @IBOutlet weak var entriesCollectionView: UICollectionView!
    @IBOutlet weak var buttonFilter: UIButton!
    @IBOutlet weak var buttonFilterByUser: UIButton!
    @IBOutlet weak var buttonMoreCaloriesDetails: UIButton!
    @IBOutlet weak var labelCollectionTitle: UILabel!
    @IBOutlet weak var viewCaloriesDetails: UIView!
    @IBOutlet weak var viewCaloriesProgressContainer: UIView!
    @IBOutlet weak var labelCalories: UILabel!
    @IBOutlet weak var labelCaloriesValue: UILabel!
    @IBOutlet weak var imageViewWarning: UIImageView!
    @IBOutlet weak var labelWarning: UILabel!
    @IBOutlet weak var viewCaloriesParent: UIView!
    @IBOutlet weak var viewCollectionHeader: UIView!
    @IBOutlet weak var heightConstraintViewCaloriesParent: NSLayoutConstraint!
    var viewCaloriesProgress: UIView?
    
    
    //MARK: Variables
    let viewModel = DashboardViewModel(foodEntryCoreManager: FoodEntryCoreManager(engine: NetworkEngine(), authToken: AppPreferences.shared.getUserToken()),
                                       userCoreManager: UserCoreManager(engine: NetworkEngine(), authToken: AppPreferences.shared.getUserToken()))

    //MARK: View life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.viewParent.addGradientBackground(with: [UIColor.darkBlue1.cgColor, UIColor.darkBlue2.cgColor])
        viewModel.delegate = self
        caloriesViewUI()
        warningViewUI()
        collectionViewUI()
        caloriesProgressUI()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewControllerTitleUI()
        self.view.showLoading()
        self.viewModel.fetchAllEntries()
    }
    
    override func viewWillLayoutSubviews() {
        viewCaloriesProgressContainer.addGradientLeftToRight(with: [UIColor.lightGray1.cgColor, UIColor.lightGray2.cgColor])
        viewCaloriesProgressContainer.addCornerRadius(with: viewCaloriesProgressContainer.bounds.height / 2)
        viewCaloriesProgress?.addCornerRadius(with: (viewCaloriesProgress?.bounds.height ?? 0)/2)
        viewCollectionHeader.addCornerRadius(with: 10)
        viewCaloriesParent.addCornerRadius(with: 10)
        
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .darkContent
    }
    
    
    //MARK: View UI
    func viewControllerTitleUI() {
        self.parent?.title =  String.localizedString(with: "dashboard")
        self.parent?.navigationItem.rightBarButtonItem?.tintColor = .darkBlue2
        let textAttributes = [NSAttributedString.Key.foregroundColor:UIColor.black]
        self.parent?.navigationController?.navigationBar.titleTextAttributes = textAttributes
    }
    
    func caloriesViewUI() {
        // hide the calories details when the user role is admin
        if self.viewModel.userIsAdmin() {
            self.viewCaloriesParent.isHidden = true
            heightConstraintViewCaloriesParent.constant = 0
            return
        }
        
        // update view calories parent
        viewCaloriesParent.backgroundColor = .white
        
        // Label holding calories title
        labelCalories.font = UIFont.systemFont(ofSize: 35)
        labelCalories.textColor = .mainTextReversed
        labelCalories.text = String.localizedString(with: "today_calories")
        
        let calValue = "0"
        let calLimit = "/\(viewModel.getCaloriesLimit())"
        let calValueAttributes = NSMutableAttributedString(string: calValue,
                                                     attributes: [NSAttributedString.Key.font:UIFont.systemFont(ofSize: 30),
                                                                  NSAttributedString.Key.foregroundColor: UIColor.greenColor])
        let calLimitAttributes = NSMutableAttributedString(string: calLimit,
                                                     attributes: [NSAttributedString.Key.font:UIFont.systemFont(ofSize: 15),
                                                                  NSAttributedString.Key.foregroundColor: UIColor.black])
        let combination = NSMutableAttributedString()
        combination.append(calValueAttributes)
        combination.append(calLimitAttributes)
        labelCaloriesValue.attributedText = combination
        
        // viewCaloriesParent
        viewCaloriesParent.addShadow()
    }
    
    func warningViewUI() {
        // Label limit warning
        labelWarning.font = UIFont.systemFont(ofSize: 15)
        labelWarning.isHidden = true
        imageViewWarning.isHidden = true
    }
    
    func collectionViewUI() {
        // Label collection view Title
        labelCollectionTitle.font = UIFont.systemFont(ofSize: 16)
        labelCollectionTitle.textColor = .mainTextReversed
        labelCollectionTitle.text = self.viewModel.getCollectionViewTitle()
        // label filer entries
        buttonFilter.tintColor = .lightBlue1
        buttonFilter.setTitle("", for: .normal)
        buttonFilterByUser.tintColor = .lightBlue1
        buttonFilterByUser.setTitle("", for: .normal)
        buttonFilterByUser.isHidden = !self.viewModel.userIsAdmin()
        buttonMoreCaloriesDetails.tintColor = .lightBlue1
        buttonMoreCaloriesDetails.setTitle("", for: .normal)
        
        // Collection view header
        viewCollectionHeader.backgroundColor = .white
        
        // Collection View
        entriesCollectionView.delegate = self
        entriesCollectionView.dataSource = self
        entriesCollectionView.register(FoodEntryCollectionViewCell.cellNib(),
                                       forCellWithReuseIdentifier: FoodEntryCollectionViewCell.cellIdentifier())
    }
    
    func caloriesProgressUI() {
        // progress container
        viewCaloriesProgressContainer.backgroundColor = .clear
        
        viewCaloriesProgress = UIView()
        viewCaloriesProgress?.backgroundColor = .clear
        viewCaloriesProgressContainer.addSubview(viewCaloriesProgress!)
    }
    
    
    //MARK: Update UI
    func updateAfterFetchingData() {
        
        
        
        let count = viewModel.numberOfCaloriesOfToday()
        let limit = viewModel.getCaloriesLimit()
        
        // Update user total calories number
        let calLimit = "/\(limit)"
        let calValueAttributes = NSMutableAttributedString(string: "\(count)",
                                                     attributes: [NSAttributedString.Key.font:UIFont.systemFont(ofSize: 30),
                                                                  NSAttributedString.Key.foregroundColor: count == 0 ? UIColor.lightGray2 : UIColor.greenColor])
        let calLimitAttributes = NSMutableAttributedString(string: calLimit,
                                                     attributes: [NSAttributedString.Key.font:UIFont.systemFont(ofSize: 15),
                                                                  NSAttributedString.Key.foregroundColor: UIColor.black])
        let combination = NSMutableAttributedString()
        combination.append(calValueAttributes)
        combination.append(calLimitAttributes)
        labelCaloriesValue.attributedText = combination
        
        
        // Update progress bar
        let caloriesPercentage  = count < limit ? CGFloat( (Double(count) / Double(limit)) ) : 1
        let constant = viewCaloriesProgressContainer.bounds.width * caloriesPercentage
        self.viewCaloriesProgress?.frame = CGRect(x: 0, y: 0, width: constant, height: self.viewCaloriesProgressContainer.frame.height)
        if count <= limit {
            self.viewCaloriesProgress?.addGradientLeftToRight(with: [UIColor.greenColor.cgColor, UIColor.greenColor.cgColor] )
        } else {
            self.viewCaloriesProgress?.addGradientLeftToRight(with: [UIColor.darkRed1.cgColor, UIColor.darkRed2.cgColor])
        }
        
        
        
        // Update Warning image
        imageViewWarning.isHidden = false
        labelWarning.isHidden = false
        if count == 0 {
            imageViewWarning.image = UIImage(systemName: "exclamationmark.octagon")?.withTintColor(.lightGray2, renderingMode: .alwaysOriginal)
            labelWarning.textColor = .lightGray2
            labelWarning.text = String.localizedString(with: "add_calories")
        }
        else if count <= limit {
            imageViewWarning.image = UIImage(systemName: "checkmark.seal.fill")?.withTintColor(.greenColor, renderingMode: .alwaysOriginal)
            labelWarning.textColor = .greenColor
            labelWarning.text = String.localizedString(with: "acceptable")
        } else {
            imageViewWarning.image = UIImage(systemName: "exclamationmark.triangle")?.withTintColor(.darkRed1, renderingMode: .alwaysOriginal)
            labelWarning.textColor = .darkRed1
            labelWarning.text = String.localizedString(with: "over_limit")
        }
        
        //Update user filer icon
        buttonFilter.setImage(self.viewModel.getFilterByDateImage(), for: .normal)
        buttonFilterByUser.setImage(self.viewModel.getFilterByUserImage(), for: .normal)
        
        // Update CollectionView Title
        labelCollectionTitle.text = self.viewModel.getCollectionViewTitle()
        
        //reload collection view
        self.entriesCollectionView.reloadData()
        
        
    }
    
    
    //MARK: Actions
    @IBAction func buttonFilterByUserClicked(_ sender: Any) {
        
        let alertController = UIAlertController(title: "", message: "", preferredStyle: .actionSheet)
        alertController.createFilterByUser(delegate: self, dataSource: self)
        let doneAction = UIAlertAction(title: "Done", style: .default, handler: {  _ in
            self.view.showLoading()
            self.viewModel.applyFilter()
            alertController.dismiss(animated: true)
            self.updateStatusBarAppearance()
        })
        
        let resetAction = UIAlertAction(title: "Reset", style: .destructive, handler: {  _ in
            self.view.showLoading()
            self.viewModel.resetUserFilter()
            alertController.dismiss(animated: true)
            self.updateStatusBarAppearance()
        })
        
        
        alertController.addAction(doneAction)
        alertController.addAction(resetAction)
        self.present(alertController, animated: true)
        
    }
    
    @IBAction func buttonFilerClicked(_ sender: Any) {
        let filterDateViewController = FilterByDateViewController()
        filterDateViewController.parentPresenter = self
        filterDateViewController.from = self.viewModel.filteredFromDate
        filterDateViewController.to = self.viewModel.filteredToDate
        filterDateViewController.saveCompletion = { dateRange in
            if let dateRange {
                self.view.showLoading()
                if dateRange.0.isEmpty || dateRange.1.isEmpty {
                    self.viewModel.resetDateFilter()
                } else {
                    self.viewModel.setFilterDateFrom(dateRange.0)
                    self.viewModel.setFilterDateTo(dateRange.1)
                    self.viewModel.applyFilter()
                }
                
            }
        }
        
        if let sheet = filterDateViewController.sheetPresentationController {
            sheet.detents = [.medium()]
        }
        
        self.present(filterDateViewController, animated: true)
    }
    
    @IBAction func buttonDetailsClicked() {
        var list:[FoodEntry] = []
        var title = ""
        var userCalLimit = 0
        if self.viewModel.userIsAdmin() {
            if let user = self.viewModel.getSelectedUser() {
                list = self.viewModel.getSelectedUserList()
                title = user.name
                userCalLimit = user.calLimit
            } else {
                self.showErrorAlert(message: String.localizedString(with: "admin_failed_select_user"))
                return
            }
            
        }
        
        if let user = self.viewModel.getUserIfNormal() {
            list = self.viewModel.getFoodSortedList()
            userCalLimit = user.calLimit
        }
        
        guard !list.isEmpty else {
            self.showErrorAlert(message: String.localizedString(with: "no_entry_to_show"))
            return
        }
        
        
        // Create Calories list View Controller
        let viewController = CaloriesAnalyticsViewController()
        viewController.list = list
        viewController.userCalLimit = userCalLimit
        viewController.parentPresenter = self
        
        // create navigation crontroller for Calories list view controller
        let navigationController = UINavigationController()
        navigationController.addChild(viewController)
        navigationController.modalPresentationStyle = .pageSheet
        let textAttributes = [NSAttributedString.Key.foregroundColor:UIColor.mainTextReversed]
        navigationController.navigationBar.titleTextAttributes = textAttributes
        
        if let sheet = navigationController.sheetPresentationController {
            sheet.detents = [.large()]
            sheet.presentingViewController.title = title
        }
        
        
        self.present(navigationController, animated: true)
            
        
    }
    
    
    
    
}

// MARK: ViewModel delegate
extension DashboardViewController: DashboardViewModelDelegate {
    
    func fetchDidSucceeded() {
        DispatchQueue.main.async { 
            self.view.hideLoading()
            self.updateAfterFetchingData()
        }
    }
    
    func fetchDidFailed(error: Error?) {
        DispatchQueue.main.async {
            self.view.hideLoading()
        }
    }
    
    func deleteItemDidSucceded() {
        DispatchQueue.main.async {
            self.view.hideLoading()
            self.viewModel.applyFilter()
        }
    }
    
    func deleteItemDidFailed(error: Error?) {
        DispatchQueue.main.async {
            self.view.hideLoading()
            self.showErrorAlert(message: String.localizedString(with: "delete_food_item_dailed"))
        }
    }
}


// MARK: Collection View Delegate and datasource
extension DashboardViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView.tag == UICollectionView.tagEnum.filterByUser.rawValue {
            return self.viewModel.getAllUsers().count
        }
        return self.viewModel.getFilterdFoodEntries().count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView.tag == UICollectionView.tagEnum.filterByUser.rawValue {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FilterbyUserActionSheetCollectionViewCell.cellIdentifier(),
                                                          for: indexPath) as! FilterbyUserActionSheetCollectionViewCell
            cell.cellText = self.viewModel.getAllUsers()[indexPath.row].name
            return cell
        }
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FoodEntryCollectionViewCell.cellIdentifier(),
                                                      for: indexPath) as! FoodEntryCollectionViewCell
        
        let foodEntry = self.viewModel.getFilterdFoodEntries()[indexPath.row]
        cell.viewModel = FoodEntryCollectionViewCellViewModel(foodEntry: foodEntry)
        cell.delegate = self
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if  collectionView.tag == UICollectionView.tagEnum.filterByUser.rawValue {
            return CGSize(width: collectionView.frame.width - 20, height: 40)
        }
        return CGSize(width: collectionView.frame.width - 20  , height: 100)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        if  collectionView.tag == UICollectionView.tagEnum.filterByUser.rawValue {
            return 0
        }
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        if  collectionView.tag == UICollectionView.tagEnum.filterByUser.rawValue {
            return 0
        }
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        if  collectionView.tag == UICollectionView.tagEnum.filterByUser.rawValue {
            return UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        }
        return UIEdgeInsets(top: 5, left: 10, bottom: 10, right: 10)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if  collectionView.tag == UICollectionView.tagEnum.filterByUser.rawValue {
            self.viewModel.setSelectedUser(user: self.viewModel.getAllUsers()[indexPath.row])
        }
    }
    
    
    
}

// MARK: FoodEntryCollectionViewCell delaget
extension DashboardViewController: FoodEntryCollectionViewCellDelegate {
    func buttonDeleteDidClicked(foodEntry: FoodEntry?) {
        guard let foodEntry else {
            return
        }
        self.view.showLoading()
        self.viewModel.deleteFoodEntry(with: foodEntry)
        
    }
    
    func buttonEditDidClicked(foodEntry: FoodEntry?) {
        if let foodEntry  {
            self.navigationController?.showAddEntryViewController(with: self, userId: foodEntry.userId , screenMode: .edit, foodEntry: foodEntry)
        }
        
    }
}


// MARK: - Add new food entry delegate
// to notify this view controller after finish
extension DashboardViewController: AddFoodEntryViewControllerDelegate {
    func notifyParent() {
        self.view.showLoading()
        self.viewModel.fetchAllEntries()
    }
}

