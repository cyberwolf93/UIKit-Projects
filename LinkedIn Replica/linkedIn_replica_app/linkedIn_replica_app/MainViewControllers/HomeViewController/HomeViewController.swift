//
//  HomeViewController.swift
//  linkedIn Replica
//
//  Created by Ahmed Mohiy on 17/01/2023.
//

import UIKit

class HomeViewController: UIViewController {
    
    //MARK: Views
    var homeNavigationBarController: HomeNavigationBarController?
    var collectionView: UICollectionView?
    let viewModel: HomeViewControllerViewModel = HomeViewControllerViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.viewModel.delegate = self
        initNavigationBar()
        initCollectionView()
        viewModel.requestFeed()
    }
    
    func initNavigationBar() {
        if let navigationBar = self.navigationController?.navigationBar {
            homeNavigationBarController = HomeNavigationBarController(navigationBar: navigationBar,
                                                                      navigationItem: navigationItem)
            homeNavigationBarController?.delegate = self
        }
    }
    
    func initCollectionView() {
        let layout = HomeCollectionViewLayout()
        layout.delegate = self
//        let layout = UICollectionViewFlowLayout()
//        layout.scrollDirection = .vertical
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView?.showsVerticalScrollIndicator = false
        collectionView?.delegate = self
        collectionView?.dataSource = self
        collectionView?.register(HomeFeedCollectionViewCell.self, forCellWithReuseIdentifier: HomeFeedCollectionViewCell.cellIdentifier())
        
        self.view.addSubview(collectionView!)
        collectionView?.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            collectionView!.topAnchor.constraint(equalTo: self.view.topAnchor),
            collectionView!.rightAnchor.constraint(equalTo: self.view.rightAnchor),
            collectionView!.leftAnchor.constraint(equalTo: self.view.leftAnchor),
            collectionView!.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
        ])
    }
}

//MARK: HomeNavigationBarControllerDelegate
extension HomeViewController: HomeNavigationBarControllerDelegate {
    func searchDidBeginEditing() {
        self.navigateToSearchSuggestionViewController()
    }
}

//MARK: Navigation handler
extension HomeViewController {
    func navigateToSearchSuggestionViewController() {
        guard let viewControlelr = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: HomeSearchViewController.storyboardId) as? HomeSearchViewController else {
            return
        }
        self.navigationController?.pushViewController(viewControlelr, animated: false)
    }
}

//MARK: - CollectionView deleagte and datasorce
extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.postFeed.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeFeedCollectionViewCell.cellIdentifier(), for: indexPath) as! HomeFeedCollectionViewCell
        cell.delegate = self
        cell.indexPath = indexPath
        cell.viewModel = viewModel.cellsViewModels[indexPath]
        return cell
    }
    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        guard let cellViewModel = viewModel.cellsViewModels[indexPath] else {return .zero}
//        return HomeFeedCollectionViewCell.cellSize(parentSize: collectionView.bounds.size, viewModel: cellViewModel)
//    }
}


//MARK: - ViewModel delegate
extension HomeViewController: HomeViewControllerViewModelDelegate {
    func feedDidUpdate() {
        collectionView?.performBatchUpdates({
            let addedItemCount = collectionView?.numberOfItems(inSection: 0)
            if let addedItemCount,  addedItemCount < viewModel.postFeed.count {
                for i in addedItemCount ..< viewModel.postFeed.count  {
                    collectionView?.insertItems(at: [IndexPath(row: i, section: 0)])
                }
            }
        })
    }
}

//MARK: - HomeFeedCollectionViewCellDelegate
extension HomeViewController: HomeFeedCollectionViewCellDelegate {
    func postTextDidExpand(indexPath: IndexPath) {
        if let cellViewModel = viewModel.cellsViewModels[indexPath] {
            cellViewModel.isCellExtended = true
        }
        collectionView?.collectionViewLayout.invalidateLayout()
    }
}

//MARK: -
extension HomeViewController: HomeCollectionViewLayoutDelegate {
    func collectionView(_ collectionView: UICollectionView, heightCellAt indexPath: IndexPath) -> CGFloat {
        guard let cellViewModel = viewModel.cellsViewModels[indexPath] else {return .zero}
        return HomeFeedCollectionViewCell.cellSize(parentSize: collectionView.bounds.size, viewModel: cellViewModel).height
    }
}
