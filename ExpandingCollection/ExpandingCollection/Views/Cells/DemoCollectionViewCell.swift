//
//  DemoCollectionViewCell.swift
//  ExpandingCollection
//
//  Created by henvy on 16/8/8.
//  Copyright © 2016年 csh. All rights reserved.
//

import UIKit

class DemoCollectionViewCell: BasePageCollectionCell {


    @IBOutlet weak var customTitle: UILabel!
    @IBOutlet weak var backgroundImageView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        customTitle.layer.shadowRadius = 2
        customTitle.layer.shadowOffset = CGSize(width: 0, height: 3)
        customTitle.layer.shadowOpacity = 0.2

        
        
        
    }

}
