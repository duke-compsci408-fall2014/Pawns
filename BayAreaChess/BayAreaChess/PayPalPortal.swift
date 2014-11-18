//
//  PayPalPortal.swift
//  BayAreaChess
//
//  Created by Carlos Reyes on 11/18/14.
//  Copyright (c) 2014 Bay Area Chess. All rights reserved.
//

import UIKit

class PalPalPortal: UIViewController, PayPalPaymentDelegate {
    var config = PayPalConfiguration()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true);
        PayPalMobile.preconnectWithEnvironment(PayPalEnvironmentNoNetwork)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    @IBAction func buyClicked(sender : AnyObject) {
        let amount = NSDecimalNumber(string: "10.00");
        
        println("amount \(amount)")
        
        var payment = PayPalPayment()
        payment.amount = amount
        payment.currencyCode = "USD"
        payment.shortDescription = "Registration Payment"
        
        if (!payment.processable) {
            println("Failed to Enter PayPal")
        } else {
            println("Success")
            var paymentViewController = PayPalPaymentViewController(payment: payment, configuration: config, delegate: self)
            self.presentViewController(paymentViewController, animated: true, completion: nil)
        }
    }
    
    func payPalPaymentViewController(paymentViewController: PayPalPaymentViewController!, didCompletePayment completedPayment: PayPalPayment!) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func payPalPaymentDidCancel(paymentViewController: PayPalPaymentViewController!) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func back() {
        dismissViewControllerAnimated(true, completion: nil)
    }
}
