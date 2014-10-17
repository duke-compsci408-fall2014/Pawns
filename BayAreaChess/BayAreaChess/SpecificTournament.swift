//
//  SpecificTournament.swift
//  BayAreaChess
//
//  Created by Carlos Reyes on 10/4/14.
//  Copyright (c) 2014 Bay Area Chess. All rights reserved.
//

import UIKit

class SpecificTournaments : UIViewController {
    
    let URL_STRING : String = "http://neptune.carlos.vc:3000/tournaments/base/6/";
    let NAME : String = "name";
    let DESCRIPTION : String = "description";
    let DATE : String = "start_date";
    let AMOUNT : String = "amount";
    let NEWLINE : String = "\n";
    let NAME_LABEL : String = "Name:";
    let DESC_LABEL : String = "Description:";
    let DID_RECEIVE : String = "didReceiveResponse";
    
    @IBOutlet var name : UILabel?;
    @IBOutlet var descriptions : UILabel?;
    @IBOutlet var dates : UILabel?;
    @IBOutlet var cost : UILabel?;

    
    override func viewDidLoad() {
        super.viewDidLoad();
        self.connect("");
        //self.tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
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
        
        //self.tableView.relo adData();
    }
    
    deinit {
        println("deiniting");
    }
    
    func getTournamentData (input : NSDictionary, field : String) -> String {
        var tournamentData : String!;
        let json : Array = input["json"] as [AnyObject];
        println(json);
        for (index, element) in enumerate(json) {
            var name : String = element[field] as String
            tournamentData = name;
        }
        return tournamentData;
    }
}