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
	
	var rating: String {
		if let prediction = try? RatingPredictor().prediction(personality: commonPersonalityTraits(), music: commonMusicGenres()) {
			let rating = (prediction.rating - 1).rounded(toPlaces: 1)
			return (rating >= 10) ? "10" : "\(rating)"
		} else {
			return "0.0"
		}
	}
	
	private func commonPersonalityTraits() -> Double {
		var count = 0.0
		for key in currentUser.personalityTraits.keys {
			if currentUser.personalityTraits[key]! && matchedUser.personalityTraits[key]! {
				count += 1
			}
		}
		return count
	}
	
	private func commonMusicGenres() -> Double {
		var count = 0.0
		for key in currentUser.musicGenres.keys {
			if currentUser.musicGenres[key]! && matchedUser.musicGenres[key]! {
				count += 1
			}
		}
		return count
	}
}
