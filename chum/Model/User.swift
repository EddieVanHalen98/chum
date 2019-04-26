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
	var firstName: String
	var lastName: String
	var imageURL: URL
	var dateOfBirth: String
	var personalityTraits: [String: Bool]
	var musicGenres: [String: Bool]
}

struct Match {
	
    let currentUser: User
	let matchedUser: User
	
	var rating: Double {
		return 8.6
	}
}
