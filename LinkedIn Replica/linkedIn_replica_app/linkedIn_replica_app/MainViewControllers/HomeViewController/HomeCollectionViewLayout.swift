//
//  HomeCollectionViewLayout.swift
//  linkedIn_replica_app
//
//  Created by Ahmed Mohiy on 08/02/2023.
//

import UIKit

protocol HomeCollectionViewLayoutDelegate: NSObjectProtocol {
    func collectionView(_ collectionView: UICollectionView, heightCellAt indexPath: IndexPath) -> CGFloat
}

class HomeCollectionViewLayout: UICollectionViewLayout {

    weak var delegate: HomeCollectionViewLayoutDelegate?
    private let cellPadding: CGFloat = 5
    private var cachedAttributes: [UICollectionViewLayoutAttributes] = []
    private var contentHeight:CGFloat = 0
    private var contentWidth: CGFloat {
        guard let collectionView = collectionView else {
            return 0
        }
        let insets = collectionView.contentInset
        return collectionView.bounds.width - (insets.left + insets.right)
    }
    
    override var collectionViewContentSize: CGSize {
        return CGSize(width: contentWidth, height: contentHeight)
    }
    
    override func prepare() {
        guard cachedAttributes.isEmpty, let collectionView else {return}
        
        var yOffset: CGFloat = 0
        for item in 0..<collectionView.numberOfItems(inSection: 0) {
            let indexPath = IndexPath(item: item, section: 0)
            
            let cellContentHeight = delegate?.collectionView(collectionView, heightCellAt: indexPath) ?? 100
            let height = cellPadding + cellContentHeight
            let frame = CGRect(x: 0, y: yOffset, width: contentWidth, height: height)
            let insetFrame = frame.insetBy(dx: 0, dy: cellPadding)
            
            let attributes = UICollectionViewLayoutAttributes(forCellWith: indexPath)
            attributes.frame = insetFrame
            cachedAttributes.append(attributes)
            
            contentHeight = max(contentHeight, frame.maxY)
            yOffset += height
        }
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        var visibleLayoutAttributes: [UICollectionViewLayoutAttributes] = []
        for attributes in cachedAttributes {
            if attributes.frame.intersects(rect) {
                visibleLayoutAttributes.append(attributes)
            }
        }
        print(visibleLayoutAttributes)
        return visibleLayoutAttributes
    }
    
    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        return cachedAttributes[indexPath.item]
    }
    
//    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
//        return collectionView?.bounds.height != newBounds.height
//    }
    
    override func invalidateLayout() {
        cachedAttributes = []
        prepare()
        super.invalidateLayout()
    }
}
