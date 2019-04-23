//
//  DataGateway.swift
//  chum
//
//  Created by James Saeed on 09/04/2019.
//  Copyright © 2019 James Saeed. All rights reserved.
//

import Foundation
import Firebase
import FirebaseStorage

class DataGateway {
    
    static let shared = DataGateway()
	
	private var REF_BASE: DatabaseReference { return Database.database().reference() }
	private var REF_USERS: DatabaseReference { return Database.database().reference().child("users") }
	private var REF_CHATS: DatabaseReference { return Database.database().reference().child("chats") }
	
	/// Creates a new user within the database with the required sign up info
	func createUser(_ uid: String, _ firstName: String, _ lastName: String, _ imageURL: String, dateOfBirth: Date, personalityTraits: [String: Bool], musicGenres: [String: Bool]) {
		REF_USERS.child(uid).updateChildValues([
			"firstName": firstName,
			"lastName": lastName,
			"imageURL": imageURL,
			"dateOfBirth": dateOfBirth.description
		])
		REF_USERS.child(uid).child("personalityTraits").updateChildValues(personalityTraits)
		REF_USERS.child(uid).child("musicGenres").updateChildValues(musicGenres)
	}
	
	func getUsers(completion: @escaping (_ users: [User]) -> ()) {
		REF_USERS.observeSingleEvent(of: .value) { (snapshot) in
			
		}
	}
	
	// Upload a user's profile image to Firebase storage
	func uploadImage(_ image: UIImage, for uid: String, completion: @escaping (_ url: String?) -> ()) {
		let ref = Storage.storage().reference().child("\(uid).png")
		ref.putData(image.pngData()!, metadata: nil) { (metadata, error) in
			ref.downloadURL(completion: { (url, _) in completion(url?.absoluteString) })
		}
	}
}
