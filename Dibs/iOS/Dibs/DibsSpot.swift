//
//  DibsSpot.swift
//  Dibs
//
//  Created by Jacob Lattie on 3/10/20.
//  Copyright © 2020 Jacob Lattie. All rights reserved.
//

import Foundation

class DibsChair {
    
    var MAC_addr: String
    var building: String
    var chairID: String
    var floor: String
    var room: String
    var status: String
    
    init() {
        print("Empty Init")
        self.MAC_addr = ""
        self.building = ""
        self.chairID = ""
        self.floor = ""
        self.room = ""
        self.status = ""
    }
    
    init(MAC_addr: String, building: String, chairID:String, floor: String, room: String, status: String) {
        self.MAC_addr = MAC_addr
        self.building = building
        self.chairID = chairID
        self.floor = floor
        self.room = room
        self.status = status
        
//        print("DibsChair Stats")
//        print(self.MAC_addr)
//        print(building)
//        print(floor)
//        print(status)
        
    }
    
    
    
}
