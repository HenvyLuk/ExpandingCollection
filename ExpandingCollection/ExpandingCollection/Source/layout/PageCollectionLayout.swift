//
//  PageCollectionLayout.swift
//  ExpandingCollection
//
//  Created by henvy on 16/8/8.
//  Copyright © 2016年 csh. All rights reserved.
//

import UIKit

class PageCollectionLayout: UICollectionViewFlowLayout {

    init(itemSize: CGSize) {
        super.init()
        commonInit(itemSize)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func commonInit(itemSize: CGSize) {
        scrollDirection    = .Horizontal
        minimumLineSpacing = 25
        self.itemSize      = itemSize
    }
    
 
    override func invalidateLayoutWithContext(context: UICollectionViewLayoutInvalidationContext) {
        super.invalidateLayoutWithContext(context)
        guard let collectionView = self.collectionView else { return }
        self.configureInset()

        
    }
    
    func configureInset() -> Void {
        guard let collectionView = self.collectionView else {
            return
        }
        
        let inset = collectionView.bounds.size.width / 2 - itemSize.width / 2
        collectionView.contentInset  = UIEdgeInsetsMake(0, inset, 0, inset)
        collectionView.contentOffset = CGPointMake(-inset, 0)
    }
    
}
