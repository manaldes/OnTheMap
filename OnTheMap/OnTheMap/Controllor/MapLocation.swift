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


class MapLocation : UIViewController , MKMapViewDelegate {

    
    @IBOutlet weak var urlField: UITextField!
    @IBOutlet weak var MapView: MKMapView!
    
    
    static var shared = MapLocation()
    var location = GetStudentLocation?.self
    var selectedLocation = CLLocationCoordinate2D(latitude: 0, longitude: 0)
    
    var mapString = ""
    var mediaUrl = ""
    var latitude:Double?
    var longitude:Double?
        
    override func viewDidLoad() {
        super.viewDidLoad()
        MapView.delegate = self
        
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        creteAnnotaion ()
        
    }
    
    func creteAnnotaion () {
        
        let annotation = MKPointAnnotation()
        annotation.title = mapString
        annotation.subtitle = mediaUrl
        annotation.coordinate = CLLocationCoordinate2DMake(latitude ?? 0.0, longitude ?? 0.0)
        self.MapView.addAnnotation(annotation)
        
        
    }
    
    
    @IBAction func submitButton(_ sender: Any) {
    }
}
