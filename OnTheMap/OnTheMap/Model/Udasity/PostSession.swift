//
//  PostSession.swift
//  OnTheMap
//
//  Created by Manal  harbi on 13/03/1441 AH.
//  Copyright © 1441 Udasity. All rights reserved.
//

import Foundation

struct postSession : Codable {
    
    var account : account
    var session : session


    struct account : Codable {
        var registered : Bool?
        var Key : String?
    }
    
    struct  session : Codable {
        var id : String?
        var expiration : String?
    }
}
