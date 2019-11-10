//
//  ResponseLocation.swift
//  OnTheMap
//
//  Created by Manal  harbi on 09/03/1441 AH.
//  Copyright © 1441 Udasity. All rights reserved.
//

import Foundation


struct GetStudentLocation : Codable , Equatable {
   
    var createdAt : String
    var firstName: String
    var lastName: String
    var latitude: Double
    var longitude: Double
    var mapString: [String]
    var mediaURL: String
    var objectId: String
    var uniqueKey : Int
    var updatedAt : String
    
    
    
}

