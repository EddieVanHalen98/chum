//
//  ChatsCoordinator.swift
//  chum
//
//  Created by James Saeed on 02/04/2019.
//  Copyright © 2019 James Saeed. All rights reserved.
//

import UIKit

class ChatsCoordinator: Coordinator {
    
    var navigationController: UINavigationController
    
    init() {
        // Construct nav bar
        self.navigationController = UINavigationController()
        self.navigationController.navigationBar.prefersLargeTitles = true
        self.navigationController.navigationBar.tintColor = UIColor(named: "primary")
        
        // Initialise and present the today screen
        let vc = ChatsViewController.instantiate()
        vc.coordinator = self
        navigationController.pushViewController(vc, animated: false)
    }
	
	func showRequestAlert(for currentUser: User, with targetUser: User) {
		let alert = UIAlertController(title: "Match request", message: "\(targetUser.firstName) has sent you a match request, would you like to accept or decline?", preferredStyle: .alert)
		alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
		alert.addAction(UIAlertAction(title: "Decline", style: .destructive, handler: { (action) in
			DataGateway.shared.declineMatchRequest(from: targetUser)
		}))
		alert.addAction(UIAlertAction(title: "Accept", style: .default, handler: { (action) in
			DataGateway.shared.acceptMatchRequest(from: targetUser)
			ChatGateway.shared.createNewChat(forMembers: [currentUser, targetUser])
			self.openConversation(for: currentUser, with: targetUser)
		}))
		navigationController.present(alert, animated: true, completion: nil)
	}
	
	func openConversation(for sender: User, with recipient: User) {
		let vc = ConversationViewController.instantiate()
		vc.coordinator = self
		vc.sender = sender
		vc.recipient = recipient
		navigationController.pushViewController(vc, animated: true)
	}
}
