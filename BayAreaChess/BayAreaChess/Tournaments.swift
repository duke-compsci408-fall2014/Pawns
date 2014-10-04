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
    var items: [String] = ["We", "Heart", "Swift"];
    
    let URL_STRING : String = "http://neptune.carlos.vc:3000/tournaments/";
    let NAME : String = "name";
    let DESCRIPTION : String = "description";
    let NEWLINE : String = "\n";
    let NAME_LABEL : String = "Name:";
    let DESC_LABEL : String = "Description:";
    let DID_RECEIVE : String = "didReceiveResponse";
    
    
    override func viewDidLoad() {
        super.viewDidLoad();
        
        self.tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cell");

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
        
        
//        self.tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cell")

        //placeData(names, dataSetTwo: description);
    }
    
    deinit {
        println("deiniting");
    }
    
    /* End Networking */
    
    
    /* Delegate Start */
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.items.count;
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell:UITableViewCell = self.tableView.dequeueReusableCellWithIdentifier("cell") as UITableViewCell
        cell.textLabel?.text = self.items[indexPath.row]
        return cell
    }

    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        println("You selected cell #\(indexPath.row)!");
    }
    
    
    /* Delegate End */

    
    
    func placeData (dataSetOne : [String], dataSetTwo : [String]) {
        
        var cell = tableView.dequeueReusableCellWithIdentifier("CELL") as? UITableViewCell;
        
        if (cell == nil) {
            cell = UITableViewCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: "CELL")
        }
        
        cell!.textLabel?.text = dataSetOne[1];
        cell!.detailTextLabel?.text = dataSetTwo[1];
        self.tableView.addSubview(cell!);
        
        
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