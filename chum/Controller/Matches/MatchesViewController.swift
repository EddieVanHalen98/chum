//
//  FirstViewController.swift
//  chum
//
//  Created by James Saeed on 31/03/2019.
//  Copyright © 2019 James Saeed. All rights reserved.
//

import UIKit

class MatchesViewController: UICollectionViewController, Storyboarded {
    
    weak var coordinator: MatchesCoordinator?
	
	var currentUser: User!
	var users = [User]() {
		didSet { collectionView.reloadData() }
	}

    override func viewDidLoad() {
        super.viewDidLoad()
    }
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		
		loadUsers()
	}
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return users.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "matchCell", for: indexPath) as? MatchCell else { return UICollectionViewCell() }
		
		cell.build(for: Match(currentUser: currentUser, matchedUser: users[indexPath.row]))
		
        return cell
    }
}

// MARK: - Functionality

extension MatchesViewController {
	
	func loadUsers() {
		DataGateway.shared.getCurrentUser { (user) in self.currentUser = user }
		DataGateway.shared.getUsers { (users) in self.users = users }
	}
}
