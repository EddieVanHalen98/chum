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
    
    func showMatch() {
        let vc = DetailedMatchViewController.instantiate()
        vc.coordinator = self
        navigationController.pushViewController(vc, animated: true)
    }
}
