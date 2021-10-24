//
//  ViewController.swift
//  weather app
//
//  Created by Brian Liew on 10/21/21.
//

import UIKit

class ViewController: UIViewController {
    
    // UIView declaration

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let network = networking()
        
        network.make_request() 
    }

}

