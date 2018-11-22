//
//  Business.swift
//  EatSpector
//
//  Created by Pann Cherry on 10/24/18.
//  Copyright © 2018 TechBloomer. All rights reserved.
//

import Foundation

class Business {
    var name: String
    var categories: String
    var grading: String
    var building_number: String
    var street: String
    var boro: String
    var zipcode: String
    var record_date: String
    
    init(dictionary: [String:Any]){
        name = dictionary["dba"] as? String ?? "no name"
        categories = dictionary["cuisine_description"] as? String ?? "no category"
        grading = dictionary["grade"] as? String ?? "grading currently not available"
        building_number = dictionary["building"] as? String ?? "building number not available"
        street = dictionary["street"] as? String ?? "street not available"
        boro = dictionary["boro"] as? String ?? "boro not available"
        zipcode = dictionary["zipcode"] as? String ?? "zipcode not available"
        record_date = dictionary["record_date"] as? String ?? "no date"
    }
    
    class func businesses(dictionaries: [[String: Any]]) -> [Business]{
        var businesses: [Business] = []
        for dictionary in dictionaries {
            let business = Business(dictionary: dictionary)
            businesses.append(business)
        }
        return businesses
    }
}
