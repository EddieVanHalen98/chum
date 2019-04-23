//
//  AgeViewController.swift
//  chum
//
//  Created by James Saeed on 14/04/2019.
//  Copyright © 2019 James Saeed. All rights reserved.
//

import UIKit
import Magnetic

class AgeViewController: UIViewController, Storyboarded {

    weak var coordinator: SetupCoordinator?
    
	@IBOutlet weak var datePicker: UIDatePicker!
	
	override func viewDidLoad() {
        super.viewDidLoad()
    }
	
	@IBAction func nextButtonPressed(_ sender: Any) {
		coordinator?.dateOfBirth = datePicker.date
		coordinator?.askForPersonalityTraits()
	}
	
	override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
}

// MARK: - Functionality

extension AgeViewController {
	
	func saveDateOfBirth() {
		// TODO
	}
}
