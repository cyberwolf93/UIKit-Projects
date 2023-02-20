//
//  MessagesViewController.swift
//  linkedIn Replica
//
//  Created by Ahmed Mohiy on 18/01/2023.
//

import UIKit

class MessagesViewController: UIViewController, DescendantforContainerTransitionController {
    
    //MARK: View
    var tableView: UITableView?
    let gesture = UIPanGestureRecognizer()
    var navigationBar: UINavigationBar = {
       let uiview = UINavigationBar()
        return uiview
    }()
    
    //MARK: Variables
    static let storyboardId: String = "MessagesViewControllerVCID"
    static let navigationControllerStoryboardId = "MessagesViewControllerVCIDNavigationController"
    weak var mainContainerTransitionController: MainContainerTransitionController?
    let viewModel = MessageViewControllerViewModel()
    var navigationBarController: MessageNavigationBarController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .appBackground
        viewModel.delegate = self
        initNavigationBar()
        addViewTransitionPanGesture()
        initializeTableView()
        
        viewModel.loadMessages()
    }
    
    func initNavigationBar() {
        view.addSubview(navigationBar)
        navigationBar.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            navigationBar.topAnchor.constraint(equalTo: self.view.topAnchor),
            navigationBar.rightAnchor.constraint(equalTo: self.view.rightAnchor),
            navigationBar.leftAnchor.constraint(equalTo: self.view.leftAnchor),
            navigationBar.heightAnchor.constraint(equalToConstant: 44)
        ])
        
        let navigationItem = UINavigationItem()
        navigationBar.setItems([navigationItem], animated: false)
        _ = MessageNavigationBarController(navigationBar: navigationBar,
                                                                  navigationItem: navigationItem)
    }
    
    func addViewTransitionPanGesture(){
        if let transitionContainer = self.mainContainerTransitionController {
            gesture.addTarget(transitionContainer, action: #selector(transitionContainer.handlePanGestureRecognizer(_:)))
            self.view.addGestureRecognizer(gesture)
        }
    }
    
    func initializeTableView() {
        tableView = UITableView()
        tableView?.backgroundColor = .appSecondaryBackground
        tableView?.separatorStyle = .none
        tableView?.translatesAutoresizingMaskIntoConstraints = false
        self.view.insertSubview(tableView!, at: 0)
        
        NSLayoutConstraint.activate([
            tableView!.topAnchor.constraint(equalTo: navigationBar.bottomAnchor, constant: 10),
            tableView!.rightAnchor.constraint(equalTo: view.rightAnchor),
            tableView!.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView!.leftAnchor.constraint(equalTo: view.leftAnchor),
        ])
        
        tableView?.delegate = self
        tableView?.dataSource = self
        
        tableView?.register(MessageTableViewCell.cellNib(), forCellReuseIdentifier: MessageTableViewCell.cellIdentifier())
    }
}

//MARK: - Table view delegate and datasource
extension MessagesViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MessageTableViewCell.cellIdentifier(), for: indexPath) as! MessageTableViewCell
        
        let viewModel = MessageTableViewCellViewModel(message: self.viewModel.messages[indexPath.row])
        cell.viewModel = viewModel
        cell.datasource = self
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return MessageTableViewCell.cellHeight()
    }
    
}

//MARK: - ViewModel delegate
extension MessagesViewController: MessageViewControllerViewModelDelegate {
    func messageDidLoad() {
        self.tableView?.reloadData()
    }
}

//MARK: - MessageTableViewCellDatasource
extension MessagesViewController: MessageTableViewCellDatasource {
    func getParentPanGesture() -> UIPanGestureRecognizer {
        return gesture
    }
}

