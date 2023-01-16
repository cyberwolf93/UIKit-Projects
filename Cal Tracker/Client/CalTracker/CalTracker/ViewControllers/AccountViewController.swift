//
//  AccountViewController.swift
//  CalTracker
//
//  Created by Ahmed Mohiy on 25/10/2022.
//

import UIKit

class AccountViewController: UIViewController {
    
    //MARK: - Outlets
    @IBOutlet weak var viewParent: UIView!
    @IBOutlet weak var tableView: UITableView!
    
    //MARK: Variables
    var tableViewCellIdentifier = "CellIdentifier"
    let viewModel = AccountViewModel()
    
    //MARK: - View lifecycel
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //view parent
        self.viewParent.backgroundColor = .clear
        self.view.backgroundColor = .white
        self.viewParent.addGradientBackground(with: [UIColor.darkBlue1.cgColor, UIColor.darkBlue2.cgColor])
        self.viewModel.prepareTabelViewSection()
        configureTableView()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.parent?.title = String.localizedString(with:"account")
        // Hide add button
        self.parent?.navigationItem.rightBarButtonItem?.tintColor = .clear
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .darkContent
    }
    
    // MARK: - UI
    func configureTableView() {
        tableView.backgroundColor = .white
        tableView.addCornerRadius(with: 5)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: self.tableViewCellIdentifier)
        tableView.delegate = self
        tableView.dataSource = self
    }
}


//MARK: - Table view delegate and data source
extension AccountViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        self.viewModel.tableViewSections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.viewModel.tableViewSections[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let rowType = self.viewModel.tableViewSections[indexPath.section][indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: self.tableViewCellIdentifier, for: indexPath)
        cell.backgroundColor = .clear
        cell.tintColor = .black
        let backgroundView = UIView()
        backgroundView.backgroundColor = .lightGray1.withAlphaComponent(0.3)
        cell.selectedBackgroundView = backgroundView
        switch(rowType) {
        case .name:
            cell.textLabel?.text = self.viewModel.getUserName()
            cell.textLabel?.textColor = .mainTextReversed
            cell.imageView?.image = UIImage(systemName: "person")
            return cell
        case .email:
            cell.textLabel?.text = self.viewModel.getUserEmail()
            cell.textLabel?.textColor = .mainTextReversed
            cell.imageView?.image = UIImage(systemName: "envelope")
            return cell
            
        case .signout:
            cell.textLabel?.text = String.localizedString(with: "signout")
            cell.textLabel?.textColor = .darkRed2
            cell.imageView?.image = UIImage(systemName: "square.and.arrow.up")
            if let image = UIImage(systemName: "arrow.forward")?.withTintColor(.black, renderingMode: .alwaysOriginal) {
                cell.accessoryView = UIImageView(image: image)
            }
            
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return self.viewModel.getSectionTitle(type: AccountViewModel.Section(rawValue: section) ?? .profileInformation)
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        if let header = view as? UITableViewHeaderFooterView {
            header.textLabel?.textColor = .black
            header.textLabel?.font = UIFont.systemFont(ofSize: 20)
            header.frame = CGRect(x: 0,
                                  y: 0,
                                  width: tableView.frame.width,
                                  height: header.frame.height)
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let rowType = self.viewModel.tableViewSections[indexPath.section][indexPath.row]
        if rowType == .signout {
            self.view.showLoading()
            self.viewModel.signout()
            self.navigationController?.showSigninScreen()
        }
    }
    
}
