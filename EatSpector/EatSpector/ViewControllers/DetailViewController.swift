//
//  DetailViewController.swift
//  EatSpector
//
//  Created by Pann Cherry on 10/18/18.
//  Copyright © 2018 TechBloomer. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var busniessImg: UIImageView!
    @IBOutlet weak var businessNameLabel: UILabel!
    @IBOutlet weak var categoriesLabel: UILabel!
    @IBOutlet weak var gradingLabel: UILabel!
    @IBOutlet weak var record_dateLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    
    var business: Business?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let business = business {
            businessNameLabel.text = business.name
            gradingLabel.text = business.grading
            categoriesLabel.text = business.categories
            record_dateLabel.text = business.record_date
            addressLabel.text = business.address
        }
        // Do any additional setup after loading the view.
    }

}
