//
//  ViewController.swift
//  Dibs
//
//  Created by Jacob Lattie on 1/6/20.
//  Copyright © 2020 Jacob Lattie. All rights reserved.
//

import UIKit
import FirebaseAuth

class ViewController: UIViewController {

    @IBOutlet weak var testButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Auth.auth().addStateDidChangeListener { auth, user in
            if let user = user {
                self.testButton.layer.cornerRadius = CGFloat(22.0)
                self.performSegue(withIdentifier: "alreadyLoggedIn", sender: nil)
                
            } else {
                
            }
        }
        // Do any additional setup after loading the view.
    }


}

