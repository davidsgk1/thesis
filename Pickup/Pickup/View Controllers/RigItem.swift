//
//  RigItem.swift
//  Pickup
//
//  Created by Keegan Davidson on 4/21/19.
//  Copyright © 2019 Keegan Davidson. All rights reserved.
//

import Foundation
import Firebase

struct RigItem {
    
    let ref: DatabaseReference?
    let key: String
    let type: String
    let name: String
    let color: String
    let serialNum: String
    let year: String
    let extras: String
    
    init(type: String, name: String, color: String, year: String, serialNum: String, extras: String, key: String = "") {
        self.ref = nil
        self.key = key
        self.type = type
        self.name = name
        self.color = color
        self.year = year
        self.serialNum = serialNum
        self.extras = extras
    }
    
    init?(snapshot: DataSnapshot) {
        guard
            let value = snapshot.value as? [String: AnyObject],
            let type = value["type"] as? String,
            let name = value["name"] as? String,
            let color = value["color"] as? String,
            let year = value["year"] as? String,
            let serialNum = value["serial-num"] as? String,
            let extras = value["extras"] as? String else {
                return nil
        }
        
        self.ref = snapshot.ref
        self.key = snapshot.key
        self.type = type
        self.name = name
        self.color = color
        self.year = year
        self.serialNum = serialNum
        self.extras = extras
    }
    
    func toAnyObject() -> Any {
        return [
            "type": type,
            "name": name,
            "color": color,
            "year": year,
            "serial-num": serialNum,
            "extras": extras
        ]
    }
    
}
