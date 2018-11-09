//
//  HomeViewController.swift
//  EatSpector
//
//  Created by Pann Cherry on 10/18/18.
//  Copyright © 2018 TechBloomer. All rights reserved.
//

import UIKit
import AFNetworking

class HomeViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate{
    
    @IBOutlet weak var tableView: UITableView!
    var businesses: [Business] = []
    let cellSpacingHeight: CGFloat = 20

    var searchInput: [Business]?;
    var searching = false;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.rowHeight = 200
        //tableView.rowHeight = UITableView.automaticDimension
        //tableView.estimatedRowHeight = 650
        tableView.dataSource = self
        tableView.rowHeight = 120
        fetchBusinesses()
        
//        setupNavBar();
    }
    func setupNavBar(){
        navigationController?.navigationBar.prefersLargeTitles = true;
        let searchController = UISearchController(searchResultsController: nil);
        navigationItem.searchController = searchController;
        searchController.delegate = self as? UISearchControllerDelegate;
        navigationItem.hidesSearchBarWhenScrolling = false;
    }
    //count business
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searching{
            print(searchInput?.count ?? 0)
            return searchInput?.count ?? businesses.count;
        }
        else{
            print(businesses.count);
            return businesses.count;
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "BusinessCell", for: indexPath) as! BusinessCell
        let backgroundView = UIView()
        backgroundView.backgroundColor = UIColor.orange
        cell.selectedBackgroundView = backgroundView
        cell.contentView.backgroundColor = UIColor.red
        if searching{
            let filterResult = searchInput?[indexPath.row]
            cell.textLabel?.text = filterResult?.name;
        }
        else {
            cell.business = businesses[indexPath.row]
        }
        let whiteRoundedView : UIView = UIView(frame: CGRect(x: 10, y: 8, width: self.view.frame.size.width - 20, height: 120))

        
        whiteRoundedView.layer.backgroundColor = CGColor(colorSpace: CGColorSpaceCreateDeviceRGB(), components: [1.0, 1.0, 1.0, 0.9])
        whiteRoundedView.layer.masksToBounds = false
        whiteRoundedView.layer.cornerRadius = 2.0
        whiteRoundedView.layer.shadowOffset = CGSize(width: -1, height: 1)
        whiteRoundedView.layer.shadowOpacity = 0.2
        
        cell.contentView.addSubview(whiteRoundedView)
        cell.contentView.sendSubviewToBack(whiteRoundedView)
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

    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        guard !searchText.isEmpty else
        {
            searchInput = businesses;
            tableView.reloadData()
            return
            
        }
        
        searchInput = businesses.filter({ (Business) -> Bool in
            guard searchBar.text != nil else { return false;}
            return Business.name.contains(searchText);
        })
        searching = true;
        tableView.reloadData();
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
