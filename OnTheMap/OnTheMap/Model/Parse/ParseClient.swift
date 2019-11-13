//
//  ParseClient.swift
//  OnTheMap
//
//  Created by Manal  harbi on 10/03/1441 AH.
//  Copyright © 1441 Udasity. All rights reserved.
//

import Foundation

class  ParseClient {
   
    class func getLocation(completionHandler: @escaping (_ errorMessage : String? ) -> () ) {
        
        let request = URLRequest(url: URL(string: "https://onthemap-api.udacity.com/v1/StudentLocation?order=-updatedAt&limit=100")!)
        
        
        let session = URLSession.shared
        let task = session.dataTask(with: request) { data, response, error in
            
            if error != nil {
                completionHandler("There is an error ")
                return
            }
            else {
              
                
                let jsonObject = try! JSONSerialization.jsonObject(with: data!, options: [])
                
                let loginDictionary = jsonObject as? [String: Any]
                
                guard let results = loginDictionary! ["results"] as? [String : Any] else {
                    
                    completionHandler("There is an error")
                    return
                }
                
   
                let resulsData = try! JSONSerialization.data(withJSONObject: results , options: .prettyPrinted)
                
                let studentLocation = try! JSONDecoder().decode([GetStudentLocation].self , from: resulsData)

            
                
                Global.shared.studentLocation = studentLocation
                
                completionHandler(nil)
                }
            }
        
            task.resume()
    }

    
    
    
    class func postLocation(_ student: GetStudentLocation , completion: @escaping (_ errorMessage : String?) -> Void) {
        
        let loginKey = UdasityClient.uniqueKey
        
        
        let jsonData: Data
        
        do {
            jsonData = try JSONEncoder().encode(student)
            
        } catch let error {
            print(error.localizedDescription)
            return
        }
        
        let urlString = "https://onthemap-api.udacity.com/v1/StudentLocation/8ZExGR5uX8"
        let url = URL(string: urlString)
        var request = URLRequest(url: url!)
        request.httpMethod = "PUT"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = "{\"uniqueKey\": \"\(loginKey)\", \"firstName\": \"\(UdasityClient.firstname)\", \"lastName\": \"\(UdasityClient.lastname)\",\"mapString\": \"\(UdasityClient.mapString)\", \"mediaURL\": \"\(UdasityClient.mediaURL)\",\"latitude\": \(UdasityClient.latitude), \"longitude\": \(UdasityClient.longitude)}".data(using: .utf8)
        
        
        let session = URLSession.shared
        let task = session.dataTask(with: request) { data, response, error in
            
            
            if error != nil {
                completion( error?.localizedDescription)
                return
            }
            
            
            print(String(data: data!, encoding: .utf8)!)
            
            let dict = try! JSONSerialization.jsonObject(with: data!, options: []) as! [String:Any]
            
            guard let result = dict["results"] as? [[String:Any]] else { return }
            
            let resulsData = try! JSONSerialization.data(withJSONObject: result, options: .prettyPrinted)
            let studentLocation = try! JSONDecoder().decode([GetStudentLocation].self , from: resulsData)
            
            completion(nil)
            
           Global.shared.studentLocation = studentLocation
            
        }
        task.resume()
        
        
    }
    

    
    class func putLocation (completion: @escaping (_ errorMessage : String?) -> Void) {
       
        let urlString = "https://onthemap-api.udacity.com/v1/StudentLocation/8ZExGR5uX8"
        let url = URL(string: urlString)
        var request = URLRequest(url: url!)
        request.httpMethod = "PUT"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = "{\"uniqueKey\": \"\(UdasityClient.uniqueKey)\", \"firstName\": \"\(UdasityClient.firstname)\", \"lastName\": \"\(UdasityClient.lastname)\",\"mapString\": \"\(UdasityClient.mapString)\", \"mediaURL\": \"\(UdasityClient.mediaURL)\",\"latitude\": \(UdasityClient.latitude), \"longitude\": \(UdasityClient.longitude)}".data(using: .utf8)
       
        
        
        let session = URLSession.shared
        let task = session.dataTask(with: request) { data, response, error in
            if error != nil {
                completion(error?.localizedDescription)
                return
            }
            print(String(data: data!, encoding: .utf8)!)
            
            let dict = try! JSONSerialization.jsonObject(with: data!, options: []) as! [String:Any]
            
            guard let result = dict["results"] as? [String:Any] else { return }
            
            let resulsData = try! JSONSerialization.data(withJSONObject: result, options: .prettyPrinted)
            let studentLocation = try! JSONDecoder().decode([GetStudentLocation].self , from: resulsData)
            
            completion(nil)
            
            Global.shared.studentLocation = studentLocation
            
        }
        
        task.resume()
        
    }
    
}
