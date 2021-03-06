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
    var myTournamentID : String? = "";
    var myAmount : Int? = 0;

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
    
    
    /**
     * Sends GET request to the API server to verify login
     * credentials, as well as another GET request that receives
     * payment information in regards to the tournament specific
     * costs.
     * 
     * Also sends user feedback if payment is completed successfully
     * or not. 
     *
     * @param sender The sending class
    */
    @IBAction func buyClicked(sender : AnyObject) {
        var tournament_id : String = String(myTournamentID!);
        var url = Constants.Base.allTournamentsURL+tournament_id;
        
        if (self.myTournamentID == "") {
            return;
        }
        
        var verify_login_url = Constants.Base.verifyURL + username.text + "/" + password.text;
        println(verify_login_url);
        request.GET(verify_login_url, parameters: nil, success: {(response: HTTPResponse) in
            if let loginData = response.responseObject as? NSData {
                let loginJSON = NSJSONSerialization.JSONObjectWithData(loginData, options: nil, error: nil) as NSDictionary;
                
                if (loginJSON[Constants.JSON.verification] as? String == "success") {
                
                    self.request.GET(url, parameters: nil, success: {(response: HTTPResponse) in
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
                else {
                    return;
                }
                
            }
            },failure: {(error: NSError, response: HTTPResponse?) in
                println("error: \(error)");
        });
    }
    
    /**
     * View controller for the PayPal payment view. 
     * Verifies payments and dismisses view when
     * Payment is completed.
     *
     * @param completedPayment A PayPal payment
    */
    func payPalPaymentViewController(paymentViewController: PayPalPaymentViewController!, didCompletePayment completedPayment: PayPalPayment!) {
        self.verifyCompletedPayment(completedPayment);
        dispatch_async(dispatch_get_main_queue(), {
            self.dismissViewControllerAnimated(true, completion: nil);
        });
    }
    
    /**
     * On cancellation of a payment, the view controller is dismissed
     *
     * @param completedPayment A PayPal Payment View Controller
    */
    func payPalPaymentDidCancel(paymentViewController: PayPalPaymentViewController!) {
        dispatch_async(dispatch_get_main_queue(), {
            self.dismissViewControllerAnimated(true, completion: nil);
        });
    }
    
    /**
     * On confirmation of payment, sends details about payment back to the server
     * to be processed. Data sent includes user, tournament id, and payment amount
     *
     * @param completedPayment A PayPal payment
    */
    func verifyCompletedPayment(completedPayment: PayPalPayment) {
        var confirmation: NSDictionary = completedPayment.confirmation as NSDictionary;
        println(confirmation);
        var data : NSData = NSJSONSerialization.dataWithJSONObject(completedPayment.confirmation, options: nil, error: nil)!;
        
        var paypalData : Dictionary<String, AnyObject> = confirmation[Constants.Response.response] as Dictionary<String, AnyObject>;
        paypalData[Constants.JSON.user] = username.text;
        paypalData[Constants.JSON.tid] = myTournamentID;
        paypalData[Constants.JSON.netPay] = myAmount!;
        
        println(paypalData);
        request.requestSerializer = JSONRequestSerializer();

        request.POST(Constants.Base.registrationRegisterURL, parameters: paypalData, success: {(response: HTTPResponse) in
            },failure: {(error: NSError, response: HTTPResponse?) in
                println("There was an error in POSTing the JSON :(");
        });
    }
    
    @IBAction func back() {
        dispatch_async(dispatch_get_main_queue(), {
            self.dismissViewControllerAnimated(true, completion: nil);
        });
    }
}
