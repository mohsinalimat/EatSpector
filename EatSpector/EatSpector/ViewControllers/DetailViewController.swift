//
//  DetailViewController.swift
//  EatSpector
//
//  Created by Pann Cherry on 10/18/18.
//  Copyright © 2018 TechBloomer. All rights reserved.
//

import UIKit
import CoreLocation


class DetailViewController: UIViewController, CLLocationManagerDelegate {

    @IBOutlet weak var busniessImg: UIImageView!
    @IBOutlet weak var businessNameLabel: UILabel!
    @IBOutlet weak var categoriesLabel: UILabel!
    @IBOutlet weak var gradingLabel: UILabel!
    @IBOutlet weak var record_dateLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    
    let locationManager = CLLocationManager()

    var business: Business?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let business = business {
            businessNameLabel.text = business.name
            gradingLabel.text = business.grading
            categoriesLabel.text = business.categories
            record_dateLabel.text = business.record_date
            let building = business.building_number + " "
            let street = business.street + ", "
            let boro = business.boro + ", "
            let state = "NY "
            let zip = business.zipcode + " "
            addressLabel.text = building+street+boro+state+zip
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let trailerViewController = segue.destination as! SeamLessViewController
        trailerViewController.business = business
        
    }

}
