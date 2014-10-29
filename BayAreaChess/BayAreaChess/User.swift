//
//  User.swift
//  BayAreaChess
//
//  Created by Carlos Reyes on 10/5/14.
//  Copyright (c) 2014 Bay Area Chess. All rights reserved.
//

import UIKit

class User: UIViewController {
    
    @IBOutlet var firstName : UILabel!;
    @IBOutlet var lastName : UILabel!;
    @IBOutlet var email : UILabel!;
    @IBOutlet var username : UILabel!;
    @IBOutlet var dateJoined : UILabel!;

    
    override func viewDidLoad() {
        super.viewDidLoad();
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning();
        // Dispose of any resources that can be recreated.
    }
    
}