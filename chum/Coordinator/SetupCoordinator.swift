//
//  SetupCoordinator.swift
//  chum
//
//  Created by James Saeed on 02/04/2019.
//  Copyright © 2019 James Saeed. All rights reserved.
//

import UIKit

class SetupCoordinator: Coordinator {
    
    weak var appCoordinator: AppCoordinator?
    
    var navigationController: UINavigationController
 
    init() {
        // Construct nav bar
        self.navigationController = UINavigationController()
        self.navigationController.navigationBar.barStyle = UIBarStyle.blackTranslucent
        self.navigationController.navigationBar.isHidden = true
        self.navigationController.interactivePopGestureRecognizer?.isEnabled = false
        
        // Initialise and present the start screen
        let vc = LogInViewController.instantiate()
        vc.coordinator = self
        navigationController.pushViewController(vc, animated: false)
    }
    
    func askForDateOfBirth() {
        let vc = AgeViewController.instantiate()
        vc.coordinator = self
        navigationController.pushViewController(vc, animated: true)
    }
    
    func askForPersonalityTraits() {
        let vc = PersonalityViewController.instantiate()
        vc.coordinator = self
        navigationController.pushViewController(vc, animated: true)
    }
    
    func askForMusicGenres() {
        let vc = MusicViewController.instantiate()
        vc.coordinator = self
        navigationController.pushViewController(vc, animated: true)
    }
    
    func finishSetup() {
        appCoordinator?.goHome()
    }
}
