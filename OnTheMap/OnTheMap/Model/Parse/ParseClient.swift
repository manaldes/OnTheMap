//
//  ParseClient.swift
//  OnTheMap
//
//  Created by Manal  harbi on 10/03/1441 AH.
//  Copyright © 1441 Udasity. All rights reserved.
//

import Foundation

class  ParseClient {
    
   
    private static let EndPointbase = "https://onthemap-api.udacity.com/v1/StudentLocation"
     static  var studentLocations: [GetStudentLocation]?
    
    
    class func getLocation(completionHandler: @escaping ([GetStudentLocation]?, String?) -> Void) {
        
        var request = URLRequest(url: URL(string: "https://onthemap-api.udacity.com/v1/StudentLocation?order=-updatedAt")!)
        let session = URLSession.shared
        let task = session.dataTask(with: request) { data, response, error in
            
            if error != nil {
                completionHandler(nil , "There was an error getting location.")
                return
            }
            else {
                if let user = response?[GetStudentLocation.self] as? NSDictionary {
                    if let userFirstName = user[GetStudentLocation.firstName] as? String, let userLastName = user[GetStudentLocation.lastName] as? String {
                       GetStudentLocation.firstName = userFirstName
                        GetStudentLocation.lastName = userLastName
                        completionHandler( [] , nil)
                    }
                }
            }
            print(String(data: data!, encoding: .utf8)!)
        }
        task.resume()
    }
    
    
    
    class func postLocation(completion: @escaping ([PostStudentLocation]? , Error?) -> Void) {
        
        let urlString = "https://onthemap-api.udacity.com/v1/StudentLocation/8ZExGR5uX8"
        let url = URL(string: urlString)
        var request = URLRequest(url: url!)
        request.httpMethod = "PUT"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = "{\"uniqueKey\": \"1234\", \"firstName\": \"John\", \"lastName\": \"Doe\",\"mapString\": \"Cupertino, CA\", \"mediaURL\": \"https://udacity.com\",\"latitude\": 37.322998, \"longitude\": -122.032182}".data(using: .utf8)
        let session = URLSession.shared
        let task = session.dataTask(with: request) { data, response, error in
            if error != nil { // Handle error…
                return
            }
            print(String(data: data!, encoding: .utf8)!)
        }
        task.resume()
    }
    

    
    class func putLocation (completion: @escaping ([PutStudentLocation]? , Error?) -> Void) {
        
        let urlString = "https://onthemap-api.udacity.com/v1/StudentLocation/8ZExGR5uX8"
        let url = URL(string: urlString)
        var request = URLRequest(url: url!)
        request.httpMethod = "PUT"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = "{\"uniqueKey\": \"1234\", \"firstName\": \"John\", \"lastName\": \"Doe\",\"mapString\": \"Cupertino, CA\", \"mediaURL\": \"https://udacity.com\",\"latitude\": 37.322998, \"longitude\": -122.032182}".data(using: .utf8)
        let session = URLSession.shared
        let task = session.dataTask(with: request) { data, response, error in
            if error != nil { // Handle error…
                return
            }
            print(String(data: data!, encoding: .utf8)!)
        }
        task.resume()
        
    }
    
}
