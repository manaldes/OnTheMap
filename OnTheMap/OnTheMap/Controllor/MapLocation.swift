//
//  MapLocation.swift
//  OnTheMap
//
//  Created by Manal  harbi on 17/03/1441 AH.
//  Copyright © 1441 Udasity. All rights reserved.
//

import Foundation
import  UIKit
import MapKit


class MapLocation : UIViewController {

    
    @IBOutlet weak var urlField: UITextField!
    @IBOutlet weak var MapView: MKMapView!
   
     var coordinate: CLLocationCoordinate2D!
    
    var mapString = ""
    var mediaUrl = ""
    
    var latitude:Double?
    var longitude:Double?
    
    var location : GetStudentLocation?
    
   
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        MapView.delegate = self
       
        let firstname = location?.firstName
        let lastname = location?.lastName
        
        mapString = "\(firstname ?? "") \(lastname ?? "")"
      
      
        creteAnnotaion ()
    }
   
    
    func creteAnnotaion ()  {
      
        let coordinate = CLLocationCoordinate2D(latitude: latitude ?? 0.0  , longitude: longitude ?? 0.0  )
            
        mediaUrl = urlField.text!
        
            let annotation = MKPointAnnotation()
            annotation.title = mapString
            annotation.subtitle = mediaUrl
            annotation.coordinate = coordinate
        
        
        self.MapView.addAnnotation(annotation)
        
        let region = MKCoordinateRegion(center: coordinate, latitudinalMeters: 0.01, longitudinalMeters: 0.01)
        MapView.setRegion(region, animated: false)
        
    }
    

    
    @IBAction func submitButton(_ sender: Any) {
   
        
        if urlField.text == "" {

            DispatchQueue.main.async {
                Global.showeAlert(viewController: self, title: "Empty Link " , message: "you must enter a link ")
                
                self.updateUI(processing: false)
                return
            }
            
        } else {
   
            ParseClient.postLocation ( self.location! ) { (error) in
            
            if error != nil {
                Global.showeAlert(viewController: self, title: "Error insert student ", message: "" )
            
                return
            } else {
                DispatchQueue.main.async {
                    self.navigationController?.viewControllers[0].dismiss(animated: true, completion: nil)
                }
                
            } // end else 2
            }
            
        } // end else 1
    }

    func updateUI (processing: Bool ){
        
        DispatchQueue.main.async {
            self.urlField.isEnabled = !processing
            
        }
    }
    
    
    
    
    

} // end class


extension MapLocation : MKMapViewDelegate {
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        let reuseId = "pin"
        
        var pinView = mapView.dequeueReusableAnnotationView(withIdentifier: reuseId) as? MKPinAnnotationView
        
        if pinView == nil {
            pinView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: reuseId)
            pinView!.canShowCallout = true
            pinView?.pinTintColor = .red
            pinView!.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
            
        }
        else {
            pinView!.annotation = annotation
        }
        
        return pinView
    }
    
    
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        
        
        if control == view.rightCalloutAccessoryView {
            let app = UIApplication.shared
            if let toOpen = view.annotation?.subtitle! {
                
                app.open(URL(string: toOpen)!, options: [:], completionHandler: nil)
            }
        }
    }
    
    
}
