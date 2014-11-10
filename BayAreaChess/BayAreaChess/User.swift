//
//  User.swift
//  BayAreaChess
//
//  Created by Carlos Reyes on 10/5/14.
//  Copyright (c) 2014 Bay Area Chess. All rights reserved.
//

import UIKit

class User: UIViewController {
    
    @IBOutlet var name : UILabel!;
    @IBOutlet var email : UILabel!;
    @IBOutlet var username : UILabel!;
    @IBOutlet var dateJoined : UILabel!;
    @IBOutlet var phone : UILabel!;
    @IBOutlet var address : UILabel!;
    
    var imagename : String!;
    @IBOutlet var imageURL : UIImageView?;
    
    var URL_STRING : String = "http://bac.colab.duke.edu:3000/login/";
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
        URL_STRING += myUsername! + "/";
        println(URL_STRING);
        self.connect("");
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning();
    }
    
    var data = NSMutableData();
    
    func connect(query:NSString) {
        var url = NSURL(string: URL_STRING);
        var request = NSURLRequest(URL: url!);
        var conn = NSURLConnection(request: request, delegate: self, startImmediately: true);
    }
    
    
    func connection(didReceiveResponse: NSURLConnection!, didReceiveResponse response: NSURLResponse!) {
        println(DID_RECEIVE);
    }
    
    func connection(connection: NSURLConnection!, didReceiveData conData: NSData!) {
        self.data.appendData(conData);
    }
    
    func connectionDidFinishLoading(connection: NSURLConnection!) {
        let data: NSData = self.data;
        let json = NSJSONSerialization.JSONObjectWithData(data, options: nil, error: nil) as NSDictionary;
        name?.text = getTournamentData(json, field: "first_name") + " " + getTournamentData(json, field: "last_name");
        email?.text = getTournamentData(json, field: "email");
        username?.text = getTournamentData(json, field: "username");
        phone?.text = getTournamentData(json, field: "main_phone");
        address?.text = getTournamentData(json, field: "address") + " " +
                        getTournamentData(json, field: "city");
        
        var userHash : String = "0a553560c3f8184f194d2366a664553b";
        
        imagename = GRAVATAR_URL + userHash + IMG_SIZE;
        var url : NSURL = NSURL(string: imagename)!;
        var imgData : NSData = NSData(contentsOfURL: url, options: nil, error: nil)!
        imageURL?.image = UIImage(data: imgData);
        imageURL?.layer.borderWidth = 2.0;
        imageURL?.layer.borderColor = UIColor.blackColor().CGColor;
        
        self.reloadInputViews();
        
    }
    
    func getTournamentData (input : NSDictionary, field : String) -> String {
        var tournamentData : String! = "";
        let json : Array = input["json"] as [AnyObject];
        for (index, element) in enumerate(json) {
            var name : String = element[field] as String
            tournamentData = name;
        }
        return tournamentData;
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