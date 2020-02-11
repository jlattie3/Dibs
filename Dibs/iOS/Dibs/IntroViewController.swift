//
//  IntroViewController.swift
//  Dibs
//
//  Created by Jacob Lattie on 2/10/20.
//  Copyright © 2020 Jacob Lattie. All rights reserved.
//

import UIKit

class IntroViewController: UIViewController {

    
    @IBOutlet weak var dibsLabel: UILabel!
    @IBOutlet weak var createAccountButton: UIButton!
    @IBOutlet weak var loginButton: UIButton!
    
    @IBOutlet weak var imageView1: UIImageView!
    @IBOutlet weak var label1: UILabel!
    
    @IBOutlet weak var imageView2: UIImageView!
    @IBOutlet weak var label2: UILabel!
    
    @IBOutlet weak var imageView3: UIImageView!
    @IBOutlet weak var label3: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()

        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func loginButtonTapped(_ sender: Any) {
        
        self.performSegue(withIdentifier: "loginButtonTapped", sender: nil)
        
    }
    
    
    
    func setupUI() {
        let cornerRadius = CGFloat(15.0)
        createAccountButton.layer.cornerRadius = cornerRadius
        loginButton.layer.cornerRadius = cornerRadius
        
//        imageView1.image = UIImage(systemName: "􀓏")
//        imageView2.image = UIImage(systemName: "􀖀")
//        imageView3.image = UIImage(systemName: "􀋦")
        label1.text = "Find Your Desired Seat \nTest\nTest"
        label2.text = "Check In With NFC"
        label3.text = "Save Time And Energy"
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
