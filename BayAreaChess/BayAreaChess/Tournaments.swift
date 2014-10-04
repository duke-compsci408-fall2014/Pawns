//
//  Tournaments.swift
//  BayAreaChess
//
//  Created by Carlos Reyes on 10/2/14.
//  Copyright (c) 2014 Bay Area Chess. All rights reserved.
//

import UIKit

class Tournaments : UIViewController {
    @IBOutlet var textview : UITextView!
    
    var json_data : NSDictionary!
    
    let URL_STRING : String = "http://neptune.carlos.vc:3000/tournaments/";
    let NAME : String = "name";
    let DESCRIPTION : String = "description";
    let NEWLINE : String = "\n";
    let NAME_LABEL : String = "Name:";
    let DESC_LABEL : String = "Description:";
    let DID_RECEIVE : String = "didReceiveResponse";
    
    
    override func viewDidLoad() {
        super.viewDidLoad();
        self.connect("");
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning();
        // Dispose of any resources that can be recreated.
    }
    
    /* This is networking */
    
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
        var names = getTournamentData(json, field: NAME);
        var description = getTournamentData(json, field: DESCRIPTION);
        
        placeData(names, dataSetTwo: description);
    }
    
    deinit {
        println("deiniting");
    }
    
    /* End Networking */
    
    func placeData (dataSetOne : [String], dataSetTwo : [String]) {
        var tournamentInfo : String = "";
        for (var i = 0; i<dataSetOne.count; i++) {
            tournamentInfo += NAME_LABEL + " " + dataSetOne[i] + NEWLINE +
                                DESCRIPTION + " " + dataSetTwo[i] + NEWLINE + NEWLINE;
        }
        textview.text = tournamentInfo;
    }
    
    func getTournamentData (input : NSDictionary, field : String) -> [String] {
        var tournamentData = [String]();
        let json : Array = input["json"] as [AnyObject];
        for (index, element) in enumerate(json) {
            var name : String = element[field] as String
            tournamentData.append(name);
        }
        return tournamentData;
    }
    
    
}