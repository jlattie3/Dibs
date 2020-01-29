//
//  LoginViewController.swift
//  Dibs
//
//  Created by Jacob Lattie on 1/28/20.
//  Copyright © 2020 Jacob Lattie. All rights reserved.
//

import Foundation
import UIKit
import FirebaseAuth

class LoginViewController: UIViewController, UITextFieldDelegate {

    
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var loginButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("Login View")
        emailTextField.delegate = self
        passwordTextField.delegate = self
        setupUI()
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func loginButtonPressed(_ sender: Any) {
        
        Auth.auth().signIn(withEmail: emailTextField.text!, password: passwordTextField.text!) {
            (authResult, error) in
            
            if error == nil {
                print("Valid Login")
            } else {
                print("Invalid Login")
            }
        }
        
    }
    
    private func setupUI() {
        let cornerRadius = CGFloat(12.0)
        emailTextField.layer.cornerRadius = cornerRadius
        passwordTextField.layer.cornerRadius = cornerRadius
        emailTextField.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        passwordTextField.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        emailTextField.attributedPlaceholder = NSAttributedString(string: "Email",
        attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        passwordTextField.attributedPlaceholder = NSAttributedString(string: "Password",
        attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        loginButton.layer.cornerRadius = cornerRadius
    }
    
    // MARK: - UITextFieldDelegate
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
}
