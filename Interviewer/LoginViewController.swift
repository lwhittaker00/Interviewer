//
//  Login.swift
//  Interviewer
//
//  Created by Macbook on 7/10/17.
//  Copyright © 2017 LC. All rights reserved.
//


import Foundation
import UIKit
import FirebaseAuth
import FirebaseAuthUI

class LoginViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //refresh()
        //Looks for single or multiple taps.
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(LoginViewController.dismissKeyboard))
        
        //Uncomment the line below if you want the tap not not interfere and cancel other interactions.
        //tap.cancelsTouchesInView = false
        
        view.addGestureRecognizer(tap)
        
    }
    
    @IBAction func loginButtonTapped(_ sender: UIButton) {
        // 1
        guard let authUI = FUIAuth.defaultAuthUI()
            else { return }
        
        // 2
        authUI.delegate = self as FUIAuthDelegate
        
        // 3
        let authViewController = authUI.authViewController()
        present(authViewController, animated: true)
    }
    
    @IBAction func unwindToLoginViewController(_ segue: UIStoryboardSegue) {
        
        // for now, simply defining the method is sufficient.
        // we'll add code later
        
    }
    
    //Calls this function when the tap is recognized.
    func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    func refresh() {
        let gradient = CAGradientLayer()
        gradient.colors = [UIColor.init(red: 0.60, green: 0.93, blue: 0.60, alpha: 1.0), UIColor.blue.cgColor]
        gradient.frame = view.layer.bounds
        view.layer.insertSublayer(gradient, at: 0)
    }

    
    
}


extension LoginViewController: FUIAuthDelegate {
    func authUI(_ authUI: FUIAuth, didSignInWith user: User?, error: Error?) {
        print("handle user signup / login")
    }
}

