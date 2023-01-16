//
//  CaloriesAnalyticsViewController.swift
//  CalTracker
//
//  Created by Ahmed Mohiy on 25/10/2022.
//

import UIKit

class CaloriesAnalyticsViewController: UIViewController {
    
    //MARK: - Views
    var tableView: UITableView?
    
    //MARK: Variables
    let tableViewCellIdentifier = "tableViewCellIdentifier"
    var list:[FoodEntry] = []
    var userCalLimit = 0
    let viewModel = CaloriesListViewModel()
    weak var parentPresenter: UIViewController?
    
    // MARK: - View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .clear
        self.navigationController?.navigationBar.barTintColor = .white.withAlphaComponent(0.1)
        self.view.addGradientBackground(with: [UIColor.darkBlue1.cgColor, UIColor.darkBlue2.cgColor])
        viewModel.userCalLimit = userCalLimit
        viewModel.prepareCaloriesCountDictionary(foodEntries: list)
        createTableViewUI()
        
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        parentPresenter?.updateStatusBarAppearance()
        
    }
    
    
    //MARK: UI
    func createTableViewUI() {
        tableView = UITableView(frame: CGRect(x: 10, y: 10, width: self.view.frame.width - 20, height: self.view.frame.height - 20))
        tableView?.backgroundColor = .white
        tableView?.addCornerRadius(with: 10)
        tableView?.register(UITableViewCell.self, forCellReuseIdentifier: tableViewCellIdentifier)
        tableView?.delegate = self
        tableView?.dataSource = self
        tableView?.contentInset = UIEdgeInsets(top: 10, left: 0, bottom: 40, right: 0)
        self.view.addSubview(tableView!)
    }
}


//MARK: - Table view Delegate
extension CaloriesAnalyticsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.caloriesList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: tableViewCellIdentifier, for: indexPath)
        
        let entry = self.viewModel.caloriesList[indexPath.row]
        cell.tintColor = .clear
        cell.textLabel?.attributedText =  self.viewModel.getCaloriesText(entry: entry)
        cell.backgroundColor = .white
        cell.accessoryView = self.viewModel.getCaloriesRowImageView(calCount: entry.count)
        
        // removet selection back groudn color
        let backgroundView = UIView()
        backgroundView.backgroundColor = .clear
        cell.selectedBackgroundView = backgroundView
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}
