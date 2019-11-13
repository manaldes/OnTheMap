//
//  AddNewLocation.swift
//  OnTheMap
//
//  Created by Manal  harbi on 13/03/1441 AH.
//  Copyright © 1441 Udasity. All rights reserved.
//

import Foundation
import UIKit
import MapKit

class  AddNewLocation: UIViewController , UITextFieldDelegate{
    
  
    
    
    @IBOutlet weak var locationTextField: UITextField!
    @IBOutlet weak var findLocation: UIButton!
    
    var latitude : Double?
    var longitude : Double?
    
    override func viewWillAppear(_ animated: Bool) {
       super.viewWillAppear(animated)
        
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationTextField.delegate = self
        
        findLocation.layer.cornerRadius = 5
        
    }
    
    @IBAction func CancelButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
        
    }
    
    @IBAction func submitButton(_ sender: Any) {
        
        /*ParseClient.postLocation (student) { (errorMessage) in
            
            if ( error != nil ){
                
            } else {
          */
       // DispatchQueue.main.async {
            //newUserInformation(newStudent)
        //}
      //      }
    //}
    }
    
    @IBAction func findLocationButton(_ sender: Any) {
    
        
        if ( locationTextField.text == nil) {
           
            Global.showeAlert(viewController: self, title: "Location Text Field Empty", message: "You must enter your location")
            
        } else {
            
            let searchRequst = MKLocalSearch.Request()
            searchRequst.naturalLanguageQuery = locationTextField.text
            let search = MKLocalSearch(request: searchRequst)
            search.start{ ( response , error ) in
                DispatchQueue.main.async {
                   
                    if error != nil {
                        Global.showeAlert(viewController: self , title: "Can not be indicate location ", message: "")
                        return
                        
                    } else {
                        
                        self.latitude = response?.boundingRegion.center.latitude
                        self.longitude = response?.boundingRegion.center.longitude
                        
                        self.performSegue(withIdentifier: "showLocation", sender: nil)
                    }
                } // end DispatchQueue
                
                
            }
            
        } // end else
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showLocation" {
            let vc = segue.destination as! MapLocation
            
            vc.mapString = locationTextField.text!
           
        }
    }
    
    func newUserInformation (_ student: GetStudentLocation) {
        
        var newStudent = GetStudentLocation()
        
        newStudent.uniqueKey = student.uniqueKey
        newStudent.firstName = student.firstName
        newStudent.lastName = student.lastName
        newStudent.mapString = student.mapString
        newStudent.mediaURL = student.mediaURL
        newStudent.longitude = student.longitude
        newStudent.latitude = student.latitude
        
        ParseClient.postLocation(newStudent) { (errorMessage) in
            
            if errorMessage == nil {
                DispatchQueue.main.async {
                    self.navigationController?.popToRootViewController(animated: true)
                }
            } else {
                DispatchQueue.main.async {
                    print(errorMessage)
                }
            }
        
    }
    }
    
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
       locationTextField.endEditing(true)
        locationTextField.resignFirstResponder()
        return true
    }
    
   


}
