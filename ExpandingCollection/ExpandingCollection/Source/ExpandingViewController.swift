//
//  ExpandingViewController.swift
//  ExpandingCollection
//
//  Created by henvy on 16/8/7.
//  Copyright © 2016年 csh. All rights reserved.
//

import UIKit

class ExpandingViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {

    var itemSize = CGSize(width: 256, height: 335)
    var collectionView: UICollectionView?
    
    private var transitionDriver: TransitionDriver?

    
    
    var currentIndex: Int {
        guard let collectionView = self.collectionView else { return 0 }
        let startOffset = (collectionView.bounds.size.width - itemSize.width) / 2
        guard let collectionLayout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout else {return 0}
        
        let minimumLineSpacing = collectionLayout.minimumLineSpacing
        return Int((collectionView.contentOffset.x + startOffset + itemSize.width / 2) / (itemSize.width + minimumLineSpacing))

        
    }
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        commonInit()

        // Do any additional setup after loading the view.
    }
    
  private func commonInit() {
        let layout = PageCollectionLayout(itemSize: itemSize)
    
    collectionView = PageCollectionView.createOnView(view,
                                                     layout: layout,
                                                     height: itemSize.height + itemSize.height / 5 * 2,
                                                     dataSource: self,
                                                     delegate: self)
    
    
    }
    
     func collectionView(collectionView: UICollectionView, willDisplayCell cell: UICollectionViewCell, forItemAtIndexPath indexPath: NSIndexPath) {
//        guard case let cell as BasePageCollectionCell = cell else {
//            return
//        }
        
        //cell.configureCellViewConstraintsWithSize(itemSize)
        print("willDisplayCell")
    }
    
    func pushToViewCon(viewCon: ExpandingTableViewController) {
        
        guard let collectionView = self.collectionView, let navigationController = self.navigationController else {
            return
        }
        viewCon.transitionDriver = transitionDriver
        let insets = viewCon.automaticallyAdjustsScrollViewInsets
        let tabBarHeight =  insets == true ? navigationController.navigationBar.frame.size.height : 0
        let stausBarHeight = insets == true ? UIApplication.sharedApplication().statusBarFrame.size.height : 0
        let backImage = getBackImage(viewCon, headerHeight: viewCon.headerHeight)

        transitionDriver?.pushTransitionAnimationIndex(currentIndex,
                                                       collecitionView: collectionView,
                                                       backImage: backImage,
                                                       headerHeight: viewCon.headerHeight,
                                                       insets: tabBarHeight + stausBarHeight) { headerView in
                                                        
        viewCon.tableView.tableHeaderView = headerView
        self.navigationController?.pushViewController(viewCon, animated: false)
                                                        
        }
        
    }
    
    
    private func getBackImage(viewController: UIViewController, headerHeight: CGFloat) -> UIImage? {
        let imageSize = CGSize(width: viewController.view.bounds.width, height: viewController.view.bounds.height - headerHeight)
        let imageFrame = CGRect(origin: CGPoint(x: 0, y: 0), size: imageSize)
        return viewController.view.takeSnapshot(imageFrame)
    }
    
    
     func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        fatalError("need emplementation in subclass")
    }
    
     func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        fatalError("need emplementation in subclass")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
