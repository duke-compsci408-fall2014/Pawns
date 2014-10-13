//
//  Registration.swift
//  BayAreaChess
//
//  Created by Carlos Reyes on 9/18/14.
//  Copyright (c) 2014 Bay Area Chess. All rights reserved.
//

import UIKit

class UserRegistration: UIViewController {
	@IBOutlet var firstName : UITextField!
	@IBOutlet var lastName : UITextField!
	@IBOutlet var password : UITextField!
	@IBOutlet var confirmedPassword : UITextField!
	@IBOutlet var email : UITextField!
	
    override func viewDidLoad() {
        super.viewDidLoad();        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning();
    }
    
	func verifyData () -> Bool{
        if (password != confirmedPassword) {
            return false;
        }
        if (firstName == nil) {
            return false;
        }
        if (lastName == nil) {
            return false;
        }
        if (email == nil) {
            return false;
        }
		return true;
	}
	
	@IBAction func sendRegistrationRequest () {
        verifyData();
		// 2. API POST, hashes, salts and inputs the info
		// 3. This is called on the Register button click
        
	}
}
