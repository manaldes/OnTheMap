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

        } // end else
        
    }
    
    func gcodeMapString ( _ mapString : String , completion: @escaping (_ coordinate : CLLocationCoordinate2D? , _ errorMessage: Error? ) -> Void) {
        
    
        let ai = self.startAnActivityIndicator()
        CLGeocoder().geocodeAddressString( mapString) { ( locations , error) in
            ai.stopAnimating()
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
       
            if segue.identifier == "showLocation" , let viewController = segue.destination as? MapLocation {
                
                viewController.mapString = self.locationTextField.text!
                viewController.coordinate = self.coordinate
                viewController.longitude = self.longitude
                viewController.latitude = self.latitude
                viewController.location = ( sender as! GetStudentLocation)
                
        }
    }
  
 
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
       
       locationTextField.endEditing(true)
       locationTextField.resignFirstResponder()
        
       return true
    }
    
    
    
    func startAnActivityIndicator() -> UIActivityIndicatorView {
        let ai = UIActivityIndicatorView(style: .gray)
        self.view.addSubview(ai)
        self.view.bringSubviewToFront(ai)
        ai.center = self.view.center
        ai.hidesWhenStopped = true
        ai.startAnimating()
        return ai
    }

}
