//
//  SpecificTournament.swift
//  BayAreaChess
//
//  Created by Carlos Reyes on 10/4/14.
//  Copyright (c) 2014 Bay Area Chess. All rights reserved.
//

import UIKit

class SpecificTournaments : UIViewController {
    
    @IBOutlet var name : UILabel?;
    @IBOutlet var descriptions : UITextView?;
    @IBOutlet var dates : UILabel?;
    @IBOutlet var start_time : UILabel?;
    @IBOutlet var address : UILabel?;
    @IBOutlet var amount : UILabel?;
    
    var myID : String? = "";
    var myAmount : Int? = 1;
    
    var changedURL : String = "";
    
    override func viewDidLoad() {
        super.viewDidLoad();
        
        var id : String = myID!;
        var s : String = toString(id);
        changedURL = Constants.Base.allTournamentsURL + s + "/"
        self.connect("");
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning();
    }
    
    var data = NSMutableData();
    
    func connect(query:NSString) {
        var url = NSURL(string: changedURL);
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
     * Deserializes JSON data from an input connection. Uses the data
     * to populate fields within the view, if the data exists.
     *
     * Includes data for the name of the tournament, any description,
     * dates, and address, as well as a cost of the tournament.
     *
     * @param connection The connection from which data comes
    */
    func connectionDidFinishLoading(connection: NSURLConnection!) {
        let data: NSData = self.data;
        let json = NSJSONSerialization.JSONObjectWithData(data, options: nil, error: nil) as NSDictionary;
        name?.text = Utils.getFieldFromJSON(json, field: Constants.JSON.summary);
        descriptions?.text = Utils.getFieldFromJSON(json, field: Constants.JSON.description);
        dates?.text = Utils.convertDate(Utils.getSubField(json, fieldOne: Constants.JSON.start, fieldTwo: Constants.JSON.subDate, fieldThree: Constants.JSON.dateTime));
        address?.text = Utils.getFieldFromJSON(json, field: Constants.JSON.location);
        start_time?.text = "No";
        amount?.text = "No";
        
        self.reloadInputViews();
        
    }
    
    deinit {
        println("deiniting");
    }
    
    /**
     * Maintains tournament ID and cost of tournament to send to the next view via segue,
     * so users know which tournament they are paying for, and how much. 
     *
     * @param segue The UIStoryboardSegue
     * @param sender The sending class
    */
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == Constants.Identifier.checkout) {
            let vc = segue.destinationViewController as PalPalPortal;
            vc.myTournamentID = self.myID;
            vc.myAmount = self.myAmount;
        }
    }
    
    @IBAction func back() {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
}