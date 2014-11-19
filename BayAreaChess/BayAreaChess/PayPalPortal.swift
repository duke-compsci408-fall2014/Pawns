//
//  PayPalPortal.swift
//  BayAreaChess
//
//  Created by Carlos Reyes on 11/18/14.
//  Copyright (c) 2014 Bay Area Chess. All rights reserved.
//

import UIKit

class PalPalPortal: UIViewController, PayPalPaymentDelegate {
    var config = PayPalConfiguration();
    var request = HTTPTask();
    var myTournamentID : Int? = -1;
    
    let URL : String = "http://bac.colab.duke.edu:3000/api/v1/registration/register/"
    
    var base_url : String = "http://bac.colab.duke.edu:3000/api/v1/tournaments/all/";

    
    override func viewDidLoad() {
        super.viewDidLoad();
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true);
        PayPalMobile.preconnectWithEnvironment(PayPalEnvironmentNoNetwork);
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning();
    }
    @IBAction func buyClicked(sender : AnyObject) {
        var tournament_id : String = String(myTournamentID!);
        var url = base_url+tournament_id;
        
        if (self.myTournamentID == -1) {
            return;
        }
        
        request.GET(url, parameters: nil, success: {(response: HTTPResponse) in
            if let data = response.responseObject as? NSData {

                let json = NSJSONSerialization.JSONObjectWithData(data, options: nil, error: nil) as NSDictionary;
                
//                var amount : int = dict.amount;
//                var email : String = dict.email;
                
                let amount = NSDecimalNumber(string: "10.00");
                var payment = PayPalPayment();
                payment.amount = amount;
                payment.currencyCode = "USD";
                payment.shortDescription = "Registration Payment";
        
                if (!payment.processable) {
                    println("Failed to Enter PayPal");
                } else {
                    println("Success");
                    var paymentViewController = PayPalPaymentViewController(payment: payment, configuration: self.config, delegate: self);
                    self.presentViewController(paymentViewController, animated: true, completion: nil);
                }
            }
            },failure: {(error: NSError, response: HTTPResponse?) in
                println("error: \(error)");
            });
    }
    
    func payPalPaymentViewController(paymentViewController: PayPalPaymentViewController!, didCompletePayment completedPayment: PayPalPayment!) {
        self.verifyCompletedPayment(completedPayment);
        self.dismissViewControllerAnimated(true, completion: nil);
    }
    
    func payPalPaymentDidCancel(paymentViewController: PayPalPaymentViewController!) {
        self.dismissViewControllerAnimated(true, completion: nil);
    }
    
    func verifyCompletedPayment(completedPayment: PayPalPayment) {
        var confirmation: NSDictionary = completedPayment.confirmation as NSDictionary;
        var data : NSData = NSJSONSerialization.dataWithJSONObject(completedPayment.confirmation, options: nil, error: nil)!;
        
//        var response : Dictionary<String, AnyObject> = confirmation["response"] as Dictionary<String, AnyObject>;
//        response["username"] = "czarlos";
//        response["tournament_id"] = myTournamentID;
//
//        request.POST(URL, parameters: response, success: {(response: HTTPResponse) in
//            },failure: {(error: NSError, response: HTTPResponse?) in
//                println("There was an error in POSTing the stuff :(");
//        });
        
        
    }
    
    @IBAction func back() {
        dismissViewControllerAnimated(true, completion: nil)
    }
}
