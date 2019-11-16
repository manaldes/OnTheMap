//
//  UdasituClient.swift
//  OnTheMap
//
//  Created by Manal  harbi on 10/03/1441 AH.
//  Copyright © 1441 Udasity. All rights reserved.
//

import Foundation


class UdasityClient {

    static var uniqueKey :String?
    static var registred : Bool = true

    
    static var firstname = ""
    static var lastname = ""
    static var mediaURL = ""
    static var latitude = 0.0
    static var longitude = 0.0
    static var mapString = ""
    
    class func PostSession(username: String, password: String, completionHandler: @escaping (_ errorMessage: String?) -> Void) {
    
     var request = URLRequest(url: URL(string: "https://onthemap-api.udacity.com/v1/session")!)
     request.httpMethod = "POST"
     request.addValue("application/json", forHTTPHeaderField: "Accept")
     request.addValue("application/json", forHTTPHeaderField: "Content-Type")
     
        // encoding a JSON body from a string, can also use a Codable struct
     request.httpBody = "{\"udacity\": {\"username\": \"\(username)\", \"password\": \"\(password)\"}}".data(using: .utf8)
        
     let session = URLSession.shared
     let task = session.dataTask(with: request) { data, response, error in
   
        if error != nil {
        completionHandler( "Ther is an error")
        return
            
        }
        guard let statusCode = (response as? HTTPURLResponse)?.statusCode else {
            let statusCodeError = NSError(domain: NSURLErrorDomain, code: 0, userInfo: nil)
            
            completionHandler(statusCodeError.localizedDescription )
            return
        }
        
        guard statusCode >= 200  && statusCode < 300 else {
            completionHandler("There is an error check the server ")
            return
        }
        
        
        let subData = data![5..<data!.count]
        
        print (String(data: subData, encoding: .utf8)!)
        
        
    
        //let jsonObject = try! JSONSerialization.jsonObject(with: subData, options: [])
        

        do {
        
            
        let jsonDecode = JSONDecoder()
            
        let jsonObject = try jsonDecode.decode(postSession.self , from: subData)
        
        let accountID = jsonObject.account.Key
        let accountRegistered = jsonObject.account.registered
        let sessionID = jsonObject.session.id
        let sessionExp = jsonObject.session.expiration
        
        
            self.uniqueKey = accountID ?? ""
            
            
            // self.userInfo.key =  accountID
                
            completionHandler(nil)
            
            print("The login is done successfuly!")
            
            
        } catch {
           
            completionHandler(error.localizedDescription)
            print("catch error ")
            return
        }
        
        }
        
        task.resume()
    }





    class func DeleteSession(completionHandler: @escaping ( _ errorMessage: String?) -> Void) {
    
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
     
            if error != nil {
                print(" error task ")
                completionHandler(error?.localizedDescription )
            return
       
            }
       
            guard let data = data else {
                print("there is no data")
                return
            }
            
            let newData = data[5..<data.count]
       
            print(String(data: newData, encoding: .utf8)!)
            
            do {
                
                let decoder = JSONDecoder()
                let studentLocation = try decoder.decode( Session.self , from: newData)
                
                completionHandler (nil)
           
            } catch {
                print("catch error")
                completionHandler(error.localizedDescription)
                return
            }
            
            
            
   
        }
   
        task.resume()
    

    }

}
