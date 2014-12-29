//
//  Utils.swift
//  BayAreaChess
//
//  Created by Carlos Reyes on 11/13/14.
//  Copyright (c) 2014 Bay Area Chess. All rights reserved.
//

import Foundation

class Utils {
    
    /**
     *  Safely returns field value from JSON object.
     *
     *  @param input The JSON to be parsed, of type NSDictionary
     *  @param field The key to be used to retrieve a field
     *  @return The value associated with the key, returns "" if not found
    */
    class func getFieldFromJSON (input : NSDictionary, field : String) -> String {
        var tournamentData : String! = "";
        if ((input[field] as? String) != nil) {
            tournamentData = input[field] as String;
        }
        return tournamentData;
    }
    
    /**
     *  Safely returns field value from list
     *
     *  @param input The list to be searched through, of type NSArray
     *  @param field The key to be used to retrieve a field
     *  @return The value associated with the key, returns "" if not found
    */
    class func getFieldFromList (input : NSArray, field : String) -> String {
        var tournamentData : String! = "";
        let json : Array = input as [AnyObject];
        for (index, element) in enumerate(json) {
            var name : String = element[field] as String
            tournamentData = name;
        }
        return tournamentData;
    }
    
    /**
     *  Safely returns String array from NSArray
     *
     *  @param input The array, of type NSArray
     *  @param field The key to be used to retrieve a field
     *  @return The value associated with the key, returns empty array if not found
    */
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
    
    class func getListFromSubJSON (input : NSArray, fieldOne : String, fieldTwo : String, fieldThree : String) -> [String] {
        var tournamentData = [String]();
        let json : Array = input as [AnyObject];
        for (index, element) in enumerate(json) {
            if ((element[fieldOne] as? NSDictionary) != nil) {
                var item : NSDictionary! = element[fieldOne] as NSDictionary!;
                var date : String = "";
                if ((item[fieldTwo] as String?) != nil) {
                    date = item[fieldTwo] as String;
                }
                else if ((item[fieldThree] as String?) != nil) {
                    date = item[fieldThree] as String;
                }
                tournamentData.append(date);
            }
        }
        return tournamentData;
    }
    
    /**
     *  Safely returns Int array from NSArray
     *
     *  @param input The array, of type NSArray
     *  @param field The key to be used to retrieve a field
     *  @return The value associated with the key, returns empty array if not found
    */
    class func getIntArrayFromJSON (input : NSArray, field : String) -> [Int] {

        var tournamentData = [Int]();
        let json : Array = input as [AnyObject];
        for (index, element) in enumerate(json) {
            if ((element[field] as? Int) != nil) {
                var num : Int = element[field] as Int;
                tournamentData.append(num);
            }
        }
        return tournamentData;
    }
}