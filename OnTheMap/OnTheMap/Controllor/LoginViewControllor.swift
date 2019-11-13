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
        
        EmailField.text = ""
        PasswordField.text = ""
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
                    
                    //self.performSegue(withIdentifier: "loginSuccessSegueID", sender: self)
                    
                    self.updateUI(processing: false)
                    DispatchQueue.main.async {
                      
                        self.EmailField.text = ""
                        self.PasswordField.text = ""
                        
                        
                        self.performSegue(withIdentifier: "loginSuccessSegueID", sender: self)
                        
                    }

                    print ("the key is \(UdasityClient.uniqueKey)")
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
    
    
