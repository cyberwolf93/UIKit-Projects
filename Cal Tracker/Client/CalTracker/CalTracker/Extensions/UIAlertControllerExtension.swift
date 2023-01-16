//
//  UIAlertControllerExtension.swift
//  CalTracker
//
//  Created by Ahmed Mohiy on 25/10/2022.
//

import UIKit

extension UIAlertController {
    
    func createFilterByUser(delegate: UICollectionViewDelegate, dataSource: UICollectionViewDataSource) {
        self.title = "\n\n\n\n\n\n\n"
        let frame = CGRect(x: 10, y: 10, width: self.view.bounds.width-40, height: self.view.bounds.height/4)
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let collectionView = UICollectionView(frame: frame, collectionViewLayout: layout)
        self.view.addSubview(collectionView)
        collectionView.register(FilterbyUserActionSheetCollectionViewCell.self,
                                forCellWithReuseIdentifier: FilterbyUserActionSheetCollectionViewCell.cellIdentifier())
        
        collectionView.tag = UICollectionView.tagEnum.filterByUser.rawValue
        collectionView.backgroundColor = .white
        collectionView.addCornerRadius(with: 5)
        collectionView.showsVerticalScrollIndicator = false
        collectionView.delegate = delegate
        collectionView.dataSource = dataSource
    }
    
    
}

