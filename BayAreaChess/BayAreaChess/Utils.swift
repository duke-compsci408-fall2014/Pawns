//
//  Utils.swift
//  BayAreaChess
//
//  Created by Carlos Reyes on 11/13/14.
//  Copyright (c) 2014 Bay Area Chess. All rights reserved.
//

import Foundation

class Utils {
    
    class func getIntArray (input : NSArray, field : String) -> [Int] {
        var tournamentData = [Int]();
        let json : Array = input as [AnyObject];
        for (index, element) in enumerate(json) {
            var num : Int = element[field] as Int;
            tournamentData.append(num);
        }
        return tournamentData;
    }
    
    class func getFieldFromJSON (input : NSDictionary, field : String) -> String {
        var tournamentData : String! = "";
        if ((input[field] as? String) != nil) {
            tournamentData = input[field] as String;
        }
        return tournamentData;
    }
    
    class func getFieldFromList (input : NSArray, field : String) -> String {
        var tournamentData : String! = "";
        let json : Array = input as [AnyObject];
        for (index, element) in enumerate(json) {
            var name : String = element[field] as String
            tournamentData = name;
        }
        return tournamentData;
    }
    
    class func getListFromJSON (input : NSArray, field : String) -> [String] {
        var tournamentData = [String]();
        let json : Array = input as [AnyObject];
        for (index, element) in enumerate(json) {
            if ((element[field] as? String) != nil) {
                var name : String = element[field] as String;
                tournamentData.append(name);
            }
        }
        return tournamentData;
    }
    
    class func getIntArrayFromJSON (input : NSArray, field : String) -> [Int] {
        var tournamentData = [Int]();
        let json : Array = input as [AnyObject];
        for (index, element) in enumerate(json) {
            if ((element[field] as? String) != nil) {
                var num : Int = element[field] as Int;
                tournamentData.append(num);
            }
        }
        return tournamentData;
    }
}