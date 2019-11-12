//
//  ParseClient.swift
//  OnTheMap
//
//  Created by Manal  harbi on 10/03/1441 AH.
//  Copyright © 1441 Udasity. All rights reserved.
//

import Foundation

class  ParseClient {
   
    class func getLocation(completionHandler: @escaping ([GetStudentLocation]?, Error?) -> () ) {
        
        let request = URLRequest(url: URL(string: "https://onthemap-api.udacity.com/v1/StudentLocation?order=-updatedAt")!)
        
        
        let session = URLSession.shared
        let task = session.dataTask(with: request) { data, response, error in
            
            if error != nil {
                completionHandler(nil , error)
                return
            }
            else {
              
                let dict = try! JSONSerialization.jsonObject(with: data!, options: []) as! [String:Any]
                
                guard let result = dict["results"] as? [[String:Any]] else { return }
                
                let resulsData = try! JSONSerialization.data(withJSONObject: result, options: .prettyPrinted)
                let studentLocation = try! JSONDecoder().decode([GetStudentLocation].self , from: resulsData)

                Global.shared.studentLocation = studentLocation
                
                completionHandler( [] , nil)
                }
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
            
            
            if error != nil {
                completion( nil , error)
                return
            }
            
            
            print(String(data: data!, encoding: .utf8)!)
            
            let dict = try! JSONSerialization.jsonObject(with: data!, options: []) as! [String:Any]
            
            guard let result = dict["results"] as? [[String:Any]] else { return }
            
            let resulsData = try! JSONSerialization.data(withJSONObject: result, options: .prettyPrinted)
            let studentLocation = try! JSONDecoder().decode([PostStudentLocation].self , from: resulsData)
            
            //Global.shared.studentLocation = studentLocation
            
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
            if error != nil {
                completion(nil , error)
                return
            }
            print(String(data: data!, encoding: .utf8)!)
            
            let dict = try! JSONSerialization.jsonObject(with: data!, options: []) as! [String:Any]
            
            guard let result = dict["results"] as? [[String:Any]] else { return }
            
            let resulsData = try! JSONSerialization.data(withJSONObject: result, options: .prettyPrinted)
            let studentLocation = try! JSONDecoder().decode([PutStudentLocation].self , from: resulsData)
            
            //Global.shared.studentLocation = studentLocation
        }
        task.resume()
        
    }
    
}
