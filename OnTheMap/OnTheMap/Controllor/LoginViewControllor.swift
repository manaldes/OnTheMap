//
//  LoginViewControllor.swift
//  OnTheMap
//
//  Created by Manal  harbi on 09/03/1441 AH.
//  Copyright © 1441 Udasity. All rights reserved.
//

import Foundation
import UIKit

class loginViewControllor : UIViewController {
    
    
    
    @IBOutlet weak var EmailField: UITextField!
    
    @IBOutlet weak var PasswordField: UITextField!
    
    @IBOutlet weak var LoginButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        EmailField.text = "Email"
        PasswordField.text = " Password"
    }
    
    @IBAction func LoginButton(_ sender: UIButton) {
        
        let username = EmailField.text
        let password = PasswordField.text
        
        if (username!.isEmpty) || (password!.isEmpty) {
            
            let requiredInfoAlert = UIAlertController (title: "Fill the required fields", message: "Please fill both the email and password", preferredStyle: .alert)
            
            requiredInfoAlert.addAction(UIAlertAction (title: "OK", style: .default, handler: { _ in
                return
            }))
            
            self.present (requiredInfoAlert, animated: true, completion: nil)
            
        } else {
            
            APICalls.login(username, password){(loginSuccess, key, error) in
                //TODO: Execute the entire code inside the completion body on the main thread asynchronous
                if error != nil {
                    let errorAlert = UIAlertController(title: "Erorr performing request", message: "There was an error performing your request", preferredStyle: .alert )
                    
                    errorAlert.addAction(UIAlertAction (title: "OK", style: .default, handler: { _ in
                        return
                    }))
                    self.present(errorAlert, animated: true, completion: nil)
                    return
                }
                
                if !loginSuccess {
                    let loginAlert = UIAlertController(title: "Erorr logging in", message: "incorrect email or password", preferredStyle: .alert )
                    
                    loginAlert.addAction(UIAlertAction (title: "OK", style: .default, handler: { _ in
                        return
                    }))
                    self.present(loginAlert, animated: true, completion: nil)
                } else {
                    let controller = self.storyboard?.instantiateViewController(withIdentifier: "MapViewController") as! MapViewController
                    self.navigationController!.pushViewController(controller, animated: true)
                    //In on the map, you need to use the key to call a function in the API class to get the user's first name and last name, but here we're just printing the key. So, in your app, instead of printing it, you'll call that function and be passing it as an argument to that function.
                    
                    
                    print ("the key is \(key)")
                }
            }
        }

    }
    
}
