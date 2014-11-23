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
    @IBOutlet var imageURL : UIImageView?;

    var imagename : String!;
    var customURL : String!;
    
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
        println(Constants.Response.recieved);
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
        
        var userHash : String = Utils.getFieldFromJSON(json, field: Constants.Gravatar.hash);
        
        imagename = Constants.Gravatar.URL + userHash + Constants.Gravatar.size;
        var url : NSURL = NSURL(string: imagename)!;
        var imgData : NSData = NSData(contentsOfURL: url, options: nil, error: nil)!
        imageURL?.image = UIImage(data: imgData);
        imageURL?.layer.borderWidth = 2.0;
        imageURL?.layer.borderColor = UIColor.blackColor().CGColor;
        self.reloadInputViews();
        
    }
    
    func populateFields (json : NSDictionary) {
        // Dispatch UI updates to main thread
        dispatch_async(dispatch_get_main_queue(), {
            self.name?.text = Utils.getFieldFromJSON(json, field: Constants.JSON.firstName) + " " + Utils.getFieldFromJSON(json, field: Constants.JSON.lastName);
            self.email?.text = Utils.getFieldFromJSON(json, field: Constants.JSON.email);
            self.username?.text = Utils.getFieldFromJSON(json, field: Constants.JSON.user);
            
            self.phone?.text = Utils.getFieldFromJSON(json, field: Constants.JSON.phone);
            self.address?.text = Utils.getFieldFromJSON(json, field: Constants.JSON.address) + " " +
                Utils.getFieldFromJSON(json, field: Constants.JSON.city) + ", " + Utils.getFieldFromJSON(json, field: constants.JSON.state);
            self.reloadInputViews();
        });
    }

    func viewLoaded () {
        customURL = Constants.Base.loginURL + myUsername! + "/";
        self.connect("");
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == Constants.Base.update) {
            let vc = segue.destinationViewController as UserUpdate;
            vc.myUsername = self.myUsername;
        }
    }
    
    @IBAction func back() {
        dismissViewControllerAnimated(true, completion: nil)
    }
}