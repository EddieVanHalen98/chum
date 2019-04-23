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
	
	var firstName: String?
	var lastName: String?
	var imageURL: String?
	var dateOfBirth: Date?
	var personalityTraits: [String: Bool]?
	var musicGenres: [String: Bool]?
 
    init() {
        // Construct nav bar
        self.navigationController = UINavigationController()
        self.navigationController.navigationBar.barStyle = UIBarStyle.blackTranslucent
        self.navigationController.navigationBar.isHidden = true
        self.navigationController.interactivePopGestureRecognizer?.isEnabled = false
        
        // Initialise and present the start screen
        let vc = LogInViewController.instantiate()
//		let vc = PersonalityViewController.instantiate()
        vc.coordinator = self
        navigationController.pushViewController(vc, animated: false)
    }
	
	func askForPersonalInfo() {
		let vc = PersonalViewController.instantiate()
		vc.coordinator = self
		navigationController.pushViewController(vc, animated: true)
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
		DataGateway.shared.createUser(AuthGateway.shared.getUserId(), firstName!, lastName!, imageURL!, dateOfBirth: dateOfBirth!, personalityTraits: personalityTraits!, musicGenres: musicGenres!)
        appCoordinator?.goHome()
    }
}
