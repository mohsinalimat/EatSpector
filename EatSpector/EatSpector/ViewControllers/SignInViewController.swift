//
//  SignInViewController.swift
//  EatSpector
//
//  Created by Pann Cherry on 10/17/18.
//  Copyright © 2018 TechBloomer. All rights reserved.
//

import UIKit

class SignInViewController: UIViewController {

    
    @IBOutlet weak var usernameTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var signInButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    @IBAction func onClicked_SignInButton(_ sender: Any) {
        self.performSegue(withIdentifier: "logInSegue", sender: nil)
    }
    
}
