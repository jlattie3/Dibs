//
//  LoginSignupViewController.swift
//  Dibs
//
//  Created by Jacob Lattie on 2/21/20.
//  Copyright © 2020 Jacob Lattie. All rights reserved.
//

import UIKit
import FirebaseAuth

class LoginSignupViewController: UIViewController, UITextFieldDelegate {

    
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var signupButton: UIButton!
    
    @IBOutlet weak var loginButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        emailTextField.delegate = self
        passwordTextField.delegate = self
        
        setupUI()
        // Do any additional setup after loading the view.
    }
    
    func setupUI() {
        let cornerRadius = CGFloat(15.0)
        
        signupButton.layer.cornerRadius = cornerRadius
        loginButton.layer.cornerRadius = cornerRadius
    }

    
    @IBAction func signUpButtonTapped(_ sender: Any) {
        Auth.auth().createUser(withEmail: emailTextField.text!, password: passwordTextField.text!) { authResult, error in
          // ...
//            print(authResult)
            if authResult != nil {
                self.performSegue(withIdentifier: "validSignUp", sender: nil)
            }
        }
    }
    
    @IBAction func loginButtonTapped(_ sender: Any) {
        Auth.auth().signIn(withEmail: emailTextField.text!, password: passwordTextField.text!) { [weak self] authResult, error in
          guard let strongSelf = self else { return }
          // ...
//            print(authResult)
            if authResult != nil {
                strongSelf.performSegue(withIdentifier: "validLogIn", sender: nil)
            }
        }
    }
    
    
    
    // MARK: - UITextFieldDelegate
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
//        if textField == emailTextField {
//            emailTextField.resignFirstResponder()
//            return true
//        }
//        if textField == passwordTextField {
//            passwordTextField.resignFirstResponder()
//            return true
//        }
//        return false
        if textField == emailTextField {
            passwordTextField.becomeFirstResponder()
            
        } else {
            textField.resignFirstResponder()
        }
        return true
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
