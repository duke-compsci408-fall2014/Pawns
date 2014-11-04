//
//  UserUpdate.swift
//  BayAreaChess
//
//  Created by Carlos Reyes on 11/4/14.
//  Copyright (c) 2014 Bay Area Chess. All rights reserved.
//

import UIKit

class UserUpdate : UIViewController {
    
    let URL_STRING : String = "http://bac.colab.duke.edu:3000/login/update/";
    
    override func viewDidLoad() {
        super.viewDidLoad();
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning();
    }
    
    
    @IBAction func buttonPressed(sender: AnyObject) {
        
        var urlString : String = URL_STRING + "duke" + "/" + "email" + "/" + "money@duke.edu";
        
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
}
