//
//  Global.swift
//  OnTheMap
//
//  Created by Manal  harbi on 15/03/1441 AH.
//  Copyright © 1441 Udasity. All rights reserved.
//

import Foundation
import UIKit


class Global   {
    
    static let shared = Global()
    
    var studentLocation : [GetStudentLocation]?
    
    
    static func showeAlert(viewController: UIViewController, title: String, message: String) {
        DispatchQueue.main.async {
            let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
            let action = UIAlertAction(title: "OK", style: .default, handler: nil)
            alert.addAction(action)
            viewController.present(alert, animated: true, completion: nil)
        }
        
        
    }
}


