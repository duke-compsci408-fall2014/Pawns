//
//  UserUpdate.swift
//  BayAreaChess
//
//  Created by Carlos Reyes on 11/4/14.
//  Copyright (c) 2014 Bay Area Chess. All rights reserved.
//

import UIKit

class UserUpdate : UIViewController {
    
    @IBOutlet var first_name : UITextField!;
    @IBOutlet var last_name : UITextField!;
    @IBOutlet var email : UITextField!;
    @IBOutlet var username : UITextField!;
    @IBOutlet var phone : UITextField!;
    
    let AMP : String = "&";
    
    var myUsername : String?;
    
    var request = HTTPTask();
    
    override func viewDidLoad() {
        super.viewDidLoad();
        
        first_name.attributedPlaceholder = NSAttributedString(string:Constants.Label.lastName,
            attributes:[NSForegroundColorAttributeName: UIColor.lightTextColor()]);
        last_name.attributedPlaceholder = NSAttributedString(string:Constants.Label.lastName,
            attributes:[NSForegroundColorAttributeName: UIColor.lightTextColor()]);
        email.attributedPlaceholder = NSAttributedString(string:Constants.Label.email,
            attributes:[NSForegroundColorAttributeName: UIColor.lightTextColor()]);
        username.attributedPlaceholder = NSAttributedString(string:Constants.Label.user,
            attributes:[NSForegroundColorAttributeName: UIColor.lightTextColor()]);
        phone.attributedPlaceholder = NSAttributedString(string:Constants.Label.phone,
            attributes:[NSForegroundColorAttributeName: UIColor.lightTextColor()]);
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning();
    }
    
    /**
     * Sends PUT request to API server to update user information.
     * 
     * @param sender Sending object
    */
    @IBAction func buttonPressed(sender: AnyObject) {
        var obj : Dictionary<String, String> = ["email":self.email.text, "first_name":self.first_name.text, "last_name":self.last_name.text, "username":self.username.text];
        var urlString : String = Constants.Base.updateURL + self.myUsername! + "/";
        
        request.requestSerializer = JSONRequestSerializer();
        
        request.PUT(urlString, parameters: obj, success: {(response: HTTPResponse) in
                let data : NSData = response.responseObject as NSData;
                let json = NSJSONSerialization.JSONObjectWithData(data, options: nil, error: nil) as NSDictionary;
                (self.presentingViewController? as User).populateFields(json);
                self.dismissViewControllerAnimated(true, completion: nil);
            },failure: {(error: NSError, response: HTTPResponse?) in
                println("There was an error, LOL");
        });
    }
    
    @IBAction func back() {
        dismissViewControllerAnimated(true, completion: nil);
    }
}
