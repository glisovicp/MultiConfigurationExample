//
//  UITableView+Extensions.swift
//  MultiConfigurationExample
//
//  Created by Petar Glisovic on 5/19/20.
//  Copyright © 2020 Petar Glisovic. All rights reserved.
//

import Foundation
import UIKit

// MRAK: TableView
extension UITableView {
    
    func addTableHeaderViewFromNibWithName(_ name: String) -> UIView {
        let headerView: UIView = Bundle.main.loadNibNamed(name, owner: self, options: nil)?.first as! UIView
        let headerFrame = CGRect(x: 0, y: 0, width: headerView.frame.size.width, height: headerView.frame.size.height)
        let parentView = UIView(frame: headerFrame)
        parentView.addSubview(headerView)
        self.tableHeaderView = parentView
        return headerView
    }
    
    func addTableFooterViewFromNibWithName(_ name: String) -> UIView {
        let footerView: UIView = Bundle.main.loadNibNamed(name, owner: self, options: nil)?.first as! UIView
        let footerFrame = CGRect(x: 0, y: 0, width: footerView.frame.size.width, height: footerView.frame.size.height)
        let parentView = UIView(frame: footerFrame)
        parentView.addSubview(footerView)
        self.tableFooterView = parentView
        return footerView
    }
    
    /// Check if cell at the specific section and row is visible
    /// - Parameters:
    /// - section: an Int reprenseting a UITableView section
    /// - row: and Int representing a UITableView row
    /// - Returns: True if cell at section and row is visible, False otherwise
    func isCellVisible(section:Int, row: Int) -> Bool {
        guard let indexes = self.indexPathsForVisibleRows else {
            return false
        }
        return indexes.contains {$0.section == section && $0.row == row }
    }
    
}

// MRAK: Cell
extension UITableViewCell {
    
    class var identifier : String {
        return "\(self)"
    }
}
