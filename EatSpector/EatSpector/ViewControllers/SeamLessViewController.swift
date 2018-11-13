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

class SeamLessViewController: UIViewController, WKUIDelegate, CLLocationManagerDelegate {

    @IBOutlet weak var SeamlessOrderWebView: WKWebView!
    
    let locationManager = CLLocationManager()

    var business: Business?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Ask for Authorisation from the User.
        self.locationManager.requestAlwaysAuthorization()
        
        // For use in foreground
        self.locationManager.requestWhenInUseAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
        }
        
        if UIApplication.shared.canOpenURL(URL(string: "https://www.google.com/maps/search/pizza")!) {
            // Map is installed. Launch Map and get direction
           // let urlStr = String(format: "maps://place/" + business!.name)
           // UIApplication.shared.openURL(URL(string: "maps://place/pizza")!)
            UIApplication.shared.openURL(URL(string: "https://www.google.com/maps/search/pizza")!)
        } else {
            // Map is not installed. Launch AppStore to install Map app
            
            UIApplication.shared.openURL(URL(string: "https://www.google.com/maps/place/pizza")!)
        }
    }
    

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let locValue: CLLocationCoordinate2D = manager.location?.coordinate else { return }
        print("locations = \(locValue.latitude) \(locValue.longitude)")
    }
}
