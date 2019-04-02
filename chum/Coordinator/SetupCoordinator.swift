//
//  SetupCoordinator.swift
//  chum
//
//  Created by James Saeed on 02/04/2019.
//  Copyright © 2019 James Saeed. All rights reserved.
//

import UIKit

class SetupCoordinator: Coordinator {
    
    var navigationController: UINavigationController
 
    init() {
        // Construct nav bar
        self.navigationController = UINavigationController()
        self.navigationController.navigationBar.barStyle = UIBarStyle.blackTranslucent
        self.navigationController.navigationBar.isHidden = true
        self.navigationController.interactivePopGestureRecognizer?.isEnabled = false
        
        // Initialise and present the start screen
//        let vc = InitialViewController.instantiate()
//        vc.coordinator = self
//        navigationController.pushViewController(vc, animated: false)
    }
}
