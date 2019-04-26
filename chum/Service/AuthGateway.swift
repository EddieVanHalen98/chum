//
//  AuthGateway.swift
//  chum
//
//  Created by James Saeed on 14/04/2019.
//  Copyright © 2019 James Saeed. All rights reserved.
//

import Foundation
import FirebaseAuth

class AuthGateway {
    
    static let shared = AuthGateway()
	
	func getUserId() -> String {
		return Auth.auth().currentUser!.uid
	}
	
	func isLoggedIn() -> Bool {
		return Auth.auth().currentUser != nil
	}
    
    func createUser(email: String, password: String, completion: @escaping (_ error: Error?) -> ()) {
        Auth.auth().createUser(withEmail: email, password: password) { (authResult, error) in
            completion(error)
        }
    }
    
    func logIn(email: String, password: String, completion: @escaping (_ error: Error?) -> ()) {
        Auth.auth().signIn(withEmail: email, password: password) { (authResult, error) in
            completion(error)
        }
    }
	
	func logOut() {
		do {
			try Auth.auth().signOut()
		} catch _ { }
	}
}
