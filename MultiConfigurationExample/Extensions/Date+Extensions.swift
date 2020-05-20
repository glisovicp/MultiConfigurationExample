//
//  Date+Extensions.swift
//  MultiConfigurationExample
//
//  Created by Petar Glisovic on 5/19/20.
//  Copyright © 2020 Petar Glisovic. All rights reserved.
//

import Foundation

extension Date {
    func daysBetweenDate(toDate: Date) -> Int {
        let components = Calendar.current.dateComponents([.day], from: self, to: toDate)
        return components.day ?? 0
    }
}
