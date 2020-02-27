//
//  IntroViewController.swift
//  Dibs
//
//  Created by Jacob Lattie on 2/10/20.
//  Copyright © 2020 Jacob Lattie. All rights reserved.
//

import UIKit
import FirebaseAuth
import Pastel

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
        
        let pastelView = PastelView(frame: view.bounds)
        // Custom Direction
        pastelView.startPastelPoint = .bottomLeft
        pastelView.endPastelPoint = .topRight

        // Custom Duration
        pastelView.animationDuration = 2.0

        // Custom Color
//        pastelView.setColors([UIColor(red: 156/255, green: 39/255, blue: 176/255, alpha: 1.0),
//                              UIColor(red: 255/255, green: 64/255, blue: 129/255, alpha: 1.0),
//                              UIColor(red: 123/255, green: 31/255, blue: 162/255, alpha: 1.0),
//                              UIColor(red: 32/255, green: 76/255, blue: 255/255, alpha: 1.0),
//                              UIColor(red: 32/255, green: 158/255, blue: 255/255, alpha: 1.0),
//                              UIColor(red: 90/255, green: 120/255, blue: 127/255, alpha: 1.0),
//                              UIColor(red: 58/255, green: 255/255, blue: 217/255, alpha: 1.0)])
        let colors = [UIColor(red: 252/255, green: 227/255, blue: 138/255, alpha: 1.0),
                      UIColor(red: 243/255, green: 129/255, blue: 129/255, alpha: 1.0)]
        pastelView.setColors(colors)

//        pastelView.startAnimation()
//        view.insertSubview(pastelView, at: 0)

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
