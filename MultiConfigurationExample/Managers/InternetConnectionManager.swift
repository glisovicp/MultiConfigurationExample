//
//  InternetConnectionManager.swift
//  MultiConfigurationExample
//
//  Created by Petar Glisovic on 5/19/20.
//  Copyright © 2020 Petar Glisovic. All rights reserved.
//

import UIKit
import Reachability

class InternetConnectionManager: NSObject {

    static let shared = InternetConnectionManager()
    
    fileprivate override init() {}
    
    var reachability : Reachability = try! Reachability()
    
    var isObserved = false
    
    func observeInternetConnection () {
        
        if(!isObserved) {
            reachability.whenReachable = { reachability in
                // this is called on a background thread, but UI updates must
                // be on the main thread, like this:
                
                DispatchQueue.main.async {
                    if reachability.connection == .wifi {
                        print("Reachable via WiFi")
                    } else {
                        print("Reachable via Cellular")
                    }
                    // TODO Add NOTIFICATION_INTERNET_CONNECTION_AVAILABLE constant
                    // NotificationCenter.default.post(name: NSNotification.Name(rawValue: NOTIFICATION_INTERNET_CONNECTION_AVAILABLE), object: nil)
                }
            }
            reachability.whenUnreachable = { reachability in
                // this is called on a background thread, but UI updates must
                // be on the main thread, like this:
                DispatchQueue.main.async {
                    print("Not reachable")
                    // TODO Add NOTIFICATION_INTERNET_CONNECTION_NOT_AVAILABLE constant
                    // NotificationCenter.default.post(name: NSNotification.Name(rawValue: NOTIFICATION_INTERNET_CONNECTION_NOT_AVAILABLE), object: nil)
                }
            }
            
            do {
                try reachability.startNotifier()
                isObserved = true
            } catch {
                print("Unable to start notifier")
            }
        }
    }
    
    func isThereInternetConnection() -> Bool {
        let remoteHostStatus = reachability.connection
        return remoteHostStatus != .none
    }
}
