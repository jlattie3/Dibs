//
//  IntroViewController.swift
//  Dibs
//
//  Created by Jacob Lattie on 2/10/20.
//  Copyright © 2020 Jacob Lattie. All rights reserved.
//

import UIKit
import FirebaseAuth

class IntroViewController: UIViewController, UITextFieldDelegate {

    
    @IBOutlet weak var dibsLabel: UILabel!
    @IBOutlet weak var createAccountButton: UIButton!
    @IBOutlet weak var loginButton: UIButton!
    
    @IBOutlet weak var imageView1: UIImageView!
    @IBOutlet weak var label1: UILabel!
    
    @IBOutlet weak var imageView2: UIImageView!
    @IBOutlet weak var label2: UILabel!
    
    @IBOutlet weak var imageView3: UIImageView!
    @IBOutlet weak var label3: UILabel!
    
    @IBOutlet weak var signOutTestButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()

        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func loginButtonTapped(_ sender: Any) {
        Auth.auth().addStateDidChangeListener { auth, user in
            if let user = user {
                print(user)
                self.performSegue(withIdentifier: "alreadyLoggedIn", sender: nil)
                
            } else {
                self.performSegue(withIdentifier: "notLoggedIn", sender: nil)
            }
        }
        print("Login Tapped")
        
    }
    
    
    @IBAction func signOutTestButtonTapped(_ sender: Any) {
        do {
            try Auth.auth().signOut()
        } catch let signOutError as NSError {
          print ("Error signing out: %@", signOutError)
        }
    }
    
    
    
    
    func setupUI() {
        let cornerRadius = CGFloat(15.0)
//        createAccountButton.layer.cornerRadius = cornerRadius
        loginButton.layer.cornerRadius = cornerRadius
        
//        imageView1.image = UIImage(systemName: "􀓏")
//        imageView2.image = UIImage(systemName: "􀖀")
//        imageView3.image = UIImage(systemName: "􀋦")
//        label1.text = "Find Your Desired Seat \nTest\nTest"
//        label2.text = "Check In With NFC"
//        label3.text = "Save Time And Energy"
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
