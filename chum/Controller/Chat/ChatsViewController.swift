//
//  SecondViewController.swift
//  chum
//
//  Created by James Saeed on 31/03/2019.
//  Copyright © 2019 James Saeed. All rights reserved.
//

import UIKit

class ChatsViewController: UITableViewController, Storyboarded {
    
    weak var coordinator: ChatsCoordinator?
	
	var currentUser: User!
	var users = [User]() {
		didSet { tableView.reloadData() }
	}

    override func viewDidLoad() {
        super.viewDidLoad()
		
		loadUsers()
    }
	
	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return users.count
	}

	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		guard let cell = tableView.dequeueReusableCell(withIdentifier: "chatRow") else { return UITableViewCell() }
		cell.textLabel?.text = "\(users[indexPath.row].firstName) \(users[indexPath.row].lastName)"
		return cell
	}
	
	override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		let user = users[indexPath.row]
		coordinator?.openConversation(for: currentUser, with: user)
	}
}

// MARK: - Functionality

extension ChatsViewController {
	
	func loadUsers() {
		DataGateway.shared.getCurrentUser { (user) in self.currentUser = user }
		DataGateway.shared.getUsers { (users) in self.users = users }
	}
}
