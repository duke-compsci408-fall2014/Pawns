//
//  Registration.swift
//  BayAreaChess
//
//  Created by Carlos Reyes on 9/18/14.
//  Copyright (c) 2014 Bay Area Chess. All rights reserved.
//

import UIKit

class Registration: UIViewController {
	@IBOutlet var firstName : UITextField!
	@IBOutlet var lastName : UITextField!
	@IBOutlet var username : UITextField!
	@IBOutlet var password : UITextField!
	@IBOutlet var confirmedPassword : UITextField!
	@IBOutlet var email : UITextField!
	
	func verifyData () -> Bool{
		// Makes API call to verify username/email
		// Verifies password and confirmedPassword locally
		// Return false if something fails
		return true;
	}
	
	@IBAction func sendRegistrationRequest () {
		// 1. Call verify data
		// 2. Hash and salt password with bcrypt algorithm
		// 3. API POST, which updates database
		// 4. This is called on the Register button click
	}
}
