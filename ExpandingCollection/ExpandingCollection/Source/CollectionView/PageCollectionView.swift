//
//  PageCollectionView.swift
//  ExpandingCollection
//
//  Created by henvy on 16/8/8.
//  Copyright © 2016年 csh. All rights reserved.
//

import UIKit

class PageCollectionView: UICollectionView {


}

extension PageCollectionView {

  class func createOnView(view: UIView,
                      layout: UICollectionViewLayout,
                      height: CGFloat,
                      dataSource: UICollectionViewDataSource,
                      delegate: UICollectionViewDelegate) -> PageCollectionView {
        
        let collectionView = Init(PageCollectionView(frame: CGRect.zero, collectionViewLayout: layout)) {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.decelerationRate                          = UIScrollViewDecelerationRateFast
            $0.showsHorizontalScrollIndicator            = false
            $0.dataSource                                = dataSource
            $0.delegate                                  = delegate
            $0.backgroundColor                           = .clearColor()
        }
        view.addSubview(collectionView)

        // add constraints
        collectionView >>>- {
            $0.attribute = .Height
            $0.constant  = height
        }
        [NSLayoutAttribute.Left, .Right, .CenterY].forEach { attribute in
            (view, collectionView) >>>- {
                $0.attribute = attribute
            }
        }
    
        return collectionView
    
        
    }
}
 