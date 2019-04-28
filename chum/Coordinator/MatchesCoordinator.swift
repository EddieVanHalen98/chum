//
//  MatchesCoordinator.swift
//  chum
//
//  Created by James Saeed on 02/04/2019.
//  Copyright © 2019 James Saeed. All rights reserved.
//

import UIKit

class MatchesCoordinator: Coordinator {
    
    var navigationController: UINavigationController
    
    init() {
        // Construct nav bar
        self.navigationController = UINavigationController()
        self.navigationController.navigationBar.prefersLargeTitles = true
        self.navigationController.navigationBar.tintColor = UIColor(named: "primary")
        
        // Initialise and present the today screen
        let vc = MatchesViewController.instantiate()
        vc.coordinator = self
        navigationController.pushViewController(vc, animated: false)
    }
	
	func showRequestAlert(for targetUser: User) {
		let alert = UIAlertController(title: "Send match request", message: "Send a match request to \(targetUser.firstName)?", preferredStyle: .alert)
		alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action) in
			DataGateway.shared.sendMatchRequest(to: targetUser)
		}))
		alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
		navigationController.present(alert, animated: true, completion: nil)
	}
    
    func showMatch() {
        let vc = DetailedMatchViewController.instantiate()
        vc.coordinator = self
        navigationController.pushViewController(vc, animated: true)
    }
}
