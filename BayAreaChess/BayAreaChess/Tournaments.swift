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
    
    let URL_STRING : String = "http://bac.colab.duke.edu:3000/api/v1/tournaments/all/";
    let NAME : String = "name";
    let DESCRIPTION : String = "description";
    let DATE : String = "date_play";
    let NEWLINE : String = "\n";
    let NAME_LABEL : String = "Name:";
    let DESC_LABEL : String = "Description:";
    let DID_RECEIVE : String = "didReceiveResponse";
    let ID : String = "id";
    
    var selectedID : Int? = 0;
    var myName : String?;

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
        let json = NSJSONSerialization.JSONObjectWithData(data, options: nil, error: nil) as NSArray;
        var name = Utils.getListFromJSON(json, field: NAME);
        var descriptions = Utils.getListFromJSON(json, field: DESCRIPTION);
        var dates = Utils.getListFromJSON(json, field: DATE);
        var ids = Utils.getIntArray(json, field: ID);
        
        loadEventList(name);
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
        cell = UITableViewCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: "cell");

        cell.textLabel.text = self.eventList[indexPath.row];
        cell.detailTextLabel?.text = self.dateList[indexPath.row];
        cell.backgroundColor = UIColor.clearColor();
        cell.textLabel.textColor = UIColor.whiteColor();
        cell.detailTextLabel?.textColor = UIColor.whiteColor();
        return cell;
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        println("You selected cell #\(indexPath.row)!");
        var s : String = self.eventList[indexPath.row];
        println(self.idList[indexPath.row]);
        myName = s;
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
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        if (segue.identifier == "selectEvent") {
            let vc = segue.destinationViewController as SpecificTournaments;
            vc.myID = self.selectedID;
            vc.myName = self.myName;
        }
    }
    
    @IBAction func back() {
        dismissViewControllerAnimated(true, completion: nil)
    }
}