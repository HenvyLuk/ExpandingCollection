//
//  testViewController.swift
//  ExpandingCollection
//
//  Created by henvy on 16/8/8.
//  Copyright © 2016年 csh. All rights reserved.
//

import UIKit

class testViewController: UIViewController {

    @IBOutlet weak var collView: UICollectionView!
    @IBOutlet weak var testView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()

        let view = UIView.init(frame: CGRectMake(0, 0, 100, 100))
        
     
        
        // Do any additional setup after loading the view.
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
