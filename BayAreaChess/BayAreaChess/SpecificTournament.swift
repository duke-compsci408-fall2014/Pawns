//
//  SpecificTournament.swift
//  BayAreaChess
//
//  Created by Carlos Reyes on 10/4/14.
//  Copyright (c) 2014 Bay Area Chess. All rights reserved.
//

import UIKit

class SpecificTournaments : UIViewController {
    
    var URL_STRING : String = "http://bac.colab.duke.edu:3000/api/v1/tournaments/all/";
    let NAME : String = "name";
    let DESCRIPTION : String = "description";
    let DATE : String = "date_play";
    let NEWLINE : String = "\n";
    let NAME_LABEL : String = "Name:";
    let DESC_LABEL : String = "Description:";
    let DID_RECEIVE : String = "didReceiveResponse";
    let CITY : String = "city";
    let ADDRESS : String = "address";
    let STATE : String = "state";
    let AMOUNT : String = "amount";
    let START_TIME : String = "start_time";
    
    @IBOutlet var name : UILabel?;
    @IBOutlet var descriptions : UITextView?;
    @IBOutlet var dates : UILabel?;
    @IBOutlet var start_time : UILabel?;
    @IBOutlet var address : UILabel?;
    @IBOutlet var amount : UILabel?;
    
    var myID : Int? = 0;
    var myName : String?;
    
    override func viewDidLoad() {
        super.viewDidLoad();
        
        var id : Int = myID!;
        var s : String = toString(id);
        URL_STRING += s + "/";
        println(URL_STRING);
        self.connect("");
        
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
        name?.text = self.myName;
        descriptions?.text = Utils.getFieldFromJSON(json, field: DESCRIPTION);
        dates?.text = Utils.getFieldFromJSON(json, field: DATE);
        address?.text = Utils.getFieldFromJSON(json, field: ADDRESS) + ", " +
                        Utils.getFieldFromJSON(json, field: CITY) + ", " +
                        Utils.getFieldFromJSON(json, field: STATE);
        start_time?.text = Utils.getFieldFromJSON(json, field: START_TIME);
        amount?.text = Utils.getFieldFromJSON(json, field: AMOUNT);
        
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
        if (segue.identifier == "checkout") {
            let vc = segue.destinationViewController as PalPalPortal;
            vc.myTournamentID = self.myID;
        }
    }
    
    @IBAction func back() {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
}