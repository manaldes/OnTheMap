//
//  ResponseLocation.swift
//  OnTheMap
//
//  Created by Manal  harbi on 09/03/1441 AH.
//  Copyright © 1441 Udasity. All rights reserved.
//

import Foundation


struct GetStudentLocation : Codable , Equatable {
   
    static var lastFetched: [GetStudentLocation]?
    
    var createdAt : String?
    var firstName: String?
    var lastName: String?
    var latitude: Double?
    var longitude: Double?
    var mapString: String?
    var mediaURL: String?
    var objectId: String?
    var uniqueKey : String?
    var updatedAt : String?
    
    
    init ( createdAt:String? = nil , firstName: String? = nil , lastName: String? = nil ,
          latitude: Double? = 0.0 , longitude: Double? = 0.0 , mapString: String? = nil ,  mediaURL: String? = nil, objectId: String? = nil ,  uniqueKey : String? = nil , updatedAt : String? = nil ) {
        
        
        self.createdAt = createdAt
        self.firstName = firstName
        self.lastName = lastName
        self.latitude = latitude
        self.longitude = longitude
        self.mapString = mapString
        self.mediaURL = mediaURL
        self.objectId = objectId
        self.uniqueKey = uniqueKey
        self.updatedAt = updatedAt
        
        
    }
    
    
}

