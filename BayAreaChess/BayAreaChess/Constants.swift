//
//  Constants.swift
//  BayAreaChess
//
//  Created by Carlos Reyes on 11/20/14.
//  Copyright (c) 2014 Bay Area Chess. All rights reserved.
//

import Foundation

class Constants {
    struct Base {
        static let baseURL = "http://bac.colab.duke.edu:3000/api/v1/";
        static let login = "login";
        static let update = "update";
        static let verify = "verify";
        static let tournaments = "tournaments";
        static let all = "all";
        static let registration = "registration";
        static let register = "registration";
    }
    struct JSON {
        static let user = "username";
        static let pass = "password";
        static let name = "name";
        static let description = "description";
        static let amount = "amount";
        static let date = "date_play";
        static let verification = "verification";
        static let failure = "failure";
        static let success = "success";
        static let dateFormat = "dd-MM-yyyy";
        static let tid = "tournament_id";
    }
    struct Response {
        static let recieved = "didReceiveResponse";
        static let login = "login";
    }
    struct Gravatar {
        static let gravitarURL = "http://www.gravatar.com/avatar/";
        static let size = "?s=120";
        static let hash = "gravatar_hash";
    }
}