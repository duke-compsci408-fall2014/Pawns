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
    
    let URL_STRING : String = "http://bac.colab.duke.edu:3000/login/register/";
    let AMP : String = "&";
    
    
    override func viewDidLoad() {
        super.viewDidLoad();
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning();
    }
    
    
    @IBAction func buttonPressed(sender: AnyObject) {
        if(self.password.text != self.confirm_password.text) {
            return;
        }
        
        var prelim : String = "email=" + "%22" + self.email.text + "%22" + AMP +
            "first_name=" + "%22" + self.first_name.text + "%22" + AMP +
            "last_name=" + "%22" + self.last_name.text + "%22" + AMP +
            "username=" + "%22" + self.username.text + "%22" + AMP +
            "password=" + "%22" + self.password.text + "%22";
        
        var urlString : String = URL_STRING + prelim;
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
