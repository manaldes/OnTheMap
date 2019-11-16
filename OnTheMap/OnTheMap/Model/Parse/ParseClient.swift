//
//  ParseClient.swift
//  OnTheMap
//
//  Created by Manal  harbi on 10/03/1441 AH.
//  Copyright © 1441 Udasity. All rights reserved.
//

import Foundation

class  ParseClient {
   

    
    static func getLocations (completion: @escaping ([GetStudentLocation]?, Error?) -> ()) {
        
        
        let request = URLRequest (url: URL (string: "https://onthemap-api.udacity.com/v1/StudentLocation")!)
      
        let session = URLSession.shared
        
        let task = session.dataTask(with: request) { data, response, error in
            
            guard error == nil else {
                
                completion( nil , error)
                return
            }
            
            
            guard let statusCode = (response as? HTTPURLResponse)?.statusCode else {
                
                let statusCodeError = NSError(domain: NSURLErrorDomain, code: 0, userInfo: nil)
                completion( nil , statusCodeError.localizedDescription as? Error)
                return
            }
            
            if statusCode >= 200 && statusCode < 300 {
                
                let jsonObject = try! JSONSerialization.jsonObject(with: data!, options: [])
                let jsonDict = try! jsonObject as! [String: Any]
               
                
                let resultsArray = try! jsonDict["results"] as? [[String:Any]]
                guard  resultsArray != nil else { return }
            
                let dataObject = try! JSONSerialization.data(withJSONObject: resultsArray, options: .prettyPrinted)
                
                let studentsLocations = try! JSONDecoder().decode([GetStudentLocation].self, from: dataObject)
                
                Global.shared.studentLocation = studentsLocations
                
                completion (studentsLocations , nil)
            }
        }
        
        task.resume()
    
    
        
    }

    
    
    
    class func postLocation(_ student: GetStudentLocation , completion: @escaping (_ errorMessage : String?) -> Void) {
        
        
        let jsonData: Data
        
        do {
            
            jsonData = try JSONEncoder().encode(student)
            
        } catch let error {
            print(error.localizedDescription)
            return
        }
        
        let urlString = "https://onthemap-api.udacity.com/v1/StudentLocation"
        let url = URL(string: urlString)
        var request = URLRequest(url: url!)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
       
        request.httpBody = jsonData
            
        let session = URLSession.shared
        let task = session.dataTask(with: request) { data, response, error in
            
            
            if error != nil {
                completion( error?.localizedDescription)
                return
            }
            
            print(String(data: data!, encoding: .utf8)!)
           
            do {
                
            let studentLocation = try! JSONDecoder().decode(PostStudentLocation.self , from: data!)
            
                completion(nil)
                
            } catch {
                
               completion(" There is an error ")
                return
            }
 
        }
        task.resume()
        
        
    }
    

    
    class func putLocation ( mapString: String, mediaURL: String,
        latitude: Float, longitude: Float , completion: @escaping (_ errorMessage : String?) -> Void) {
       
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
