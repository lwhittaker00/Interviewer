//
//  FBLoginViewController.swift
//  Interviewer
//
//  Created by Macbook on 7/13/17.
//  Copyright © 2017 LC. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseAuthUI

class FBViewController: UIViewController {
    @IBOutlet weak var signUpButton: UIButton!
    
    @IBOutlet weak var customFBButton: UIButton!
    
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var firstNameTextField: UITextField!
    
    @IBOutlet weak var lastNameTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
    }
    
    func loginButtonDidLogOut(_ loginButton: FBSDKLoginButton!) {
        print("Successful Facebook log out")
    }
    
    func loginButton(_ loginButton: FBSDKLoginButton!, didCompleteWith result: FBSDKLoginManagerLoginResult!, error: Error!) {
        if error != nil {
            print(error)
            return
        }
        showEmailAddress()
    }
    
    func showEmailAddress() {
        let accessToken = FBSDKAccessToken.current()
        guard let accessTokenString = accessToken?.tokenString
            else { return }
        
        let credentials = FacebookAuthProvider.credential(withAccessToken:
            accessTokenString)
        
        Auth.auth().signIn(with: credentials, completion: { (user, error) in
            if error != nil {
                print("Something went wrong with our FB user:", error)
                return
                
            }
            print("Successfully logged in with our user:", user)
            
        })
        
        FBSDKGraphRequest(graphPath: "/me", parameters: ["fields": "id, name, email"]).start { (connection, result, err) in
            if err != nil {
                print("Failed to initiate graph request:", err)
                return
                
            }
            print(result)
        }
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
        
        
        
        
        let loginButton = FBSDKLoginButton()
        
        view.addSubview(loginButton)
        
        loginButton.frame = CGRect(x: 16, y: 50, width: view.frame.width - 32, height: 50)
        
        loginButton.delegate  = self
        loginButton.readPermissions = ["email", "public_profile"]
        
        
    }
    
    
}
