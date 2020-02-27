//
//  FIRDatabaseController.swift
//  Dibs
//
//  Created by Jacob Lattie on 1/23/20.
//  Copyright © 2020 Jacob Lattie. All rights reserved.
//

import Foundation
import Firebase

public class FireDatabaseController {
    
    var ref: DatabaseReference!
    
    init(ref: DatabaseReference) {
        self.ref = ref
    }
    
    func read() {
        self.ref.child("chair").observeSingleEvent(of: .value, with: { (snapshot) in
        // Get chair data
        guard let value = snapshot.value as? NSDictionary else {
            print("Invalid Firebase Read")
            return
        }
        print(".")
        print(".")
        print(".")
        let keys = value.allKeys
        print("Keys: ")
        print(keys)
        if let chair_dict = value[keys[0]] as? NSDictionary {
            if let building = chair_dict["Building"] as? String {
                print(building)
            }
            if let floor = chair_dict["Floor"] as? String {
                print(floor)
            }
            if let room = chair_dict["Room"] as? String {
                print(room)
            }
            if let status = chair_dict["status"] as? Int {
                print(status)
            }
        }
        print(".")
        print(".")
        print(".")

        }) { (error) in
            print(error.localizedDescription)
        }
    }
    
    
}


