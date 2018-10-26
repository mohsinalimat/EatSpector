//
//  BusinessAPIManager.swift
//  EatSpector
//
//  Created by Pann Cherry on 10/25/18.
//  Copyright © 2018 TechBloomer. All rights reserved.
//

import Foundation

class BusinessAPIManager {
    
    static let baseUrl = "https://data.cityofnewyork.us/resource/9w7m-hzhe.json"
    var session: URLSession
    
    init() {
        session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
    }
    
    func getBusinesses(completion: @escaping ([Business]?, Error?) -> ()) {
        let url = URL(string: BusinessAPIManager.baseUrl)!
        let request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10)
        let task = session.dataTask(with: request) { (data, response, error) in
            // This will run when the network request returns
            if let data = data {
                let dataDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as! [AnyObject]
    
                let  businessDictionaries = dataDictionary
                
                let businesses = Business.businesses(dictionaries: businessDictionaries as! [[String : Any]])
                completion(businesses, nil)
            } else {
                completion(nil, error)
            }
        }
        task.resume()
    }
 
}