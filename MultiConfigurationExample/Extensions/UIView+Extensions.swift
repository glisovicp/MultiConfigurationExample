//
//  UIView+Extensions.swift
//  MultiConfigurationExample
//
//  Created by Petar Glisovic on 5/19/20.
//  Copyright © 2020 Petar Glisovic. All rights reserved.
//

import UIKit

public extension UIView {
    
    // MARK: Loading view from xib
    
    public func xibSetup(_ nibNameOrNil: String? = nil) -> UIView {
        let view : UIView = loadViewFromNib(nibNameOrNil)

        // use bounds not frame or it'll be offset
        view.frame = bounds
        
        // Make the view stretch with containing view
        view.autoresizingMask = [UIView.AutoresizingMask.flexibleWidth, UIView.AutoresizingMask.flexibleHeight]
        // Adding custom subview on top of our view (over any custom drawing > see note below)
        addSubview(view)
        return view
    }
    
    func loadViewFromNib(_ nibNameOrNil: String?) -> UIView {
        
        let name: String
        if let nibName = nibNameOrNil {
            name = nibName
        } else {
            // Most nibs are demangled by practice, if not, just declare string explicitly
            name = nibName()
        }
        
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: name, bundle: bundle)
        let view = nib.instantiate(withOwner: self, options: nil)[0] as! UIView
        
        return view
    }
    
    
    public func nibName() -> String {
        let name = "\(type(of: self))".components(separatedBy: ".").last ?? ""
        return name
    }
    
    
    func roundView(corner: UIRectCorner = .allCorners) {
        let maskPAth1 = UIBezierPath(roundedRect: self.bounds,
                                     byRoundingCorners: corner,
                                     cornerRadii:CGSize(width: 6, height: 6))
        let maskLayer1 = CAShapeLayer()
        maskLayer1.frame = self.bounds
        maskLayer1.path = maskPAth1.cgPath
        self.layer.mask = maskLayer1
    }
}

// MARK: Constraints
extension UIView {
    /**
     Adds a subview and sets the constraints to fill it's parent view.
     - parameter subview: the view to add.
     */
    func addFillingSubview(_ subview : UIView) {
        subview.translatesAutoresizingMaskIntoConstraints = false
        addSubview(subview)
        addFillingConstraintsForSubview(subview)
    }
    
    func addFillingConstraintsForSubview(_ subview: UIView) {
        subview.translatesAutoresizingMaskIntoConstraints = false
        addConstraint(NSLayoutConstraint(item: subview, attribute: .left,
                                         relatedBy: .equal, toItem: self, attribute: .left, multiplier: 1, constant: 0))
        addConstraint(NSLayoutConstraint(item: subview, attribute: .right,
                                         relatedBy: .equal, toItem: self, attribute: .right, multiplier: 1, constant: 0))
        addConstraint(NSLayoutConstraint(item: subview, attribute: .top,
                                         relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1, constant: 0))
        addConstraint(NSLayoutConstraint(item: subview, attribute: .bottom,
                                         relatedBy: .equal, toItem: self, attribute: .bottom, multiplier: 1, constant: 0))
    }
    
    func addCenteredSubview(_ subview : UIView) {
        subview.translatesAutoresizingMaskIntoConstraints = false
        addSubview(subview)
        addConstraint(NSLayoutConstraint(item: subview, attribute: .centerX,
                                         relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1, constant: 0))
        addConstraint(NSLayoutConstraint(item: subview, attribute: .centerY,
                                         relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0))
    }
    
    func clearConstraints() {
        for subview in self.subviews {
            subview.clearConstraints()
        }
        self.removeConstraints(self.constraints)
    }
    
    func clearConstrainsfor (attribute:NSLayoutConstraint.Attribute){
        let constraintsToClear = self.constraints.filter{$0.firstAttribute == attribute}
        self.removeConstraints(constraintsToClear)
    }
    
}
