//
//  Login.swift
//  BayAreaChess
//
//  Created by Carlos Reyes on 9/18/14.
//  Copyright (c) 2014 Bay Area Chess. All rights reserved.
//

import UIKit

class Login: UIViewController {
	
    @IBOutlet var username : UITextField!;
    @IBOutlet var password : UITextField!;
    @IBOutlet var label : UILabel!;
	
	override func viewDidLoad() {
        super.viewDidLoad();
		// Do any additional setup after loading the view, typically from a nib.
	}
	
	override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning();
		// Dispose of any resources that can be recreated.
	}

	@IBAction func verifyLogin (sender : AnyObject) {
		if (username.text == "Pawns" && password.text == "Pawns") {
			self.performSegueWithIdentifier("login", sender: sender as UIButton);
		}
		else {
			label.textColor = UIColor.redColor();
			label.text = "Rejected!";
		}
	}
    
}