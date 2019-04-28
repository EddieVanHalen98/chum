//
//  SettingsViewController.swift
//  chum
//
//  Created by James Saeed on 23/04/2019.
//  Copyright © 2019 James Saeed. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController, Storyboarded {

	var coordinator: SettingsCoordinator?
	
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
	
	@IBAction func logOut(_ sender: Any) {
		AuthGateway.shared.logOut()
	}
	
	@IBAction func deleteAccount(_ sender: Any) {
		AuthGateway.shared.deleteAccount()
	}
}
