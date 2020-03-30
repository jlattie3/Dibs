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
    var thisDibsChairList: [DibsChair] = []
    var count: Int = 0
    var validRead: Bool = false
    var spotDict = Dictionary<String, Int>()
    
    init(ref: DatabaseReference) {
        self.ref = ref
//        readTest()
//        print(self.thisDibsChairList)
    }
    
    
    func readTest() {
        
        self.ref.child("chair").observeSingleEvent(of: .value, with: { (snapshot) in
            
            guard let value = snapshot.value as? NSDictionary else {
                print("Invalid Firebase Read")
                return
            }
            
            print(".")
            let keys = value.allKeys
            print("Keys: ")
            print(keys)
            print(".")
            self.count = 10000
            self.thisDibsChairList = [DibsChair()]
            self.spotDict = self.getDictOfDibsBuildings()
        
        }) { (error) in
            print("readAllChairs error")
            print(error.localizedDescription)
        }
        
    }
    
    func didRecieve(boolean: Bool) {
        self.validRead = boolean
    }
    

    func readAllChairs() {
        
        var dibsChairList = [DibsChair]()
        
        self.count = 7
        
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
            
            self.count = 10
            
            for key in keys {
                
                let dibsChair = DibsChair()
                
                if let chair_dict = value[key] as? NSDictionary {
                    
                    print("------")
                    
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
                    print("------")
                } else {
                    continue
                }
                
            }
            self.thisDibsChairList = dibsChairList
            self.spotDict = self.getDictOfDibsBuildings()
            print(".")
            print(".")
            print(".")
            
            if dibsChairList.isEmpty {
                self.didRecieve(boolean: false)
            } else {
                self.didRecieve(boolean: true)
            }
//            print(dibsChairList)
//            self.thisDibsChairList = dibsChairList
//            self.validRead = true
            
        }) { (error) in
            print("readAllChairs error")
            print(error.localizedDescription)
        }
        
        print("Here")
        print(dibsChairList)
        print(self.thisDibsChairList)
        
    }
    
    func getDictOfDibsBuildings() -> Dictionary<String, Int> {
        
        var buildingDict = Dictionary<String, Int>()
        
        for chair in self.thisDibsChairList {
            buildingDict[chair.building, default: 0] += 1
        }
        print(buildingDict)
        return buildingDict
    }
    
    func createDibsCellsFromDatabase() -> [DibsCell] {
    
        var dibsCellList: [DibsCell] = []

        let buildingDict = getDictOfDibsBuildings()
        
        print("ahhh")
        print(buildingDict)
        
        for (key, buildingCount) in buildingDict {
            let cell = DibsCell()
            
            cell.locationLabel.text = key
            cell.spotCountLabel.text = String(buildingCount)
            
            dibsCellList.append(cell)
        }
        
        return dibsCellList
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


