//
//  APICalls.swift
//  OnTheMap
//
//  Created by Manal  harbi on 13/03/1441 AH.
//  Copyright © 1441 Udasity. All rights reserved.
//

import Foundation


class APICalls {
    
  
    
    
    static func getAllLocations (completion: @escaping ([GetStudentLocation]?, Error?) -> ()) {
        
        
        var request = URLRequest (url: URL (string: "https://parse.udacity.com/parse/classes/StudentLocation?limit=100&order=-updatedAt")!)
        
        request.addValue("QrX47CA9cyuGewLdsL7o5Eb8iug6Em8ye0dnAbIr", forHTTPHeaderField: "X-Parse-Application-Id")
        
        request.addValue("QuWThTdiRmTux3YaDseUSEpUKo7aBYM737yKd4gY", forHTTPHeaderField: "X-Parse-REST-API-Key")
        
        let session = URLSession.shared
        let task = session.dataTask(with: request) { data, response, error in
            if error != nil {
            completion( nil , error)
            }

            
            guard let statusCode = (response as? HTTPURLResponse)?.statusCode else {
               
                let statusCodeError = NSError(domain: NSURLErrorDomain, code: 0, userInfo: nil)
                completion( nil , statusCodeError.localizedDescription as? Error)
                return
            }
            
            if statusCode >= 200 && statusCode < 300 {
                
                //Get an object based on the received data in JSON format
                let jsonObject = try! JSONSerialization.jsonObject(with: data!, options: [])
                
                //TODO: Convert jsonObject to a dictionary
                let jsonDict = try! jsonObject as! [String: Any]
                
                //TODO: get the locations (associated with the key “results") and store it into a constant named resultArray
                
                let resultsArray = try! jsonDict["results"] as? [[String:Any]]
                
                //Check if the result array is nil using guard let, if it's return, otherwise continue
                
                guard  resultsArray != nil else { return }
                
                //TODO: Convert the array above into a valid JSON Data object (so you can use that object to decode it into an array of student locations) and name it dataObject
                
                let dataObject = try! JSONSerialization.data(withJSONObject: resultsArray, options: .prettyPrinted)
                
                //Use JSONDecoder to convert dataObject to an array of structs
                let studentsLocations = try! JSONDecoder().decode([GetStudentLocation].self, from: dataObject)
               
                Global.shared.studentLocation = studentsLocations
                
                completion (studentsLocations, nil)
            }
        }
        
        task.resume()
    }
    
    
}
