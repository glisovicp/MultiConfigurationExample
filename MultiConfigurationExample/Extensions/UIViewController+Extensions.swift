//
//  UIViewController+Extensions.swift
//  MultiConfigurationExample
//
//  Created by Petar Glisovic on 5/19/20.
//  Copyright © 2020 Petar Glisovic. All rights reserved.
//

import Foundation
import UIKit


extension UIViewController {
    
    class var storyboardId : String {
        return "\(self)"
    }
    
    // MARK: Alerts

    func showOKAlert(title : String? = nil, message: String? = nil) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        
        // TODO add OK string in Localizable.strings
        let title = NSLocalizedString("popup.button.ok", value: "OK", comment: "OK")
        
        let okAction = UIAlertAction(title: title, style: UIAlertAction.Style.default) {
            (result : UIAlertAction) -> Void in
            print("OK")
        }
        
        alertController.addAction(okAction)
        
        present(alertController, animated: true, completion: nil)
    }

    

    // MARK: - Top scroll
    func scrollToTop(_ scrollView : UIScrollView? = nil) {
        let sv: UIScrollView?
        
        if let scrlView = scrollView {
            sv = scrlView
        } else {
            sv = findScrollView(self.view)
        }
        
        if let scrollView = sv {
            scrollView.setContentOffset(CGPoint(x: scrollView.contentOffset.x, y: 0), animated: true)
        }
        
    }
    
    func findScrollView(_ view: UIView) -> UIScrollView? {
        for subview in view.subviews {
            if let scrlViewSubView = subview as? UIScrollView {
                return scrlViewSubView
            } else {
                if let scrollView = findScrollView(subview) {
                    return scrollView
                }
            }
        }
        return nil
    }
    
    // MARK: Screen navigation
    
    // identifier should be storyboardId property
    func pushScreen(withIdentifier identifier: String, fromStoryboard sb: String? = nil) {
        var newStoryboard = storyboard
        if let storyboardName = sb {
            newStoryboard = UIStoryboard(name: storyboardName, bundle: nil)
        }
        if let viewController = newStoryboard?.instantiateViewController(withIdentifier: identifier) {
            self.navigationController?.pushViewController(viewController, animated: true)
        }
    }
    
    // identifier should be storyboardId property
    func presentScreen(withIdentifier identifier: String, fromStoryboard sb: String? = nil) {
        var newStoryboard = storyboard
        if let storyboardName = sb {
            newStoryboard = UIStoryboard(name: storyboardName, bundle: nil)
        }
        if let viewController = newStoryboard?.instantiateViewController(withIdentifier: identifier) {
            self.present(viewController, animated: true, completion: nil)
        }
    }
    
    func goBack() {
        let _ = self.navigationController?.popViewController(animated: true)
    }
}
