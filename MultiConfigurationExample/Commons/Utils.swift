//
//  Utils.swift
//  MultiConfigurationExample
//
//  Created by Petar Glisovic on 5/19/20.
//  Copyright © 2020 Petar Glisovic. All rights reserved.
//

import Foundation

class Utils {
    
    static func infoForKey(_ key: String) -> String? {
        return (Bundle.main.infoDictionary?[key] as? String)?.replacingOccurrences(of: "\\", with: "")
    }
}
