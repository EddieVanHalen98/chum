//
//  Match.swift
//  chum
//
//  Created by James Saeed on 06/04/2019.
//  Copyright © 2019 James Saeed. All rights reserved.
//

import Foundation
import FirebaseDatabase

struct User {
    
    let uid: String
    let name: String
    let imageURL: URL
    
    init(uid: String, name: String, imageURL: URL) {
        self.uid = uid
        self.name = name
        self.imageURL = imageURL
    }
    
    init(snapshot: DataSnapshot) {
        let snapshotValue = snapshot.value as! [String: AnyObject]
        
        uid = snapshot.key
        name = snapshotValue["name"] as! String
        imageURL = URL(string: snapshotValue["imageURL"] as! String)!
    }
    
    func databaseObject() -> Any {
        return [
            "name": name
        ]
    }
}

struct Match {
    
    let rating: Double
    let user: User
}
