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

    
    var latitude : Double = 0.0
    var longitude : Double = 0.0
    
    var coordinate: CLLocationCoordinate2D!
    
    var location = ""
    
    override func viewWillAppear(_ animated: Bool) {
       super.viewWillAppear(animated)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationTextField.delegate = self
        
        findLocation.layer.cornerRadius = 10
        
        
    }
    
    @IBAction func CancelButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
        
    }
    
    @IBAction func findLocationButton(_ sender: Any) {

        if locationTextField.text == "" {
            
            DispatchQueue.main.async {
                Global.showeAlert(viewController: self, title: "Location Text Field Empty", message: "You must enter your location")
                return
            }
          
            
       } else {
            
            DispatchQueue.main.async {
            
            
                self.location = self.locationTextField.text!
            
                self.gcodeMapString (self.location) { (coordinate , error ) in
                
                guard error == nil else {
                    Global.showeAlert(viewController: self, title: "Error " , message: "can not be indicate ")
                    return
                }
                
                    self.latitude = coordinate!.latitude
                    self.longitude = coordinate!.longitude
                    
               let studentLocation = GetStudentLocation.init(createdAt: "",
                                                             firstName: nil ,
                                                             lastName: nil ,
                                                             latitude: self.latitude,
                                                             longitude: self.longitude ,
                                                             mapString: self.location ,
                                                             mediaURL: "" ,
                                                             objectId: "" ,
                                                             uniqueKey: "" ,
                                                             updatedAt: "" )
                
                
            
                 
                self.coordinate = coordinate
                self.performSegue(withIdentifier: "showLocation", sender: studentLocation )
                }
            }
            
            
            /* let searchRequst = MKLocalSearch.Request()
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
           */
        } // end else
        
    }
    
    func gcodeMapString ( _ mapString : String , completion: @escaping (_ coordinate : CLLocationCoordinate2D? , _ errorMessage: Error? ) -> Void) {
        
        CLGeocoder().geocodeAddressString( mapString) { ( locations , error) in
            
            DispatchQueue.main.async {
                
                if error == nil {
                    if let placemark = locations?[0] {
                        let location = placemark.location!
                        completion(location.coordinate , nil )
                        return
                    }
                    
                } else {
                    
                    Global.showeAlert(viewController: self, title: "Location can not be indicate ", message: "" )
                    completion( nil , error)
                }
            }
        }
        
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        print("prepare seque" )
        
            if segue.identifier == "showLocation" {
               
                let vc = segue.destination as! MapLocation
                vc.mapString = self.locationTextField.text!
                vc.coordinate = self.coordinate
                vc.longitude = self.longitude
                vc.latitude = self.latitude
                
        }
    }
  
 
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
       locationTextField.endEditing(true)
      locationTextField.resignFirstResponder()
        return true
    }

}
