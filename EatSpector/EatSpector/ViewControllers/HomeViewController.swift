//
//  HomeViewController.swift
//  EatSpector
//
//  Created by Pann Cherry on 10/18/18.
//  Copyright © 2018 TechBloomer. All rights reserved.
//

import UIKit
import AFNetworking

class HomeViewController: UIViewController, UITableViewDataSource, UITableViewDelegate{
    
    @IBOutlet weak var tableView: UITableView!
    var businesses: [Business] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.rowHeight = 200
        //tableView.rowHeight = UITableView.automaticDimension
        //tableView.estimatedRowHeight = 650
        tableView.dataSource = self
        fetchBusinesses()
    }
    
    //count business
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return businesses.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BusinessCell", for: indexPath) as! BusinessCell
        let backgroundView = UIView()
        backgroundView.backgroundColor = UIColor.orange
        cell.selectedBackgroundView = backgroundView
        cell.contentView.backgroundColor = UIColor.white
        cell.business = businesses[indexPath.row]
        return cell
    }
    
    //fetch businesses
    func fetchBusinesses () {
        BusinessAPIManager().getBusinesses { (businesses: [Business]?, error: Error?) in
            if let businesses = businesses {
                self.businesses = businesses
                //elf.filteredMovie = movies
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

}
