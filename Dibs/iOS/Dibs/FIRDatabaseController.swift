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
    
    func readAllChairs() -> [DibsChair] {
        
        var dibsChairList = [DibsChair]()
        
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
            
            for key in keys {
                
                let dibsChair = DibsChair()
                
                if let chair_dict = value[key] as? NSDictionary {
                    if let building = chair_dict["Building"] as? String {
                        print(building)
                        dibsChair.building = building
                    }
                    if let floor = chair_dict["Floor"] as? String {
                        print(floor)
                        dibsChair.floor = floor
                    }
                    if let room = chair_dict["Room"] as? String {
                        print(room)
                        dibsChair.room = room
                    }
                    if let status = chair_dict["status"] as? String {
                        print(status)
                        dibsChair.status = status
                    }
                    dibsChairList.append(dibsChair)
                } else {
                    continue
                }
                
            }
            print(".")
            print(".")
            print(".")

        }) { (error) in
            print(error.localizedDescription)
        }
        return dibsChairList
    }
    
    
    func getDibsSpotForMacAddr(MAC_addr: String) -> (DibsChair) {
        
        let dibsChair = DibsChair()
        
        self.ref.child("chair").observeSingleEvent(of: .value, with: { (snapshot) in
            guard let value = snapshot.value as? NSDictionary else {
                print("Invalid Firebase Read")
                return
            }
            
            if let chair_dict = value[MAC_addr] as? NSDictionary {
                if let building = chair_dict["Building"] as? String {
                    print(building)
                    dibsChair.building = building
                }
                if let floor = chair_dict["Floor"] as? String {
                    print(floor)
                    dibsChair.floor = floor
                }
                if let room = chair_dict["Room"] as? String {
                    print(room)
                    dibsChair.room = room
                }
                if let status = chair_dict["status"] as? String {
                    print(status)
                    dibsChair.status = status
                }
            }
        }) { (error) in
            print(error.localizedDescription)
        }
        print(dibsChair)
        return dibsChair
        
    }
    
    
    
    
}


