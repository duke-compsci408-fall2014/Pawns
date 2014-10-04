//
//  Tournaments.swift
//  BayAreaChess
//
//  Created by Carlos Reyes on 10/2/14.
//  Copyright (c) 2014 Bay Area Chess. All rights reserved.
//

import UIKit

class Tournaments : UITableViewController, UITableViewDelegate, UITableViewDataSource {
    //@IBOutlet var tableView : UITableView!;
    
    var json_data : NSDictionary!;
    var eventList: [String] = [];
    
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
        self.tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cell")

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
        
        loadEventList(names);
        
        self.tableView.reloadData();
    }
    
    deinit {
        println("deiniting");
    }
    
    /* End Networking */
    
    
    /* Delegate Start */
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.eventList.count;
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell:UITableViewCell = self.tableView.dequeueReusableCellWithIdentifier("cell") as UITableViewCell
        cell.textLabel?.text = self.eventList[indexPath.row]
        return cell
    }

    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        println("You selected cell #\(indexPath.row)!");
    }
    
    /* Delegate End */
    
    func loadEventList (el : [String]) {
        eventList = el;
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