//
//  User.swift
//  BayAreaChess
//
//  Created by Carlos Reyes on 10/5/14.
//  Copyright (c) 2014 Bay Area Chess. All rights reserved.
//

import UIKit

class User: UIViewController {
    
    @IBOutlet var firstName : UILabel!;
    @IBOutlet var lastName : UILabel!;
    @IBOutlet var email : UILabel!;
    @IBOutlet var username : UILabel!;
    @IBOutlet var dateJoined : UILabel!;
    
    ///////////////////////////////
    
    var URL_STRING : String = "http://bac.colab.duke.edu:3000/tournaments/base/";
    let NAME : String = "name";
    let DESCRIPTION : String = "description";
    let DATE : String = "start_date";
    let AMOUNT : String = "amount";
    let NEWLINE : String = "\n";
    let NAME_LABEL : String = "Name:";
    let DESC_LABEL : String = "Description:";
    let DID_RECEIVE : String = "didReceiveResponse";
    
    @IBOutlet var name : UILabel?;
    @IBOutlet var descriptions : UITextView?;
    @IBOutlet var dates : UILabel?;
    @IBOutlet var cost : UILabel?;
    
    
    var myID : Int? = 0;
    
    override func viewDidLoad() {
        super.viewDidLoad();
        
        var id : Int = myID!;
        var s : String = toString(id);
        URL_STRING += s + "/";
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
        //        cost?.text = getTournamentData(json, field: AMOUNT); //REQUIRES TYPE COERSION
        
        self.reloadInputViews();
        
    }
    
}