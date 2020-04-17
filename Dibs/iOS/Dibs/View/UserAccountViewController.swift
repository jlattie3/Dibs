//
//  UserAccountViewController.swift
//  Dibs
//
//  Created by Jacob Lattie on 4/14/20.
//  Copyright © 2020 Jacob Lattie. All rights reserved.
//

import UIKit
import Firebase

class UserAccountViewController: UIViewController {

    @IBOutlet weak var accountInfoView: UIView!
    @IBOutlet weak var spotInfoView: UIView!
    @IBOutlet weak var appInfoView: UIView!
    @IBOutlet weak var accountEmailLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var logOutButton: UIButton!
    @IBOutlet weak var pickerView: UIPickerView!
    @IBOutlet weak var tableView: UITableView!
    
    let pickerItems = ["Standford", "Georgia Tech", "Auburn"]
    
    let tableViewData = ["CULC", "Van Leer"]
    let detailData = ["2/100", "1/40"]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // delegates
        self.pickerView.delegate = self
        self.pickerView.dataSource = self
        self.tableView.delegate = self
        self.tableView.dataSource = self

        // Do any additional setup after loading the view.
        // shadow accountInfoView
       let spotCornerRadius = self.accountInfoView.frame.height / 15.0
        self.accountInfoView.layer.cornerRadius = spotCornerRadius
        self.accountInfoView.clipsToBounds = true
        self.accountInfoView.layer.shadowColor = UIColor.gray.cgColor
        self.accountInfoView.layer.shadowOpacity = 0.5
        self.accountInfoView.layer.shadowOffset = CGSize.zero
        self.accountInfoView.layer.shadowRadius = 5.0
        self.accountInfoView.layer.masksToBounds = false
        // shadow spotInfoView
        self.spotInfoView.layer.cornerRadius = spotCornerRadius
        self.spotInfoView.clipsToBounds = true
        self.spotInfoView.layer.shadowColor = UIColor.gray.cgColor
        self.spotInfoView.layer.shadowOpacity = 0.5
        self.spotInfoView.layer.shadowOffset = CGSize.zero
        self.spotInfoView.layer.shadowRadius = 5.0
        self.spotInfoView.layer.masksToBounds = false
        // shadow appInfoView
        self.appInfoView.layer.cornerRadius = spotCornerRadius
        self.appInfoView.clipsToBounds = true
        self.appInfoView.layer.shadowColor = UIColor.gray.cgColor
        self.appInfoView.layer.shadowOpacity = 0.5
        self.appInfoView.layer.shadowOffset = CGSize.zero
        self.appInfoView.layer.shadowRadius = 5.0
        self.appInfoView.layer.masksToBounds = false
        // button UI
        logOutButton.layer.cornerRadius = CGFloat(10.0)
        
        
        // read Firebase
        loadFirebaseUserData()
        
    }
    
    func loadFirebaseUserData() {
        let user = Auth.auth().currentUser
        if let user = user {
            if let email = user.email {
                accountEmailLabel.text = email
            }
            if let date = user.metadata.creationDate {
                
                let formatter = DateFormatter()
                formatter.dateFormat = "dd-MMM-yyyy"
                let dateString = formatter.string(from: date)
                dateLabel.text = dateString
            }
        }
    }
    
    @IBAction func logOutButtonTapped(_ sender: Any) {
        do {
            try Auth.auth().signOut()
        } catch let signOutError as NSError {
          print ("Error signing out: %@", signOutError)
        }
        self.performSegue(withIdentifier: "unwindToIntro", sender: self)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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

extension UserAccountViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        self.pickerItems.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return self.pickerItems[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        var label = UILabel()
        if let v = view as? UILabel { label = v }
        label.font = UIFont(name: "Helvetica Neue", size: 20)
        label.textColor = #colorLiteral(red: 0.3333333433, green: 0.3333333433, blue: 0.3333333433, alpha: 1)
        label.text =  self.pickerItems[row]
        label.textAlignment = .center
        return label
    }
    
}

extension UserAccountViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.tableViewData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        if let label = cell.textLabel {
            label.font = UIFont(name: "Helvetica Neue", size: 18)
            label.textColor = #colorLiteral(red: 0.3333333433, green: 0.3333333433, blue: 0.3333333433, alpha: 1)
            label.text = self.tableViewData[indexPath.row]
        }
        if let detail = cell.detailTextLabel {
            detail.font = UIFont(name: "Helvetica Neue", size: 18)
            detail.textColor = #colorLiteral(red: 0.3333333433, green: 0.3333333433, blue: 0.3333333433, alpha: 1)
            detail.text = self.detailData[indexPath.row]
        }
        return cell
    }
    
    
}
