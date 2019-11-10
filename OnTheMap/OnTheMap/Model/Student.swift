//
//  GETtingLocation.swift
//  OnTheMap
//
//  Created by Manal  harbi on 09/03/1441 AH.
//  Copyright © 1441 Udasity. All rights reserved.
//

import Foundation


class  GETtingLocation {

    
    enum Endpoints {
        static let base = "https://onthemap-api.udacity.com/v1/StudentLocation"
        
        case getLocation
        case login
        case PostLocation
        case PutLocation
        case createSessionId
        case postSession
        case deleteSession
        case getBublicUserData
        
        
        var stringValue: String {
            switch self {
                
            case .getLocation: return Endpoints.base + "/account/\(Auth.accountId)/watchlist/movies" + Endpoints.apiKeyParam + "&session_id=\(Auth.sessionId)"
                
            case .login
                return Endpoints.base + "/authentication/token/validate_with_login" + 

            case .PostLocation
                
             case .PutLocation
                
            case .createSessionId
                return Endpoints.base + "/authentication/session/new" + Endpoints.apiKeyParam

                case .postSession
                
                case .deleteSession
                
                case .getBublicUserData

            }
        }
        
        var url: URL {
            return URL(string: stringValue)!
        }
    }
    
    
  class func getLocation(completion: @escaping (studentLocation , Error?) -> Void) {
    
    var request = URLRequest(url: URL(string: "https://onthemap-api.udacity.com/v1/StudentLocation?order=-updatedAt")!)
    let session = URLSession.shared
    let task = session.dataTask(with: request) { data, response, error in
        if error != nil {
            completion( [] , false)
            return
        }
        print(String(data: data!, encoding: .utf8)!)
    }
    task.resume()
}



class func postLocation(completion: @escaping (studentLocation , Error?) -> Void) {
    
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



class func login(username: String, password: String, completion: @escaping (Bool, Error?) -> Void) {
    let body = LoginRequest(username: username, password: password, requestToken: Auth.requestToken)
    taskForPOSTRequest(url: Endpoints.login.url, responseType: RequestTokenResponse.self, body: body) { response, error in
        if let response = response {
            Auth.requestToken = response.requestToken
            completion(true, nil)
        } else {
            completion(false, error)
        }
    }
}




    class func putLocation (completion: @escaping (studentLocation , Error?) -> Void) {
    
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
