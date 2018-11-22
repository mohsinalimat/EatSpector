//
//  SeamLessViewController.swift
//  EatSpector
//
//  Created by Pann Cherry on 11/10/18.
//  Copyright © 2018 TechBloomer. All rights reserved.
//

import UIKit
import WebKit
import CoreLocation
import MapKit

class SeamLessViewController: UIViewController, WKUIDelegate, CLLocationManagerDelegate {
    
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var SeamlessOrderWebView: WKWebView!
    var business: Business?
    
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let business = business {
            let street = business.street
            let trimedStreet = street.replacingOccurrences(of: " ", with: "+")
            let address = business.building_number + "+" + trimedStreet + "+" + business.boro + "+" + business.zipcode
            let baseURLString = "https://www.google.com/maps/search/"
            
            if let url = URL(string: baseURLString + address) {
                UIApplication.shared.open(url, options: [:])
            }
        }
        
        // Ask for Authorisation from the User.
        self.locationManager.requestAlwaysAuthorization()
        
        // For use in foreground
        self.locationManager.requestWhenInUseAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let locValue: CLLocationCoordinate2D = manager.location?.coordinate else { return }
        print("locations = \(locValue.latitude) \(locValue.longitude)")
    }
    
}
