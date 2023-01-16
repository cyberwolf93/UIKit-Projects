//
//  SettingsViewController.swift
//  CalTracker
//
//  Created by Ahmed Mohiy on 26/10/2022.
//

import UIKit
import NetworkCore

class SettingsViewController: UIViewController {
    
    @IBOutlet weak var viewParent: UIView!
    @IBOutlet weak var tableView: UITableView!
    
    
    
    //MARK: Variables
    var tableViewCellIdentifier = "CellIdentifier"
    let viewModel = SettingsViewModel( userCoreManager: UserCoreManager(engine: NetworkEngine(),
                                                                        authToken: AppPreferences.shared.getUserToken()))
    
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
        self.parent?.title = String.localizedString(with:"settings")
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
    
    // MARK: - Actions
    func showChangeCaloriesLimitPopup() {
        let alert = UIAlertController(title: String.localizedString(with: "change_calories_limit"), message: "", preferredStyle: .alert)
        alert.addTextField { textField in
            textField.keyboardType = .phonePad
        }
        
        let actionSave = UIAlertAction(title: "Save", style: .default) { _ in
            let textField = alert.textFields![0]
            if let text = textField.text, !text.isEmpty, let calValue = Int(text) {
                self.view.showLoading()
                self.viewModel.changeLimit(With: calValue) { [weak self]  in
                    DispatchQueue.main.async {
                        self?.view.hideLoading()
                        self?.viewModel.prepareTabelViewSection()
                        self?.tableView.reloadData()
                        alert.dismiss(animated: true)
                    }
                }
            }
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        
        alert.addAction(actionSave)
        alert.addAction(cancelAction)
        
        self.present(alert, animated: true)
    }
}


//MARK: - Table view delegate and data source
extension SettingsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.tableViewList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let rowType = self.viewModel.tableViewList[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: self.tableViewCellIdentifier, for: indexPath)
        cell.backgroundColor = .clear
        cell.tintColor = .black
        let backgroundView = UIView()
        backgroundView.backgroundColor = .lightGray1.withAlphaComponent(0.3)
        cell.selectedBackgroundView = backgroundView
        switch(rowType) {
        case .calLimit:
            cell.textLabel?.text = "\(String.localizedString(with: "your_cal_limit"))\(viewModel.getUserLimit()) "
            cell.textLabel?.textColor = .mainTextReversed
            cell.imageView?.image = UIImage(systemName: "timer")
            if let image = UIImage(systemName: "arrow.forward")?.withTintColor(.black, renderingMode: .alwaysOriginal) {
                cell.accessoryView = UIImageView(image: image)
            }
            return cell
        case .report:
            cell.textLabel?.text = String.localizedString(with: "generate_report")
            cell.textLabel?.textColor = .darkRed2
            cell.imageView?.image = UIImage(systemName: "doc.text.below.ecg")
            if let image = UIImage(systemName: "arrow.forward")?.withTintColor(.black, renderingMode: .alwaysOriginal) {
                cell.accessoryView = UIImageView(image: image)
            }
            
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return String.localizedString(with: "settings")
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
        let rowType = self.viewModel.tableViewList[indexPath.row]
        if rowType == .report {
            self.navigationController?.showReportScreen()
        } else if rowType == .calLimit {
            self.showChangeCaloriesLimitPopup()
        }
    }
    
}
