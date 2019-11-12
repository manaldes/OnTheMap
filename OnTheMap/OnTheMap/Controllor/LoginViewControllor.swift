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
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if ( studentLocation == nil ){
           reloadStudentLocation()
        } else {
            DispatchQueue.main.async {
                self.updateannotations()
            }
        }
    }
    
    @IBAction func LoginButton(_ sender: UIButton) {
        
        updateUI (processing: true )
        
        
        let username = EmailField.text
        let password = PasswordField.text
        
        
        guard (username!.isEmpty) || (password!.isEmpty)  else {
            
            let requiredInfoAlert = UIAlertController (title: "Fill the required fields", message: "Please fill both the email and password", preferredStyle: .alert)
            
            requiredInfoAlert.addAction(UIAlertAction (title: "OK", style: .default, handler: { _ in
                return
            }))
            
            self.present (requiredInfoAlert, animated: true, completion: nil)
            self.updateUI(processing: false)
            
            return
        }
    
            
            APICalls.login(username, password){(loginSuccess, key, error) in
                
                if error != nil {
                    let errorAlert = UIAlertController(title: "Erorr performing request", message: "There was an error performing your request", preferredStyle: .alert )
                    
                    errorAlert.addAction(UIAlertAction (title: "OK", style: .default, handler: { _ in
                        return
                    }))
                    self.present(errorAlert, animated: true, completion: nil)
                    self.updateUI(processing: false)
                    return
                    
                }
                
                if !loginSuccess {
                    let loginAlert = UIAlertController(title: "Erorr logging in", message: "incorrect email or password", preferredStyle: .alert )
                    
                    loginAlert.addAction(UIAlertAction (title: "OK", style: .default, handler: { _ in
                        return
                    }))
                    self.present(loginAlert, animated: true, completion: nil)
                } else {
                    
                    self.performSegue(withIdentifier: "loginSuccessSegueID", sender: self)
                    
                    //let controller = self.storyboard?.instantiateViewController(withIdentifier: "MapViewController") as! MapViewController
                    
                    //self.navigationController!.pushViewController(controller, animated: true)
                    
                    //In on the map, you need to use the key to call a function in the API class to get the user's first name and last name, but here we're just printing the key. So, in your app, instead of printing it, you'll call that function and be passing it as an argument to that function.
                    
                    
                    print ("the key is \(key)")
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
    
    func reloadStudentLocation () {
        
        ParseClient.getLocation ( completionHandler: { ( _ , error ) in
            
            if let error = error {
                print(" There is an error ")
                return
            }
            DispatchQueue.main.async {
                self.updateannotations()
            }
        }
        
    }
    
    
    
    func updateannotations () {
        
        let annotations = [MKPointAnnotation]()
        
        for studentLocation in studentLocation {
            
            
            
        }
        
    }
    
}
