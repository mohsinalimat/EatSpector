//
//  SignUpViewController.swift
//  EatSpector
//
//  Created by Pann Cherry on 10/17/18.
//  Copyright © 2018 TechBloomer. All rights reserved.
//

import UIKit
import Firebase;
import FirebaseAuth;

class SignUpViewController: UIViewController, UINavigationControllerDelegate {

    
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var usernameTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var repeatPasswordTextField: UITextField!
    
    
    @IBOutlet weak var cancelButton: UIButton!
    
    var keyboard = CGRect()
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    var scrollViewHeight: CGFloat = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //set the scrollView frame size to device width and height
        scrollView.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height)
        scrollView.contentSize.height = self.view.frame.height
        scrollViewHeight = scrollView.frame.size.height
        
        NotificationCenter.default.addObserver(self, selector: #selector(showKeyboard(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(hideKeyboard(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        
    }
    
    //custom navigation bar
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.barTintColor = UIColor(red: 255, green: 0/255, blue: 0/255, alpha: 1)
        self.navigationController?.navigationBar.tintColor = UIColor.white
        self.navigationController!.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
    }
    
    //show the keyboard
    @objc func showKeyboard(notification: NSNotification){
        keyboard = ((notification.userInfo![UIResponder.keyboardFrameEndUserInfoKey]! as AnyObject).cgRectValue)!
        UIView.animate(withDuration: 0.4) {
            self.scrollView.frame.size.height = self.scrollViewHeight - self.keyboard.height
        }
    }
    
    //hide the keyboard
    @objc func hideKeyboard(notification: NSNotification){
        UIView.animate(withDuration: 0.4) {
            self.scrollView.frame.size.height = self.view.frame.height
        }
    }
    @IBAction func onSubmit(_ sender: Any) {
        guard let username = usernameTextField.text else {return}
        guard let password = passwordTextField.text else {return}
        guard let email = emailTextField.text else {return}
        guard let passwordConfirmation = repeatPasswordTextField.text else {return}
        
        if (password != passwordConfirmation)
        {
            let alert = UIAlertController(title: "Error", message: "Password and Confirmed Password must be matched", preferredStyle: .alert);
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil));
            self.present(alert,animated: true);
        }
        else{
            Auth.auth().createUser(withEmail: email, password: password){
                user,error in
                if error == nil && user != nil{
                    print("User account is created.")
                    let changeRequest = Auth.auth().currentUser?.createProfileChangeRequest()
                    changeRequest?.displayName = username;
                    changeRequest?.commitChanges(completion: { (error) in
                        if(error == nil){
                            print ("User display name changed.");
                            self.dismiss(animated: false, completion: nil);
                        }
                    })
                }
            }
        }
        
    }
    
    //dismiss the current viewController when click on cancel button
    @IBAction func cancelButton_Clicked(_ sender: Any) {self.view.window!.rootViewController?.presentedViewController?.dismiss(animated: true, completion: nil)
    }
    
    //dismiss keyboard on tap
    @IBAction func onTapDismissKeyboard(_ sender: Any) {
        view.endEditing(true)
    }
    
}
