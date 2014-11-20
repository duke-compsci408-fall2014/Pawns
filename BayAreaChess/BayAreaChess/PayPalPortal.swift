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
    var myAmount : Int? = 0;
    let URL : String = "http://bac.colab.duke.edu:3000/api/v1/registration/register/"
    var base_url : String = "http://bac.colab.duke.edu:3000/api/v1/tournaments/all/";

    @IBOutlet var username : UITextField!;
    @IBOutlet var password : UITextField!;
    
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
                
                let amount = NSDecimalNumber(integer: self.myAmount!);
                var payment = PayPalPayment();
                payment.amount = amount;
                payment.currencyCode = "USD";
                payment.shortDescription = "Registration Payment";
        
                if (!payment.processable) {
                    println("Failed to Enter PayPal");
                } else {
                    println("Success");
                    var paymentViewController = PayPalPaymentViewController(payment: payment, configuration: self.config, delegate: self);
                    dispatch_async(dispatch_get_main_queue(), {
                        self.presentViewController(paymentViewController, animated: true, completion: nil);
                    });
                }
            }
            },failure: {(error: NSError, response: HTTPResponse?) in
                println("error: \(error)");
            });
    }
    
    func payPalPaymentViewController(paymentViewController: PayPalPaymentViewController!, didCompletePayment completedPayment: PayPalPayment!) {
        self.verifyCompletedPayment(completedPayment);
        dispatch_async(dispatch_get_main_queue(), {
            self.dismissViewControllerAnimated(true, completion: nil);
        });
    }
    
    func payPalPaymentDidCancel(paymentViewController: PayPalPaymentViewController!) {
        dispatch_async(dispatch_get_main_queue(), {
            self.dismissViewControllerAnimated(true, completion: nil);
        });
    }
    
    func verifyCompletedPayment(completedPayment: PayPalPayment) {
        var confirmation: NSDictionary = completedPayment.confirmation as NSDictionary;
        println(confirmation);
        var data : NSData = NSJSONSerialization.dataWithJSONObject(completedPayment.confirmation, options: nil, error: nil)!;
        
        var paypalData : Dictionary<String, AnyObject> = confirmation["response"] as Dictionary<String, AnyObject>;
        paypalData["username"] = username.text;
        paypalData["tournament_id"] = myTournamentID;
        paypalData["net_pay"] = myAmount!;
        
        println(paypalData);
        request.requestSerializer = JSONRequestSerializer();

        request.POST(URL, parameters: paypalData, success: {(response: HTTPResponse) in
            },failure: {(error: NSError, response: HTTPResponse?) in
                println("There was an error in POSTing the stuff :(");
        });
        
        
    }
    
    @IBAction func back() {
        dispatch_async(dispatch_get_main_queue(), {
            self.dismissViewControllerAnimated(true, completion: nil);
        });
    }
}
