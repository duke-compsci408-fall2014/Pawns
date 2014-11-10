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
        
        firstName.attributedPlaceholder = NSAttributedString(string:"First Name",
            attributes:[NSForegroundColorAttributeName: UIColor.lightTextColor()]);
        lastName.attributedPlaceholder = NSAttributedString(string:"Last Name",
            attributes:[NSForegroundColorAttributeName: UIColor.lightTextColor()]);
        email.attributedPlaceholder = NSAttributedString(string:"Email",
            attributes:[NSForegroundColorAttributeName: UIColor.lightTextColor()]);
        phoneNumber.attributedPlaceholder = NSAttributedString(string:"Phone",
            attributes:[NSForegroundColorAttributeName: UIColor.lightTextColor()]);
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning();
    }
    
    @IBAction func back() {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
}