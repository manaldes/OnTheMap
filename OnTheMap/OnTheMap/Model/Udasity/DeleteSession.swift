//
//  DeleteSession.swift
//  OnTheMap
//
//  Created by Manal  harbi on 13/03/1441 AH.
//  Copyright © 1441 Udasity. All rights reserved.
//

import Foundation

struct deleteSession : Codable {
   
    var session : session
    
    struct  session : Codable {
        var id : Int?
        var expiration : String?
    }
}
