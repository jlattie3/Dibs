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
        let value = snapshot.value as? NSDictionary
        print(value)
        print(".")
        print(".")
        print(".")

        }) { (error) in
            print(error.localizedDescription)
        }
    }
    
    
}


