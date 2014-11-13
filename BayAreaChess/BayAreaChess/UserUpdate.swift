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
    
    let URL_STRING : String = "http://bac.colab.duke.edu:3000/api/v1/login/update/";
    let AMP : String = "&";
    
    var myUsername : String?;
    
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
        phone.attributedPlaceholder = NSAttributedString(string:"Phone Number",
            attributes:[NSForegroundColorAttributeName: UIColor.lightTextColor()]);
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning();
    }
    
    
    @IBAction func buttonPressed(sender: AnyObject) {
        
        var prelim : String = "email=\"" + self.email.text + "\"" + AMP + "first_name=\"" +
                            self.first_name.text + "\"" + AMP + "last_name=\"" + self.last_name.text +
                            "\"" + AMP + "username=\"" + self.username.text + "\"";
        
        prelim = prelim.stringByAddingPercentEncodingWithAllowedCharacters(.URLHostAllowedCharacterSet())!;
        var urlString : String = URL_STRING + self.myUsername! + "/" + prelim;
        println(urlString);
        var url = NSURL(string: urlString);
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
}
