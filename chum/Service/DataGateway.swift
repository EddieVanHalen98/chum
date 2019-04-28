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
	private var REF_MATCHES: DatabaseReference { return Database.database().reference().child("matches") }
	
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
	
	func getCurrentUser(completion: @escaping (_ user: User) -> ()) {
		let uid = AuthGateway.shared.getUserId()
		
		REF_USERS.child(uid).observeSingleEvent(of: .value) { (snapshot) in
			guard let firstName = snapshot.childSnapshot(forPath: "firstName").value as? String else { return }
			guard let lastName = snapshot.childSnapshot(forPath: "lastName").value as? String else { return }
			guard let imageURL = snapshot.childSnapshot(forPath: "imageURL").value as? String else { return }
			guard let dateOfBirth = snapshot.childSnapshot(forPath: "dateOfBirth").value as? String else { return }
			guard let personalityTraits = snapshot.childSnapshot(forPath: "personalityTraits").value as? [String: Bool] else { return }
			guard let musicGenres = snapshot.childSnapshot(forPath: "musicGenres").value as? [String: Bool] else { return }
			
			completion(User(uid: uid, firstName: firstName, lastName: lastName, imageURL: URL(string: imageURL)!, dateOfBirth: dateOfBirth, personalityTraits: personalityTraits, musicGenres: musicGenres))
		}
	}
	
	func getUsers(completion: @escaping (_ users: [User]) -> ()) {
		var users = [User]()
		
		REF_USERS.observeSingleEvent(of: .value) { (snapshot) in
			guard let snapshot = snapshot.children.allObjects as? [DataSnapshot] else { return }
			
			for user in snapshot {
				let id = user.key
				if id == AuthGateway.shared.getUserId() { continue }
				
				guard let firstName = user.childSnapshot(forPath: "firstName").value as? String else { continue }
				guard let lastName = user.childSnapshot(forPath: "lastName").value as? String else { continue }
				guard let imageURL = user.childSnapshot(forPath: "imageURL").value as? String else { continue }
				guard let dateOfBirth = user.childSnapshot(forPath: "dateOfBirth").value as? String else { continue }
				guard let personalityTraits = user.childSnapshot(forPath: "personalityTraits").value as? [String: Bool] else { continue }
				guard let musicGenres = user.childSnapshot(forPath: "musicGenres").value as? [String: Bool] else { continue }
				
				users.append(User(uid: id, firstName: firstName, lastName: lastName, imageURL: URL(string: imageURL)!, dateOfBirth: dateOfBirth, personalityTraits: personalityTraits, musicGenres: musicGenres))
			}
			
			completion(users)
		}
	}
	
	// Upload a user's profile image to Firebase storage
	func uploadImage(_ image: UIImage, for uid: String, completion: @escaping (_ url: String?) -> ()) {
		let ref = Storage.storage().reference().child("\(uid).png")
		ref.putData(image.pngData()!, metadata: nil) { (metadata, error) in
			ref.downloadURL(completion: { (url, _) in completion(url?.absoluteString) })
		}
	}
	
	func sendMatchRequest(to targetUser: User) {
		REF_MATCHES.child(targetUser.uid).child(AuthGateway.shared.getUserId()).updateChildValues(["status": "request"])
	}
	
	func acceptMatchRequest(from targetUser: User) {
		REF_MATCHES.child(AuthGateway.shared.getUserId()).child(targetUser.uid).updateChildValues(["status": "matched"])
		REF_MATCHES.child(targetUser.uid).child(AuthGateway.shared.getUserId()).updateChildValues(["status": "matched"])
	}
	
	func declineMatchRequest(from targetUser: User) {
		REF_MATCHES.child(AuthGateway.shared.getUserId()).child(targetUser.uid).removeValue()
	}
	
	func getMatchStatuses(completion: @escaping (_ statuses: [String: String]) -> ()) {
		var statuses = [String: String]()
		
		REF_MATCHES.child(AuthGateway.shared.getUserId()).observeSingleEvent(of: .value) { (snapshot) in
			guard let snapshot = snapshot.children.allObjects as? [DataSnapshot] else { return }
			
			for user in snapshot {
				let id = user.key
				guard let status = user.childSnapshot(forPath: "status").value as? String else { continue }
				
				if status != "waiting" { statuses[id] = status }
			}
			
			completion(statuses)
		}
	}
}
