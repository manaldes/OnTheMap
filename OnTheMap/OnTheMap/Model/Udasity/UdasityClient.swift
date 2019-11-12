//
//  UdasituClient.swift
//  OnTheMap
//
//  Created by Manal  harbi on 10/03/1441 AH.
//  Copyright © 1441 Udasity. All rights reserved.
//

import Foundation


class UdasityClient {


class func PostSession(username: String, password: String, completionHandler: @escaping (PostSession?, String?) -> Void) {
    
     var request = URLRequest(url: URL(string: "https://onthemap-api.udacity.com/v1/session")!)
     request.httpMethod = "POST"
     request.addValue("application/json", forHTTPHeaderField: "Accept")
     request.addValue("application/json", forHTTPHeaderField: "Content-Type")
     // encoding a JSON body from a string, can also use a Codable struct
     request.httpBody = "{\"udacity\": {\"username\": \"account@domain.com\", \"password\": \"********\"}}".data(using: .utf8)
     let session = URLSession.shared
     let task = session.dataTask(with: request) { data, response, error in
    if error != nil {
        completionHandler( nil , "Ther is an error")
        return
    }
    let range = (5..<data!.count)
    let newData = data?.subdata(in: range)
      
        let jsonObject = try! JSONSerialization.jsonObject(with: newData!, options: [])
        
        let  loginDictionary = jsonObject as! [String: Any]
        
        //Get the unique key of the user
        let accountDictionary = loginDictionary ["account"] as? [String : Any]
        let uniqueKey = accountDictionary? ["key"] as? String ?? " "

        //completion(uniqueKey , )
        
        
    print(String(data: newData!, encoding: .utf8)!)
    }
    
    
    task.resume()

}



    class func DeleteSession(username: String, password: String, completionHandler: @escaping (PostSession?, String?) -> Void) {
    
        var request = URLRequest(url: URL(string: "https://onthemap-api.udacity.com/v1/session")!)
    
        request.httpMethod = "DELETE"
  
        var xsrfCookie: HTTPCookie? = nil
    
        let sharedCookieStorage = HTTPCookieStorage.shared
    
        for cookie in sharedCookieStorage.cookies! {
        if cookie.name == "XSRF-TOKEN" { xsrfCookie = cookie }
   
        }
   
        if let xsrfCookie = xsrfCookie {
        request.setValue(xsrfCookie.value, forHTTPHeaderField: "X-XSRF-TOKEN")
  
        }
   
        let session = URLSession.shared
   
        let task = session.dataTask(with: request) { data, response, error in
     
            if error != nil { // Handle error…
            return
       
            }
       
            let range = (5..<data!.count)
        
            let newData = data?.subdata(in: range) /* subset response data! */
       
            print(String(data: newData!, encoding: .utf8)!)
   
        }
   
        task.resume()
    

    }

}
