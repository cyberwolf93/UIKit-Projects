//
//  MyNetworkViewController.swift
//  linkedIn Replica
//
//  Created by Ahmed Mohiy on 17/01/2023.
//

import UIKit

class MyNetworkViewController: UIViewController {
    
    //MARK: Views
    var homeNavigationBarController: HomeNavigationBarController?
    var collectionView: UICollectionView?
    
    //MARK: Variables
    let viewModel = MyNetworkViewControllerViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .clear
        initNavigationBar()
        initCollectionView()
        viewModel.delegate = self
        viewModel.loadContent()
    }
    
    func initNavigationBar() {
        if let navigationBar = self.navigationController?.navigationBar {
            homeNavigationBarController = HomeNavigationBarController(navigationBar: navigationBar,
                                                                      navigationItem: navigationItem)
            homeNavigationBarController?.delegate = self
        }
    }
    
    func initCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView?.backgroundColor = .appBackground
        collectionView?.translatesAutoresizingMaskIntoConstraints = false
        collectionView?.showsVerticalScrollIndicator = false
        self.view.addSubview(collectionView!)
        NSLayoutConstraint.activate([
            collectionView!.topAnchor.constraint(equalTo: self.view.topAnchor),
            collectionView!.rightAnchor.constraint(equalTo: self.view.rightAnchor),
            collectionView!.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            collectionView!.leftAnchor.constraint(equalTo: self.view.leftAnchor),
        ])
        
        collectionView?.delegate = self
        collectionView?.dataSource = self
        
        collectionView?.register(MyNetworkCellContainer.self, forCellWithReuseIdentifier: MyNetworkCellContainer.cellIdentifier())
        collectionView?.register(MyNetworkHeaderReusableView.cellNib(), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: MyNetworkHeaderReusableView.cellIdentifier())
        collectionView?.register(MyNetworkFooterReusableView.cellNib(), forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: MyNetworkFooterReusableView.cellIdentifier())
    }
}

//MARK: HomeNavigationBarControllerDelegate
extension MyNetworkViewController: HomeNavigationBarControllerDelegate {
    func searchDidBeginEditing() {
        self.navigateToSearchSuggestionViewController()
    }
    
    func searchDidEndEditing() {
        
    }
}

//MARK: Navigation handler
extension MyNetworkViewController {
    func navigateToSearchSuggestionViewController() {
        guard let viewControlelr = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: HomeSearchViewController.storyboardId) as? HomeSearchViewController else {
            return
        }
        self.navigationController?.pushViewController(viewControlelr, animated: false)
    }
}


//MARK: - Collection view delegate and datasource
extension MyNetworkViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return viewModel.sections.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numberOfItemsIn(section: section)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MyNetworkCellContainer.cellIdentifier(), for: indexPath) as! MyNetworkCellContainer
        let cellData = viewModel.getCellContentFor(section: indexPath.section, row: indexPath.row)
        cell.viewModel = MyNetworkCellContainerViewModel(persons: cellData)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionHeader {
            let cell = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: MyNetworkHeaderReusableView.cellIdentifier(), for: indexPath) as! MyNetworkHeaderReusableView
            cell.configureCell(title: viewModel.getSectionTitle(section: indexPath.section))
            return cell
        } else {
            let cell = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: MyNetworkFooterReusableView.cellIdentifier(), for: indexPath) as! MyNetworkFooterReusableView
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: MyNetworkCellContainer.cellHeight())
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: MyNetworkHeaderReusableView.cellHeight())
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        if section == viewModel.sections.count - 1 {
            return .zero
        }
        return CGSize(width: collectionView.frame.width, height: MyNetworkFooterReusableView.cellHeight())
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
}


// MARK: MyNetworkViewControllerViewModelDelegate
extension MyNetworkViewController: MyNetworkViewControllerViewModelDelegate {
    func collectionDataDidLoad() {
        collectionView?.reloadData()
    }
}
