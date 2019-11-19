//
//  ViewController.swift
//  OnTheMap
//
//  Created by Manal  harbi on 07/03/1441 AH.
//  Copyright © 1441 Udasity. All rights reserved.
//


import UIKit
import MapKit

class MapViewController: UIViewController , MKMapViewDelegate {
    
    @IBOutlet weak var RefreshButton: UIBarButtonItem!
    @IBOutlet weak var AddPinButton: UIBarButtonItem!
    @IBOutlet weak var MapView: MKMapView!
    
    
    let locations = hardCodedLocationData()
    var annotations = [MKPointAnnotation]()
    
    var studentLocation:[GetStudentLocation]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        MapView.delegate = self
    }
    
   
    override func viewWillAppear(_ animated: Bool) {
            
          if studentLocation == nil {
            
            reloadStudentLocation()
            
          } else {
            
           DispatchQueue.main.async {
               self.updateannotations()
            }
            }
            
    }//end willApear
    
    
    
    
    @IBAction func refreshButton(_ sender: Any) {
       reloadStudentLocation()
    }
    
    
    
    @IBAction func AddPinButton(_ sender: Any) {
        
    self.performSegue(withIdentifier: "AddSeque" , sender: nil)
    }
    
   
    

    @IBAction func Logout(_ sender: Any) {
       
        UdasityClient.DeleteSession { (error) in
        
            guard error == nil else {
                Global.showeAlert(viewController: self, title:  "There is an error to logout  ", message: "")
                return
            }
          
            DispatchQueue.main.async {
                self.dismiss(animated: true, completion: nil)
                
                } 
        }
        
    } // end logout
        
        
        
        func updateannotations () {
            
            var annotations = [MKPointAnnotation]()
            
            let locationsArray = studentLocation
        
            GetStudentLocation.lastFetched = locationsArray


            guard locationsArray != nil else {
                
                Global.showeAlert(viewController: self, title: " Location array is empty ", message: "" )
                return
            }
            
            for locationsArray in studentLocation {
                
                let lat = CLLocationDegrees(locationsArray.latitude ?? 0)
                let long = CLLocationDegrees( locationsArray.longitude ?? 0)
                let coordinate = CLLocationCoordinate2D(latitude: lat, longitude: long)
                
                let first = locationsArray.firstName ?? ""
                let last = locationsArray.lastName ?? ""
                let media = locationsArray.mediaURL ?? ""
                
                let annotation = MKPointAnnotation()
                
                annotation.coordinate = coordinate
                annotation.title = "\(first) \(last)"
                annotation.subtitle = media
                
                annotations.append (annotation)
                
            }
            self.MapView.addAnnotations (annotations)
         }
    
    
    
        func reloadStudentLocation () {
            
            ParseClient.getLocations { ( Location , error ) in
                
                guard error == nil else {
                    print(" There is an error to load location  ")
                    return
                }
                
                DispatchQueue.main.async {
                    self.studentLocation = Location
                    GetStudentLocation.lastFetched = Location
                    self.updateannotations()
                }
            }
         }
    
    
    
    // MARK: - MKMapViewDelegate
    
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
