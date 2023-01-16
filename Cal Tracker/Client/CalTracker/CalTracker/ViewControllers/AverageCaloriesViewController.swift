//
//  AverageCaloriesViewController.swift
//  CalTracker
//
//  Created by Ahmed Mohiy on 26/10/2022.
//

import UIKit

class AverageCaloriesViewController: UIViewController {
    
    //MARK: - Views
    var tableView: UITableView?
    
    //MARK: Variables
    let tableViewCellIdentifier = "tableViewCellIdentifier"
    var usersList:[UserEntry] = []
    var totalCalPerUser:[String: Int] = [:]
    weak var parentPresenter: UIViewController?
    var viewModel = AverageCaloriesViewModel()
    
    // MARK: - View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .clear
        self.view.addGradientBackground(with: [UIColor.darkBlue1.cgColor, UIColor.darkBlue2.cgColor])
        self.title = "Average Last 7 Days"
        let textAttributes = [NSAttributedString.Key.foregroundColor:UIColor.black]
        self.navigationController?.navigationBar.titleTextAttributes = textAttributes
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
        self.view.addSubview(tableView!)
    }
    
   
    
}


//MARK: - Table view Delegate
extension AverageCaloriesViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.usersList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: tableViewCellIdentifier, for: indexPath)
        
        let user = self.usersList[indexPath.row]
        cell.tintColor = .clear
        cell.textLabel?.text = "\(user.name.capitalized) - average: \(viewModel.getUserAverage(from: self.totalCalPerUser[user.id]))"
        cell.textLabel?.textColor = .mainTextReversed
        cell.backgroundColor = .white
        cell.imageView?.image = UIImage(systemName: "person.fill")?.withTintColor(.lightGray2, renderingMode: .alwaysOriginal)
        
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
