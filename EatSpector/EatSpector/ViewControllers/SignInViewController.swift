//
//  SignInViewController.swift
//  EatSpector
//
//  Created by Pann Cherry on 10/17/18.
//  Copyright © 2018 TechBloomer. All rights reserved.
//

import UIKit
import Firebase;
class SignInViewController: UIViewController {
    var handle: AuthStateDidChangeListenerHandle?

    
    @IBOutlet weak var usernameTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var signInButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    @IBAction func onClicked_SignInButton(_ sender: Any) {
        self.performSegue(withIdentifier: "logInSegue", sender: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // [START auth_listener]
        handle = Auth.auth().addStateDidChangeListener { (auth, user) in
            // [START_EXCLUDE]
//            self.setTitleDisplay(user)
//            self.tableView.reloadData()
            // [END_EXCLUDE]
        }
        // [END auth_listener]
    }

    
}
