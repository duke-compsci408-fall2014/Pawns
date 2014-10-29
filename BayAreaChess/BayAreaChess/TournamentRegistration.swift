//
//  TournamentRegistration.swift
//  BayAreaChess
//
//  Created by Carlos Reyes on 10/13/14.
//  Copyright (c) 2014 Bay Area Chess. All rights reserved.
//

import UIKit

class TournamentRegistration: UIViewController {
    
    @IBOutlet var firstName : UITextField!;
    @IBOutlet var lastName : UITextField!;
    @IBOutlet var email : UITextField!;
    @IBOutlet var phoneNumber : UITextField!;
    
    
    override func viewDidLoad() {
        super.viewDidLoad();
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning();
        // Dispose of any resources that can be recreated.
    }
    
}