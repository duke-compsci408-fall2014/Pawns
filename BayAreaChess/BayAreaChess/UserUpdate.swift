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
    
    let URL_STRING : String = "http://bac.colab.duke.edu:3000/login/update/";
    let AMP : String = "&";
    
    var myUsername : String?;
    
    override func viewDidLoad() {
        super.viewDidLoad();
        println(self.myUsername);
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning();
    }
    
    
    @IBAction func buttonPressed(sender: AnyObject) {
        var prelim : String = "email=" + "%22" + self.email.text + "%22" + AMP +
                                "first_name=" + "%22" + self.first_name.text + "%22" + AMP +
                                "last_name=" + "%22" + self.last_name.text + "%22" + AMP +
                                "username=" + "%22" + self.username.text + "%22"; // + AMP +
                                //"phone=" + "%22" + self.phone.text + "%22";
        
        
        var urlString : String = URL_STRING + self.myUsername! + "/" + prelim;
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
}
