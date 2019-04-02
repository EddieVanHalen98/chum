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
}
