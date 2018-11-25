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
    @IBOutlet weak var gradingLabel: UILabel!
    @IBOutlet weak var record_dateLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var inspectionTypeLabel: UILabel!
    
    @IBOutlet weak var inspectionDateLabel: UILabel!
    
    @IBOutlet weak var violationCodeLabel: UILabel!
    
    @IBOutlet weak var violationDescriptionLabel: UILabel!
    
    let locationManager = CLLocationManager()
    
    var business: Business?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let business = business {
            businessNameLabel.text = business.name
            gradingLabel.text = "Grade - " + business.grading
            record_dateLabel.text = "Record date - " + business.record_date
            addressLabel.text = formatAddress(strBuilding: business.building_number, strStreet: business.street, strBoro: business.boro, strZip: business.zipcode)
            phoneLabel.text = "Tel: " + arrangeUSFormat(strPhone: business.phone)
            scoreLabel.text = "Score - " + business.score
            inspectionDateLabel.text = "Inspection date - " + business.inspection_date
            inspectionTypeLabel.text = "Inspection type - " + business.inspection_type
            violationCodeLabel.text = "Violation date - " + business.violation_code
            violationDescriptionLabel.text = "Violation type - " + business.violation_Description
        }
    }
    
    //code to format address
    func formatAddress(strBuilding : String, strStreet : String, strBoro : String, strZip : String)-> String{
        let strUpdated = strBuilding + " " + strStreet + ", " + strBoro + ", NY " + strZip
        return strUpdated
    }
    
    
    //code to format phone number
    func arrangeUSFormat(strPhone : String)-> String {
        var strUpdated = strPhone
        if strPhone.characters.count == 10 {
            strUpdated.insert("(", at: strUpdated.startIndex)
            strUpdated.insert(")", at: strUpdated.index(strUpdated.startIndex, offsetBy: 4))
            strUpdated.insert(" ", at: strUpdated.index(strUpdated.startIndex, offsetBy: 5))
            strUpdated.insert("-", at: strUpdated.index(strUpdated.startIndex, offsetBy: 9))
        }
        return strUpdated
    }
    
    //code to go to google map for direction
    @IBAction func getDirectionButton(_ sender: Any) {
        if let business = business {
            let street = business.street
            let trimedStreet = street.replacingOccurrences(of: " ", with: "+")
            let address = business.building_number + "+" + trimedStreet + "+" + business.boro + "+" + business.zipcode
            let baseURLString = "https://www.google.com/maps/search/"
            
            if let url = URL(string: baseURLString + address) {
                UIApplication.shared.open(url, options: [:])
            }
        }
    }
    
    /* override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     
     let trailerViewController = segue.destination as! SeamLessViewController
     trailerViewController.business = business
     
     }*/
    
}
