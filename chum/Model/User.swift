//
//  Match.swift
//  chum
//
//  Created by James Saeed on 06/04/2019.
//  Copyright © 2019 James Saeed. All rights reserved.
//

import Foundation

struct User {
    
    let uid: String
    let name: String
	let dateOfBirth: Date
    let imageURL: URL
}

struct Match {
    
    let rating: Double
    let user: User
}

enum PersonalityTrait: String {
	case test
}

enum MusicGenre: String {
	case test
}
