//
//  SpecificTournament.swift
//  BayAreaChess
//
//  Created by Carlos Reyes on 10/4/14.
//  Copyright (c) 2014 Bay Area Chess. All rights reserved.
//

import UIKit

class SpecificTournaments : UIViewController {
    
    var URL_STRING : String = "http://neptune.carlos.vc:3000/tournaments/base/";
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
        var s : String = toString(myID?);
        URL_STRING += s;
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
        name?.text = getTournamentData(json, field: NAME);
        descriptions?.text = getTournamentData(json, field: DESCRIPTION);
        dates?.text = getTournamentData(json, field: DATE);
//        cost?.text = getTournamentData(json, field: AMOUNT); //REQUIRES TYPE COERSION
        
        self.reloadInputViews();
        
    }
    
    deinit {
        println("deiniting");
    }
    
    func getTournamentData (input : NSDictionary, field : String) -> String {
        var tournamentData : String!;
        let json : Array = input["json"] as [AnyObject];
        for (index, element) in enumerate(json) {
            var name : String = element[field] as String
            tournamentData = name;
        }
        return tournamentData;
    }
    
    func formatDate (str : String) -> String {
        var formatter: NSDateFormatter = NSDateFormatter();
        formatter.dateFormat = "dd-MM-yyyy";
        var date = formatter.dateFromString(str);
        var s : String = formatter.stringFromDate(date!);
        return s;
    }
}