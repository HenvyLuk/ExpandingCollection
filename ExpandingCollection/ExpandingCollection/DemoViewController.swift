//
//  ViewController.swift
//  ExpandingCollection
//
//  Created by csh on 16/8/5.
//  Copyright © 2016年 csh. All rights reserved.
//

import UIKit

class DemoViewController: ExpandingViewController {

    typealias ItemInfo = (imageName: String, title: String)
    var cellsIsOpen = [Bool]()
    let items: [ItemInfo] = [("item0", "Boston"),("item1", "New York"),("item2", "San Francisco"),("item3", "Washington")]
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        itemSize = CGSize(width: 256, height: 335)

        registerCell()
        fillCellIsOpeenArry()
        addGestureToView(collectionView!)
        configureNavBar()
        
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    func registerCell() {
        let nib = UINib(nibName: String(DemoCollectionViewCell), bundle: nil)
        collectionView?.registerNib(nib, forCellWithReuseIdentifier: String(DemoCollectionViewCell))

    }
    func fillCellIsOpeenArry() {
        for _ in items {
            cellsIsOpen.append(false)
        }
    }
    
    func addGestureToView(toView: UIView) {
        let gesutereUp = Init(UISwipeGestureRecognizer(target: self, action: #selector(DemoViewController.swipeHandler(_:)))) {
            $0.direction = .Up
        }
        
        let gesutereDown = Init(UISwipeGestureRecognizer(target: self, action: #selector(DemoViewController.swipeHandler(_:)))) {
            $0.direction = .Down
        }
        toView.addGestureRecognizer(gesutereUp)
        toView.addGestureRecognizer(gesutereDown)
    }
    
    func swipeHandler(sender: UISwipeGestureRecognizer) {
        print("swipeHandler")
   
    }
    
    private func configureNavBar() {
        navigationItem.leftBarButtonItem?.image = navigationItem.leftBarButtonItem?.image!.imageWithRenderingMode(UIImageRenderingMode.AlwaysOriginal)
    }
    
    override func collectionView(collectionView: UICollectionView, willDisplayCell cell: UICollectionViewCell, forItemAtIndexPath indexPath: NSIndexPath) {
        super.collectionView(collectionView, willDisplayCell: cell, forItemAtIndexPath: indexPath)
        guard let cell = cell as? DemoCollectionViewCell else { return }
        
        let index = indexPath.row % items.count
        let info = items[index]
        cell.backgroundImageView?.image = UIImage(named: info.imageName)
        cell.customTitle.text = info.title
        //cell.cellIsOpen(cellsIsOpen[index], animated: false)
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
 
        guard let cell = collectionView.cellForItemAtIndexPath(indexPath) as? DemoCollectionViewCell where currentIndex == indexPath.row else { return }
        if cell.isOpened == false {
            cell.cellIsOpen(true)
        }else {
        
            print("push")
            
            
            //pushToViewCon(getViewController())
            
//            if let rightButton = navigationItem.rightBarButtonItem as? AnimatingBarButton {
//                rightButton.animationSelected(true)
//            }
        }
        
        
        
        
    }
    
//    private func getViewController() -> ExpandingTableViewController {
//        let storyboard = UIStoryboard(storyboard: .Main)
//        let toViewController: DemoTableViewController = storyboard.instantiateViewController()
//        return toViewController
//    }
    
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        return collectionView.dequeueReusableCellWithReuseIdentifier(String(DemoCollectionViewCell), forIndexPath: indexPath)
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
   
        print("touchesBegan")
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

