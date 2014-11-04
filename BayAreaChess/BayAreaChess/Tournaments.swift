//
//  Tournaments.swift
//  BayAreaChess
//
//  Created by Carlos Reyes on 10/2/14.
//  Copyright (c) 2014 Bay Area Chess. All rights reserved.
//

import UIKit

class Tournaments : UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var json_data : NSDictionary!;
    var eventList: [String] = [];
    var descriptionList: [String] = [];
    var dateList: [String] = [];
    var idList : [Int] = [];
    
    var id_dict: [String:Int]?;
    
    let URL_STRING : String = "http://bac.colab.duke.edu:3000/tournaments/base/";
    let NAME : String = "name";
    let DESCRIPTION : String = "description";
    let DATE : String = "start_date";
    let NEWLINE : String = "\n";
    let NAME_LABEL : String = "Name:";
    let DESC_LABEL : String = "Description:";
    let DID_RECEIVE : String = "didReceiveResponse";
    let ID : String = "id";
    
    var selectedID : Int? = 0;

    var list : [String] = ["cell", "money"];
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBAction func onMenu() {
        (tabBarController as TabBarController).sidebar.showInViewController(self, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad();
        self.connect("");
        self.tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cell");
        self.tableView.dataSource = self;
        self.tableView.delegate = self;
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning();
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
        
        var events = getTournamentData(json, field: NAME);
        var descriptions = getTournamentData(json, field: DESCRIPTION);
        var dates = getTournamentData(json, field: DATE);
        var ids = getTournamentInt(json, field: ID);
        
        loadEventList(events);
        loadDescriptionList(descriptions);
        loadDateList(dates);
        loadIDList(ids);
        
        self.tableView.reloadData();
    }
    
    deinit {
        println("deiniting");
    }
    
    /* End Networking */
    
    
    /* Delegate Start */
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.eventList.count;
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell:UITableViewCell = self.tableView.dequeueReusableCellWithIdentifier("cell") as UITableViewCell;
        cell = UITableViewCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: "cell")!;

        cell.textLabel?.text = self.eventList[indexPath.row];
        cell.detailTextLabel?.text = self.dateList[indexPath.row];
        return cell;
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        println("You selected cell #\(indexPath.row)!");
        var s : String = self.eventList[indexPath.row];
        println(self.idList[indexPath.row]);
        selectedID = self.idList[indexPath.row];
        self.performSegueWithIdentifier("selectEvent", sender: tableView as UITableView)
    }
    
    /* Delegate End */
    
    func loadEventList (l : [String]) {
        eventList = l;
    }
    func loadDescriptionList (l : [String]) {
        descriptionList = l;
    }
    func loadDateList (l : [String]) {
        for item in l {
            var formatter: NSDateFormatter = NSDateFormatter();
            formatter.dateFormat = "dd-MM-yyyy";
            let stringDate: String = formatter.stringFromDate(NSDate());
            dateList.append(stringDate);
        }
    }
    func loadIDList (l : [Int]) {
        idList = l;
    }
    
    func getTournamentData (input : NSDictionary, field : String) -> [String] {
        var tournamentData = [String]();
        let json : Array = input["json"] as [AnyObject];
        for (index, element) in enumerate(json) {
            var name : String = element[field] as String;
            tournamentData.append(name);
        }
        return tournamentData;
    }
    
    func getTournamentInt (input : NSDictionary, field : String) -> [Int] {
        var tournamentData = [Int]();
        let json : Array = input["json"] as [AnyObject];
        for (index, element) in enumerate(json) {
            var num : Int = element[field] as Int;
            tournamentData.append(num);
        }
        return tournamentData;
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        if (segue.identifier == "selectEvent") {
            let vc = segue.destinationViewController as SpecificTournaments;
            vc.myID = selectedID;
        }
    }
    
    
}