//
//  User.swift
//  BayAreaChess
//
//  Created by Carlos Reyes on 10/5/14.
//  Copyright (c) 2014 Bay Area Chess. All rights reserved.
//

import UIKit

class User: UIViewController {
    
    @IBOutlet var name : UILabel?;
    @IBOutlet var email : UILabel?;
    @IBOutlet var username : UILabel?;
    @IBOutlet var dateJoined : UILabel?;
    @IBOutlet var phone : UILabel?;
    @IBOutlet var address : UILabel?;
    
    var imagename : String!;
    var customURL : String!;

    @IBOutlet var imageURL : UIImageView?;
    
    var URL_STRING : String = "http://bac.colab.duke.edu:3000/api/v1/login/";
    let DESCRIPTION : String = "description";
    let DATE : String = "start_date";
    let AMOUNT : String = "amount";
    let NEWLINE : String = "\n";
    let NAME_LABEL : String = "Name:";
    let DESC_LABEL : String = "Description:";
    let DID_RECEIVE : String = "didReceiveResponse";
    let GRAVATAR_URL : String = "http://www.gravatar.com/avatar/";
    let IMG_SIZE : String = "?s=120";

    var myID : Int? = 0;
    var myUsername : String?;
    
    override func viewDidLoad() {
        super.viewDidLoad();
        self.viewLoaded();
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning();
    }
    
    var data = NSMutableData();
    
    func connect(query:NSString) {
        var url = NSURL(string: customURL);
        println(url);
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
        let json = NSJSONSerialization.JSONObjectWithData(data, options: nil, error: nil) as NSDictionary;
        
        populateFields(json);
        
        var userHash : String = Utils.getFieldFromJSON(json, field: "gravatar_hash");
        
        imagename = GRAVATAR_URL + userHash + IMG_SIZE;
        var url : NSURL = NSURL(string: imagename)!;
        var imgData : NSData = NSData(contentsOfURL: url, options: nil, error: nil)!
        imageURL?.image = UIImage(data: imgData);
        imageURL?.layer.borderWidth = 2.0;
        imageURL?.layer.borderColor = UIColor.blackColor().CGColor;
        self.reloadInputViews();
        
    }
    
    func populateFields (json : NSDictionary) {
        //initializeVariables();
        // Dispatch UI updates to main thread
        dispatch_async(dispatch_get_main_queue(), {
            self.name?.text = Utils.getFieldFromJSON(json, field: "first_name") + " " + Utils.getFieldFromJSON(json, field: "last_name");
            self.email?.text = Utils.getFieldFromJSON(json, field: "email");
            self.username?.text = Utils.getFieldFromJSON(json, field: "username");
            
            self.phone?.text = Utils.getFieldFromJSON(json, field: "main_phone");
            self.address?.text = Utils.getFieldFromJSON(json, field: "address") + " " +
                Utils.getFieldFromJSON(json, field: "city") + ", " + Utils.getFieldFromJSON(json, field: "state");
            self.reloadInputViews();
        });
    }

    func viewLoaded () {
        customURL = URL_STRING + myUsername! + "/";
        self.connect("");
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == "update") {
            let vc = segue.destinationViewController as UserUpdate;
            vc.myUsername = self.myUsername;
        }
    }
    
    @IBAction func back() {
        dismissViewControllerAnimated(true, completion: nil)
    }
}