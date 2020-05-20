//
//  ViewController.swift
//  MultiConfigurationExample
//
//  Created by Petar Glisovic on 5/19/20.
//  Copyright © 2020 Petar Glisovic. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let sampleApiKey = Utils.infoForKey("SAMPLE_API_KEY") ?? ""
        print("Sample api key = \(sampleApiKey)")
    }
}

