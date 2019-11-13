//
//  ContainerViewControllor.swift
//  OnTheMap
//
//  Created by Manal  harbi on 15/03/1441 AH.
//  Copyright © 1441 Udasity. All rights reserved.
//

import Foundation
import UIKit

class ContainerViewControllor : UIViewController {
    
    @IBAction func AddPinButton(_ sender: Any) {
        
        // Create the alert controller
        let alertController = UIAlertController(title: "", message: "You have already posted a student location . would you like to overwrite your current location ?", preferredStyle: .alert)
        
        // Create the actions
        let okAction = UIAlertAction(title: "Overwrite", style: UIAlertAction.Style.default) {
            UIAlertAction in
            NSLog("OK Pressed")
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel) {
            UIAlertAction in
            NSLog("Cancel Pressed")
        }
        
        // Add the actions
        alertController.addAction(okAction)
        alertController.addAction(cancelAction)
        
        // Present the controller
        self.present(alertController, animated: true, completion: nil)
        
    }

    func setupUI () {
        
    }
    
    @IBAction func Logout(_ sender: Any) {
       
        // Create the alert controller
        let alertController2 = UIAlertController(title: "", message: "Are you sure to logout ?", preferredStyle: .alert)
        
        // Create the actions
        let okAction2 = UIAlertAction(title: "Yes", style: UIAlertAction.Style.default) {
            UIAlertAction in
            NSLog("OK Pressed")
        }
        let cancelAction2 = UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel) {
            UIAlertAction in
            NSLog("Cancel Pressed")
        }
         alertController2.addAction(okAction2)
         alertController2.addAction(cancelAction2)
            
        self.present(alertController2, animated: true, completion: nil)
            
            
            
        UdasityClient.DeleteSession { (error) in
           
            guard error != nil else {
                
                alertController2.addAction(UIAlertAction(title: "There is an error to logout  ", style: .default, handler: nil ))
                self.present(alertController2 , animated: true , completion: nil)

                return
            }
            
            
            DispatchQueue.main.async {
                self.dismiss(animated: true, completion: nil)

            }
    }
    
    } // end logout
    
    
}

    
    

