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
        static let loginURL = baseURL+login+"/";
        static let verifyURL = loginURL+verify+"/";
        static let registerURL = loginURL+register+"/";
        static let updateURL = loginURL+update+"/";
        static let tournamentsURL = baseURL+tournaments+"/";
        static let allTournamentsURL = tournamentsURL+general+"/";
        static let registrationURL = baseURL+registration+"/";
        static let registrationRegisterURL = registrationURL+register+"/";
        static let login = "login";
        static let update = "update";
        static let verify = "verify";
        static let register = "register";
        static let tournaments = "tournaments";
        static let general = "general";
        static let registration = "registration";
    }
    struct JSON {
        static let user = "username";
        static let pass = "password";
        static let name = "name";
        static let summary = "summary";
        static let description = "description";
        static let amount = "amount";
        static let date = "date_play";
        static let verification = "verification";
        static let failure = "failure";
        static let success = "success";
        static let dateFormat = "dd-MM-yyyy";
        static let tid = "tournament_id";
        static let firstName = "first_name";
        static let lastName = "last_name";
        static let phone = "main_phone";
        static let email = "email";
        static let address = "address";
        static let city = "city";
        static let state = "state";
        static let id = "id";
        static let startTime = "start_time";
        static let netPay = "net_pay";
        static let start = "start";
        static let subDate = "date";
        static let dateTime = "dateTime";
        static let location = "location";
//        static let chessID = "uscf_id";
    }
    struct Response {
        static let recieved = "didReceiveResponse";
        static let deiniting = "deiniting";
        static let response = "response";
    }
    struct Gravatar {
        static let URL = "http://www.gravatar.com/avatar/";
        static let size = "?s=120";
        static let hash = "gravatar_hash";
    }
    struct Images {
        static let home = "home.png";
        static let tournaments = "tournaments.png";
        static let about = "about.png";
        static let settings = "settings.png";
        
        static let homeicon = "home2-icon.png";
        static let homeicon2 = "home1s-icon.png";
        static let tournamentsicon = "tournaments-icon.png";
        static let abouticon = "about-icon.png";
        static let settingsicon1 = "setting1-icon.png";
        static let settingsicon = "setting2-icon.png";
        
        static let aboutlarge = "about-icon-bgtransparent.png"
        static let homelarge = "home-icon-bgtransparent.png"
        static let homelarge2 = "home2-icon-bgtransparent.png"
        static let settinglarge = "setting1-icon-bgtransparent.png"
        static let settinglarge2 = "setting2-icon-bgtransparent.png"
        static let tournamentslarge = "tournaments-icon-bgtransparent.png"

    }
    struct Label {
        static let user = "Username";
        static let pass = "Password";
        static let rejected = "Rejected!";
        static let firstNmae  = "First Name";
        static let lastName = "Last Name";
        static let email = "Email";
        static let phone = "Phone Number";
    }
    struct Identifier {
        static let cell = "cell";
        static let selectEvent = "selectEvent";
        static let checkout = "checkout";
    };
}