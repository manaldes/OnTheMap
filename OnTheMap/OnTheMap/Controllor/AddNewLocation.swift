//
//  AddNewLocation.swift
//  OnTheMap
//
//  Created by Manal  harbi on 13/03/1441 AH.
//  Copyright © 1441 Udasity. All rights reserved.
//

import Foundation
import UIKit


class  AddNewLocation: UIViewController , UITextFieldDelegate{
    
  
    @IBOutlet weak var PikerView: UIPickerView!
    
    @IBOutlet weak var LinkTextField: UITextField!
    @IBOutlet weak var locationTextField: UITextField!
    
    
    
    override func viewWillAppear(_ animated: Bool) {
       super.viewWillAppear(animated)
    }
    
    @IBAction func CancelButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
        
    }
    
    @IBAction func submitButton(_ sender: Any) {
        
        
    }
    
    @IBAction func findLocationButton(_ sender: Any) {
        
        if ( locationTextField.text == nil) {
           
            let errorAlert = UIAlertController(title: "Location Text Field Empty", message: "You must enter your location ", preferredStyle: .alert )
            
            errorAlert.addAction(UIAlertAction (title: "OK", style: .default, handler: { _ in
                return
            }))
            self.present(errorAlert, animated: true, completion: nil)

        }
        
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
       locationTextField.resignFirstResponder()
        return true
    }
    
}
