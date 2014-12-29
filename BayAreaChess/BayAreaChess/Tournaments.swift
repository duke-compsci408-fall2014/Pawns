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
    
    var selectedID : Int? = 0;
    var myName : String?;
    
    @IBOutlet weak var tableView: UITableView!
    
    /**
     * Pulls up side bar on event
    */
    @IBAction func onMenu() {
        (tabBarController as TabBarController).sidebar.showInViewController(self, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad();
        self.connect("");
        self.tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: Constants.Identifier.cell);
        self.tableView.dataSource = self;
        self.tableView.delegate = self;
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning();
    }
    
    /* This is networking */
    
    var data = NSMutableData();
    
    func connect(query:NSString) {
        var url = NSURL(string: Constants.Base.allTournamentsURL);
        var request = NSURLRequest(URL: url!);
        var conn = NSURLConnection(request: request, delegate: self, startImmediately: true);
    }
    
    
    func connection(didReceiveResponse: NSURLConnection!, didReceiveResponse response: NSURLResponse!) {
        println(Constants.Response.recieved);
    }
    
    func connection(connection: NSURLConnection!, didReceiveData conData: NSData!) {
        self.data.appendData(conData);
    }
    
    /**
     * Deserializes JSON coming in through the connection passed in, populates fields from this object
     *
     * @param connection The connection being passed through
    */
    func connectionDidFinishLoading(connection: NSURLConnection!) {
        let data: NSData = self.data;
        let json = NSJSONSerialization.JSONObjectWithData(data, options: nil, error: nil) as NSArray;
        var name = Utils.getListFromJSON(json, field: Constants.JSON.summary);
        var descriptions = Utils.getListFromJSON(json, field: Constants.JSON.location);
        var dates = Utils.getListFromSubJSON(json, fieldOne: Constants.JSON.start, fieldTwo: Constants.JSON.subDate, fieldThree: Constants.JSON.dateTime);
//        var ids = Utils.getIntArrayFromJSON(json, field: Constants.JSON.id);
        loadEventList(name);
        loadDescriptionList(descriptions);
        loadDateList(dates);
//        loadIDList(ids);
        
        self.tableView.reloadData();
    }
    
    deinit {
        println(Constants.Response.deiniting);
    }
    
    /* End Networking */
    
    
    /* Delegate Start */
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.eventList.count;
    }
    
    /**
     * Deserializes JSON coming in through the connection passed in, populates text, and image placeholders
     *
     * @param tableView The targeted table view
     * @param indexPath The current index path
     * @return UITableViewCell The resulting cell
    */
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell:UITableViewCell = self.tableView.dequeueReusableCellWithIdentifier(Constants.Identifier.cell) as UITableViewCell;
        cell = UITableViewCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: Constants.Identifier.cell);

        cell.textLabel?.text = self.eventList[indexPath.row];
        cell.detailTextLabel?.text = self.dateList[indexPath.row] + " | " + self.descriptionList[indexPath.row];
        cell.backgroundColor = UIColor.clearColor();
        cell.textLabel?.textColor = UIColor.whiteColor();
        cell.detailTextLabel?.textColor = UIColor.whiteColor();
        return cell;
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        println("You selected cell #\(indexPath.row)!");
        var s : String = self.eventList[indexPath.row];
        println(self.idList[indexPath.row]);
        myName = s;
        selectedID = self.idList[indexPath.row];
        self.performSegueWithIdentifier(Constants.Identifier.selectEvent, sender: tableView as UITableView)
    }
    
    /* Delegate End */
    
    /**
     * Loads String array into String array used by tableview
     *
     * @param l The String array to be read from
    */
    func loadEventList (l : [String]) {
        eventList = l;
    }
    /**
     * Loads String array into String array used by tableview
     *
     * @param l The String array to be read from
    */
    func loadDescriptionList (l : [String]) {
        descriptionList = l;
    }
    
    /**
     * Loads String array into String array used by tableview
     *
     * @param l The String array to be read from
    */
    func loadDateList (l : [String]) {
        for item in l {
            var formatter: NSDateFormatter = NSDateFormatter();
            formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssSSSZZZZ";
            var date : NSDate = NSDate();
            if (formatter.dateFromString(item) != nil) {
                date = formatter.dateFromString(item)!;
            }
            else {
                formatter.dateFormat = "yyyy-MM-dd";
                date = formatter.dateFromString(item)!;
            }
            formatter.dateFormat = "MM-dd-yyyy ";
            let stringDate: String = formatter.stringFromDate(date);
            dateList.append(stringDate);
        }
    }
    
    /**
     * Loads Int array into Int array used by tableview
     *
     * @param l The Int array to be read from
    */
    func loadIDList (l : [Int]) {
        idList = l;
    }
    
    /**
     * Sends the id and the name of the selected tournament to the destination view controller.
     *
     * @param segue The UIStoryboardSegue
     * @param sender The sending class
    */
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        if (segue.identifier == Constants.Identifier.selectEvent) {
            let vc = segue.destinationViewController as SpecificTournaments;
            vc.myID = self.selectedID;
            vc.myName = self.myName;
        }
    }
    
    @IBAction func back() {
        dismissViewControllerAnimated(true, completion: nil)
    }
}