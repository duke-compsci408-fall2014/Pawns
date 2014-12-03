//
//  About.swift
//  BayAreaChess
//
//  Created by Carlos Reyes on 10/21/14.
//  Copyright (c) 2014 Bay Area Chess. All rights reserved.
//

import UIKit

class About: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad();
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /**
    * Pulls up side bar on event
    */
    @IBAction func onMenu() {
        (tabBarController as TabBarController).sidebar.showInViewController(self, animated: true);
    }
    
}

