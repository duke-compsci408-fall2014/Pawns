//
//  AboutRight.swift
//  BayAreaChess
//
//  Created by Carlos Reyes on 11/8/14.
//  Copyright (c) 2014 Bay Area Chess. All rights reserved.
//

import UIKit

class AboutRight : UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad();
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning();
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func back() {
        dismissViewControllerAnimated(true, completion: nil)
    }
}
