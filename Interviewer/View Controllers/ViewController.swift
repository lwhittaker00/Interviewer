//
//  ViewController.swift
//  Interviewer
//
//  Created by Macbook on 7/10/17.
//  Copyright © 2017 LC. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseAuthUI

class ViewController: UIViewController{
    
    @IBOutlet weak var customFBButton: UIButton!
    
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var firstNameTextField: UITextField!
    
    @IBOutlet weak var lastNameTextField: UITextField!
    
    @IBOutlet weak var signUpButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
           
    @IBAction func logInButtonTapped(_ sender: Any) {
        handleLogin()
        print("Successful login")
        return
    }
    
    
    func handleLogin (){
        
        guard let email = emailTextField.text, let password = passwordTextField.text
            else {
                
                print("Invalid form")
                return
        }
        
        Auth.auth().signIn(withEmail: email, password: password, completion: { (user, error) in
            if error != nil {
                print(error)
                return
                
            }
            
            print("Successful login")
            
        })
    }
    
    
    
    
    @IBAction func signUpButtonTapped(_ sender: Any) {
        
        handleRegister()
        print("Yeah")
        return
    }
    
}

    func handleRegister() {
        
        
        guard let email = emailTextField.text, let password = passwordTextField.text, let firstName = firstNameTextField.text, let lastName = lastNameTextField.text
            else {
                
                print("Invalid form")
                return
        }
        
        Auth.auth().createUser(withEmail: email, password: password, completion: { (user: User?, error) in
            if error != nil {
                print(error)
                return
                
            }
            
            guard let uid = user?.uid else {
                return
            }
            
            let ref = Database.database().reference(fromURL: "https://interviewer-c1666.firebaseio.com/")
            let usersReference = ref.child("users").child(uid)
            
            let values = ["first name": firstName, "last name": lastName, "email": email]
            
            usersReference.updateChildValues(values, withCompletionBlock: { (error, ref) in
                
                if error != nil {
                    print(error)
                    return
                    
                }
                print("Saved user successfully into Firebase")
            })
            
            
        })
        
        
    




}
