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
    
    let URL_STRING = "http://neptune.carlos.vc:3000/tournaments/";
    let NAME = "name";
    let DESCRIPTION = "description";
    
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
        println("didReceiveResponse")
    }
    
    func connection(connection: NSURLConnection!, didReceiveData conData: NSData!) {
        self.data.appendData(conData)
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
            println("Name: " + dataSetOne[i] + " Description: " + dataSetTwo[i]);
            tournamentInfo += "Name: " + dataSetOne[i] + " Description: " + dataSetTwo[i];
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