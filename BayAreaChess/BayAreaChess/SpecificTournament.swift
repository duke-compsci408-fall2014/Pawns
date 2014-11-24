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
    
    var myID : Int? = 0;
    var myName : String?;
    var myAmount : Int? = 1;
    
    override func viewDidLoad() {
        super.viewDidLoad();
        
        var id : Int = myID!;
        var s : String = toString(id);
        var changedURL = Constants.Base.allTournamentsURL + s + "/"
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
    
    func connectionDidFinishLoading(connection: NSURLConnection!) {
        let data: NSData = self.data;
        let json = NSJSONSerialization.JSONObjectWithData(data, options: nil, error: nil) as NSDictionary;
        name?.text = self.myName;
        descriptions?.text = Utils.getFieldFromJSON(json, field: Constants.JSON.description);
        dates?.text = Utils.getFieldFromJSON(json, field: Constants.JSON.date);
        address?.text = Utils.getFieldFromJSON(json, field: Constant.JSON.address) + ", " +
                        Utils.getFieldFromJSON(json, field: Constant.JSON.city) + ", " +
                        Utils.getFieldFromJSON(json, field: Constant.JSON.state);
        start_time?.text = Utils.getFieldFromJSON(json, field: Constants.JSON.startTime);
        amount?.text = Utils.getFieldFromJSON(json, field: Constant.JSON.amount);
        
        self.reloadInputViews();
        
    }
    
    deinit {
        println("deiniting");
    }
    
    func formatDate (str : String) -> String {
        var formatter: NSDateFormatter = NSDateFormatter();
        formatter.dateFormat = "dd-MM-yyyy";
        var date = formatter.dateFromString(str);
        var s : String = formatter.stringFromDate(date!);
        return s;
    }
    
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