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
	
    let URL_STRING : String = "http://bac.colab.duke.edu:3000/api/v1/login/verify/";
    let DID_RECEIVE : String = "didReceiveResponse";
    var verification : String = "failure";
    
    var currentURL : String = "";
    
    @IBOutlet var name : UILabel?;
    @IBOutlet var descriptions : UITextView?;
    @IBOutlet var dates : UILabel?;
    @IBOutlet var cost : UILabel?;
    
    var myID : Int? = 0;
    
    override func viewDidLoad() {
        super.viewDidLoad();
        username.attributedPlaceholder = NSAttributedString(string:"Username",
            attributes:[NSForegroundColorAttributeName: UIColor.lightTextColor()]);
        password.attributedPlaceholder = NSAttributedString(string:"Password",
            attributes:[NSForegroundColorAttributeName: UIColor.lightTextColor()]);
    }

	@IBAction func verifyLogin (sender : AnyObject) {
        currentURL = URL_STRING + username.text + "/" + password.text;
        self.connect("");
	}
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning();
    }
    
    var data = NSMutableData();
    
    func connect(query:NSString) {
        var url = NSURL(string: currentURL);
        var request = NSURLRequest(URL: url!);
        var conn = NSURLConnection(request: request, delegate: self, startImmediately: true);
    }
    
    
    func connection(didReceiveResponse: NSURLConnection!, didReceiveResponse response: NSURLResponse!) {
        println(DID_RECEIVE);
    }
    
    func connection(connection: NSURLConnection!, didReceiveData conData: NSData!) {
        self.data = NSMutableData(); // Flush data pipe
        self.data.appendData(conData);
    }
    
    func connectionDidFinishLoading(connection: NSURLConnection!) {
        var data : NSData = NSData();
        data = self.data;
        println(data);
        let json = NSJSONSerialization.JSONObjectWithData(data, options: nil, error: nil) as NSDictionary;
        verification = getFromJSON (json, field: "verification");
        println(verification);

        if (verification == "success") {
            label.text = "";
            self.performSegueWithIdentifier("login", sender: self);
        }
        else {
            label.textColor = UIColor.redColor();
            label.text = "Rejected!";
        }
    }
    
    deinit {
        println("deiniting");
    }
    
    func getFromJSON (input : NSDictionary, field : String) -> String {
        var tournamentData : String! = "";
        if ((input[field] as? String) != nil) {
            tournamentData = input["verification"] as String;
        }
        return tournamentData;
    }
    
    @IBAction func onMenu() {
        (tabBarController as TabBarController).sidebar.showInViewController(self, animated: true)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        if (segue.identifier == "login") {
            let vc = segue.destinationViewController as User;
            vc.myUsername = self.username.text as String;
        }
    }
}