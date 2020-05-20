//
//  CALayer+Extensions.swift
//  MultiConfigurationExample
//
//  Created by Petar Glisovic on 5/19/20.
//  Copyright © 2020 Petar Glisovic. All rights reserved.
//

import UIKit

extension CALayer {
    
    func addBorder(_ edge: UIRectEdge, color: UIColor, thickness: CGFloat) {
        let border = CALayer()
        switch edge {
        case UIRectEdge.top: border.frame = CGRect(x: 0, y: 0, width: self.frame.width, height: thickness)
        case UIRectEdge.bottom: border.frame = CGRect(x: 0, y: self.frame.height - thickness, width: self.frame.width, height: thickness)
        case UIRectEdge.left: border.frame = CGRect(x: 0, y: 0, width: thickness, height: self.frame.height)
        case UIRectEdge.right:
            border.frame = CGRect(x: self.frame.width - thickness, y: 0, width: thickness, height: self.frame.height)
        case UIRectEdge.all:
            self.addBorder(.top, color: color, thickness: thickness)
            self.addBorder(.bottom, color: color, thickness: thickness)
            self.addBorder(.left, color: color, thickness: thickness)
            self.addBorder(.right, color: color, thickness: thickness)
            return
        default: break
        }
        border.backgroundColor = color.cgColor;
        self.addSublayer(border)
    }
}
