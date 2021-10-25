//
//  ViewController.swift
//  weather app
//
//  Created by Brian Liew on 10/21/21.
//

import UIKit

class ViewController: UIViewController {
    
    var ret: [String: AnyObject] = [:]
    
    // UIView declaration

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let network_instance = networking()
        
        network_instance.make_request(completion_handler: request_completion_handler)
        
        print("test: \(ret)")
        
    }

    // completion handler for make_request([String: AnyObject] -> Void)
    func request_completion_handler(input: [String: AnyObject]) -> [String: AnyObject] {
        ret = input
        return ret
    }
    

    
}

