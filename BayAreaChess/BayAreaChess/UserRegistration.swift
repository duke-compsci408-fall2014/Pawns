//
//  Registration.swift
//  BayAreaChess
//
//  Created by Carlos Reyes on 9/18/14.
//  Copyright (c) 2014 Bay Area Chess. All rights reserved.
//

import UIKit

import UIKit

class UserRegistration : UIViewController {
    
    @IBOutlet var first_name : UITextField!;
    @IBOutlet var last_name : UITextField!;
    @IBOutlet var email : UITextField!;
    @IBOutlet var username : UITextField!;
    @IBOutlet var password : UITextField!;
    @IBOutlet var confirm_password : UITextField!;
    
    let AMP : String = "&";
    
    
    override func viewDidLoad() {
        super.viewDidLoad();
        
        first_name.attributedPlaceholder = NSAttributedString(string:"First Name",
            attributes:[NSForegroundColorAttributeName: UIColor.lightTextColor()]);
        last_name.attributedPlaceholder = NSAttributedString(string:"Last Name",
            attributes:[NSForegroundColorAttributeName: UIColor.lightTextColor()]);
        email.attributedPlaceholder = NSAttributedString(string:"Email",
            attributes:[NSForegroundColorAttributeName: UIColor.lightTextColor()]);
        username.attributedPlaceholder = NSAttributedString(string:"Username",
            attributes:[NSForegroundColorAttributeName: UIColor.lightTextColor()]);
        password.attributedPlaceholder = NSAttributedString(string:"Password",
            attributes:[NSForegroundColorAttributeName: UIColor.lightTextColor()]);
        confirm_password.attributedPlaceholder = NSAttributedString(string:"Confirm Password",
            attributes:[NSForegroundColorAttributeName: UIColor.lightTextColor()]);
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning();
    }
    
    
    /**
     * Pressing registration button triggers a POST event. New user credentials
     * are sent to the database to allow them to log-in in the future
     *
     * @param sender The object that is firing the event
    */
    @IBAction func buttonPressed(sender: AnyObject) {
        if(self.password.text != self.confirm_password.text) {
            return;
        }
        
        var prelim : String = "email=\"" + self.email.text + "\"" + AMP +
                            "first_name=\"" + self.first_name.text + "\"" + AMP +
                            "last_name=\"" + self.last_name.text + "\"" + AMP +
                            "username=\"" + self.username.text + "\"" + AMP +
                            "password=\"" + self.password.text + "\"";
        
        prelim = prelim.stringByAddingPercentEncodingWithAllowedCharacters(.URLHostAllowedCharacterSet())!;
        
        var urlString : String = Constants.Base.registerURL + prelim;
        var url = NSURL(string: urlString);
        println(url);
        var request = NSMutableURLRequest(URL: url!);
        request.HTTPMethod = "POST";
        
        var dataString = "some data";
        let data = (dataString as NSString).dataUsingEncoding(NSUTF8StringEncoding);
        
        request.HTTPBody = data;
        
        var connection = NSURLConnection(request: request, delegate: self, startImmediately: false);
        
        println("sending request...");
        
        connection?.start();
    }
    
    @IBAction func back() {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func register() {
        dismissViewControllerAnimated(true, completion: nil)
    }
}
