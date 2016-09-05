//
//  BasePageCollectionCell.swift
//  ExpandingCollection
//
//  Created by henvy on 16/8/8.
//  Copyright © 2016年 csh. All rights reserved.
//

import UIKit

public class BasePageCollectionCell: UICollectionViewCell {
    
    struct Constants {
        static let backContainer = "backContainerViewKey"
        static let shadowView      = "shadowViewKey"
        static let frontContainer  = "frontContainerKey"
        
        static let backContainerY  = "backContainerYKey"
        static let frontContainerY = "frontContainerYKey"
    }
    
    
    @IBOutlet weak var backConstraintY: NSLayoutConstraint!
    @IBOutlet weak var frontConstraintY: NSLayoutConstraint!

    @IBOutlet weak var backContainerView: UIView!
    @IBOutlet weak var frontContainerView: UIView!
    public var isOpened = false
    var yOffset: CGFloat = 40
    var shadowView: UIView?

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        //commonInit()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        //configureOutletFromDecoder(aDecoder)
    }
    
    public override func awakeFromNib() {
        super.awakeFromNib()
        
        commonInit()
    }
    
    private func commonInit() {
        configurationViews()
        //shadowView = createShadowViewOnView(frontContainerView)
    }
    
    private func configurationViews() {
        backContainerView.layer.masksToBounds = true
        backContainerView.layer.cornerRadius  = 5
        
        frontContainerView.layer.masksToBounds = true
        frontContainerView.layer.cornerRadius  = 5
        
        contentView.layer.masksToBounds = false
        layer.masksToBounds             = false
    }
    
    func createShadowViewOnView(view: UIView?) -> UIView? {
        guard let view = view else {return nil}
        
        let shadow = Init(UIView(frame: .zero)) {
            $0.backgroundColor                           = .clearColor()
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.layer.masksToBounds                       = false;
            $0.layer.shadowColor                         = UIColor.blackColor().CGColor
            $0.layer.shadowRadius                        = 10
            $0.layer.shadowOpacity                       = 0.3
            $0.layer.shadowOffset                        = CGSize(width: 0, height:0)
        }
        contentView.insertSubview(shadow, belowSubview: view)
        
        // create constraints
        for info: (attribute: NSLayoutAttribute, scale: CGFloat)  in [(NSLayoutAttribute.Width, 0.8), (NSLayoutAttribute.Height, 0.9)] {
            if let frontViewConstraint = view.getConstraint(info.attribute) {
                shadow >>>- {
                    $0.attribute = info.attribute
                    $0.constant  = frontViewConstraint.constant * info.scale
                }
            }
        }
        
        for info: (attribute: NSLayoutAttribute, offset: CGFloat)  in [(NSLayoutAttribute.CenterX, 0), (NSLayoutAttribute.CenterY, 30)] {
            (contentView, shadow, view) >>>- {
                $0.attribute = info.attribute
                $0.constant  = info.offset
            }
        }
        
        // size shadow
        let width  = shadow.getConstraint(.Width)?.constant
        let height = shadow.getConstraint(.Height)?.constant
        
        shadow.layer.shadowPath = UIBezierPath(roundedRect: CGRect(x: 0, y: 0, width: width!, height: height!), cornerRadius: 0).CGPath
        
        return shadow
    }

    
    func cellIsOpen(isOpen: Bool, animated: Bool = true) {
        if isOpen == isOpened { return }
        frontConstraintY.constant = isOpen == true ? -frontContainerView.bounds.size.height / 5 : 0
        backConstraintY.constant  = isOpen == true ? frontContainerView.bounds.size.height / 5 - 20 : 0


        print(frontConstraintY.constant)
        print(backConstraintY.constant)
        
        
        if let widthConstant = backContainerView.getConstraint(.Width) {
            widthConstant.constant = isOpen == true ? frontContainerView.bounds.size.width + yOffset : frontContainerView.bounds.size.width
        }
        
//        if let heightConstant = backContainerView.getConstraint(.Height) {
//            heightConstant.constant = isOpen == true ? backContainerView.bounds.size.height + yOffset : frontContainerView.bounds.size.height
//        }
        
        //configurationCell()
        
        
        if animated == true {
            UIView.animateWithDuration(0.3, delay: 0, options: .CurveEaseInOut, animations: {
                self.contentView.layoutIfNeeded()
                }, completion: nil)
        } else {
            self.contentView.layoutIfNeeded()
        }
        
        isOpened = isOpen
    }
    
    func configurationCell() {
        // Prevents indefinite growing of the cell issue
        let i: CGFloat = self.isOpened ? 1 : -1
        let superHeight = superview?.frame.size.height ?? 0

        frame.size.height += i * superHeight
        frame.origin.y -= i * superHeight / 2
        frame.origin.x -= i * yOffset / 2
        frame.size.width += i * yOffset
    }
    
    func copyCell() -> BasePageCollectionCell? {
        //highlightedImageFalseOnView(contentView)
        
        let data = NSKeyedArchiver.archivedDataWithRootObject(self)
        guard case let copyView as BasePageCollectionCell = NSKeyedUnarchiver.unarchiveObjectWithData(data),
            let shadowView = self.shadowView else {
                return nil
        }
        
        // configure
        copyView.backContainerView.layer.masksToBounds  = backContainerView.layer.masksToBounds
        copyView.backContainerView.layer.cornerRadius   = backContainerView.layer.cornerRadius
        
        copyView.frontContainerView.layer.masksToBounds = frontContainerView.layer.masksToBounds
        copyView.frontContainerView.layer.cornerRadius  = frontContainerView.layer.cornerRadius
        
        // copy shadow layer
        copyShadowFromView(copyView.shadowView!, toView: shadowView)
        
        for index in 0..<copyView.frontContainerView.subviews.count {
            copyShadowFromView(copyView.frontContainerView.subviews[index], toView: frontContainerView.subviews[index])
        }
        return copyView
    }
    
    private func copyShadowFromView(fromView: UIView, toView: UIView) {
        fromView.layer.shadowPath    = toView.layer.shadowPath
        fromView.layer.masksToBounds = toView.layer.masksToBounds
        fromView.layer.shadowColor   = toView.layer.shadowColor
        fromView.layer.shadowRadius  = toView.layer.shadowRadius
        fromView.layer.shadowOpacity = toView.layer.shadowOpacity
        fromView.layer.shadowOffset  = toView.layer.shadowOffset
    }
    
//    func configureOutletFromDecoder(coder: NSCoder) {
//        if case let shadowView as UIView = coder.decodeObjectForKey(Constants.shadowView) {
//            self.shadowView = shadowView
//        }
//        
//        if case let backView as UIView = coder.decodeObjectForKey(Constants.backContainer) {
//            backContainerView = backView
//        }
//        
//        if case let frontView as UIView = coder.decodeObjectForKey(Constants.frontContainer) {
//            frontContainerView = frontView
//        }
//        
//        if case let constraint as NSLayoutConstraint = coder.decodeObjectForKey(Constants.frontContainerY) {
//            frontConstraintY = constraint
//        }
//        
//        if case let constraint as NSLayoutConstraint = coder.decodeObjectForKey(Constants.backContainerY) {
//            backConstraintY = constraint
//        }
//    }
    
}


