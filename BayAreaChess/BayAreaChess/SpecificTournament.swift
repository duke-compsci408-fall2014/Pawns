//
//  SpecificTournament.swift
//  BayAreaChess
//
//  Created by Carlos Reyes on 10/4/14.
//  Copyright (c) 2014 Bay Area Chess. All rights reserved.
//

import UIKit

class SpecificTournaments : UIViewController {
    
    let URL_STRING : String = "http://neptune.carlos.vc:3000/tournaments/";
    let NAME : String = "name";
    let DESCRIPTION : String = "description";
    let DATE : String = "start_date";
    let NEWLINE : String = "\n";
    let NAME_LABEL : String = "Name:";
    let DESC_LABEL : String = "Description:";
    let DID_RECEIVE : String = "didReceiveResponse";
    
    
    override func viewDidLoad() {
        super.viewDidLoad();
        println("THIS");
        //self.connect("");
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
        var events = getTournamentData(json, field: NAME);
        var descriptions = getTournamentData(json, field: DESCRIPTION);
        var dates = getTournamentData(json, field: DATE);
        
        //self.tableView.relo adData();
    }
    
    deinit {
        println("deiniting");
    }
    
    func getTournamentData (input : NSDictionary, field : String) -> [String] {
        var tournamentData = [String]();
        let json : Array = input["json"] as [AnyObject];
        for (index, element) in enumerate(json) {
            var name : String = element[field] as String
            tournamentData.append(name);
            println(name);
        }
        return tournamentData;
    }
}