//
//  MainViewController.swift
//  EatSpector
//
//  Created by Pann Cherry on 11/22/18.
//  Copyright © 2018 TechBloomer. All rights reserved.
//

import UIKit
import CoreLocation
import AVFoundation
import SafariServices

class MainViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    var businesses: [Business] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.rowHeight = 420
        //tableView.rowHeight = UITableView.automaticDimension
        //tableView.estimatedRowHeight = 650
        tableView.dataSource = self
        fetchBusinesses()
    }
    
    //code to count business
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return businesses.count
    }
    
    
    //code to display cell
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MainCell", for: indexPath) as! MainCell
        cell.business = businesses[indexPath.row]
        return cell
    }
    
    //fetch businesses
    func fetchBusinesses () {
        BusinessAPIManager().getBusinesses { (businesses: [Business]?, error: Error?) in
            if let businesses = businesses {
                self.businesses = businesses
                self.tableView.reloadData()
                //self.activityIndicator.stopAnimating()
                //self.refreshControl.endRefreshing()
            }
        }
    }
    
    //custom navigation bar
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.barTintColor = UIColor(red: 255, green: 0/255, blue: 0/255, alpha: 1)
        self.navigationController?.navigationBar.tintColor = UIColor.white
        self.navigationController!.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
    }
    
    //code to connect with detailViewController
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let cell = sender as! UITableViewCell
        if let indexPath = tableView.indexPath(for: cell){
            let business = businesses[indexPath.row]
            let detailViewController = segue.destination as! DetailViewController
            detailViewController.business = business
        }
    }
}
