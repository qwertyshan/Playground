//
//  ViewController.swift
//  navigationApp
//
//  Created by Shantanu Rao on 1/1/16.
//  Copyright © 2016 Shantanu Rao. All rights reserved.
//

import Foundation
import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem (
            title: "Start Over",
            style: UIBarButtonItemStyle.Plain,
            target: self,
            action: "startOver")
    }
    
    func startOver() {
        
        if let navigationController = self.navigationController {
            navigationController.popToRootViewControllerAnimated(true)
        }
    }
    
    deinit {
        print("view controller deallocated")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

