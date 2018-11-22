//
//  MainCell.swift
//  EatSpector
//
//  Created by Pann Cherry on 11/22/18.
//  Copyright © 2018 TechBloomer. All rights reserved.
//

import UIKit

class MainCell: UITableViewCell {

    @IBOutlet weak var businessNameLabel: UILabel!
    @IBOutlet weak var categoriesLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var record_dateLabel: UILabel!
    @IBOutlet weak var gradingLabel: UILabel!
    @IBOutlet weak var websiteLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    
    var business: Business!{
        willSet(business){
            self.businessNameLabel.text = business.name
            self.categoriesLabel.text = "Category - " + business.categories
            self.gradingLabel.text = "Letter Grading - " + business.grading
            self.record_dateLabel.text = "Record Date - " + business.record_date
            let building = business.building_number + " "
            let street = business.street + " "
            let boro = business.boro + " "
            let zipcode = business.zipcode
            self.addressLabel.text = "Address - " + building+street+boro+zipcode
        }
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
