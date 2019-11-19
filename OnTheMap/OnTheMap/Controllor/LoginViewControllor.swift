//
//  LoginViewControllor.swift
//  OnTheMap
//
//  Created by Manal  harbi on 09/03/1441 AH.
//  Copyright © 1441 Udasity. All rights reserved.
//

import Foundation
import UIKit
import MapKit

class loginViewControllor : UIViewController , MKMapViewDelegate   {
    
    
    
    @IBOutlet weak var EmailField: UITextField!
    @IBOutlet weak var PasswordField: UITextField!
    @IBOutlet weak var LoginButton: UIButton!
    
    
    
    var studentLocation : [GetStudentLocation]! {
       
        return Global.shared.studentLocation
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        EmailField.delegate = self
        PasswordField.delegate = self
        
        LoginButton.layer.cornerRadius = 6
        
   
    }
    

    
    @IBAction func LoginButton(_ sender: UIButton) {
        
        updateUI (processing: true )
        
        
        let username = EmailField.text
        let password = PasswordField.text
        
        
        if (username!.isEmpty ) || (password!.isEmpty )  {
    
            Global.showeAlert(viewController: self, title: "Fill the required fields", message: "Please fill both the email and password")
            
            self.updateUI(processing: false)
            
            return
        } else {
    
            
        UdasityClient.PostSession (username: username!, password: password!){( errorMessage ) in
                
                if errorMessage != nil {
                    
                    Global.showeAlert(viewController: self, title: "Erorr logging in", message: "incorrect email or password")
                    self.updateUI(processing: false)
                    
                } else {
                                    
                    self.updateUI(processing: false)
                   
                    DispatchQueue.main.async {
                      
                        self.EmailField.text = ""
                        self.PasswordField.text = ""
                        
                        
                        self.performSegue(withIdentifier: "loginSuccessSegueID", sender: self)
                        
                    }
                }
            }
        }

    } // end login button
    
    
    
    func updateUI (processing: Bool ){
        
        DispatchQueue.main.async {
            self.EmailField.isEnabled = !processing
            self.PasswordField.isEnabled = !processing
            self.LoginButton.isEnabled = !processing
        }
    }
    
    
    
}


extension loginViewControllor : UITextFieldDelegate {
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        EmailField.endEditing(true)
        PasswordField.endEditing(true)
        EmailField.resignFirstResponder()
        PasswordField.resignFirstResponder()
        
        
        if (textField == self.EmailField) {
            self.EmailField.becomeFirstResponder()
        } else if (textField == self.PasswordField) {
            self.PasswordField.becomeFirstResponder()
        }
        
        
        return true
    }
    
   
    
    
    @objc func keyboardWillShow(_ notification: Notification) {
        if keyboardHeight(notification) > 400 {
            view.frame.origin.y = -keyboardHeight(notification)
        }
    }
    
    @objc func keyboardWillHide(_ notification: Notification) {
        view.frame.origin.y = 0
    }
    
    func keyboardHeight(_ notification: Notification) -> CGFloat {
        let userInfo = (notification as NSNotification).userInfo
        let keyboardSize = userInfo![UIResponder.keyboardFrameEndUserInfoKey] as! NSValue
        return keyboardSize.cgRectValue.height
    }
    
    func resignIfFirstResponder(_ textField: UITextField) {
        if textField.isFirstResponder {
            textField.resignFirstResponder()
        }
    
    
    }
}
    
