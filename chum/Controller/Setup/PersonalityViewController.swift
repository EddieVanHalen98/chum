//
//  PersonalityViewController.swift
//  chum
//
//  Created by James Saeed on 14/04/2019.
//  Copyright © 2019 James Saeed. All rights reserved.
//

import UIKit
import Magnetic

class PersonalityViewController: UIViewController, Storyboarded {

    weak var coordinator: SetupCoordinator?
	
	@IBOutlet weak var magneticView: MagneticView!
	var magnetic: Magnetic?
	
	var personalityTraits = [
		"outgoing": false,
		"introverted": false,
		"sporty": false,
		"cheerful": false,
		"honest": false,
		"mature": false,
		"playful": false,
		"bookworm": false,
		"foodie": false,
		"nerdy": false,
		"musician": false,
		"funny": false,
		"adventerous": false,
		"sensitive": false,
		"impulsive": false,
		"impatient": false,
	]
    
    override func viewDidLoad() {
        super.viewDidLoad()
		
		initialiseMagnetic()
    }
    
	@IBAction func nextButtonPressed(_ sender: Any) {
		coordinator?.personalityTraits = personalityTraits
		coordinator?.askForMusicGenres()
	}
	
	override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
}

// MARK: - Magnetic

extension PersonalityViewController: MagneticDelegate {
	
	func initialiseMagnetic() {
		magnetic = magneticView.magnetic
		magnetic?.magneticDelegate = self
		magnetic?.backgroundColor = UIColor(named: "primary")!
		
		for key in personalityTraits.keys {
			let node = Node(text: key, image: nil, color: UIColor(named: "primaryLight")!, radius: 40)
			node.strokeColor = .clear
			magnetic?.addChild(node)
		}
	}
	
	func magnetic(_ magnetic: Magnetic, didSelect node: Node) {
		node.color = UIColor(named: "secondaryLight")!
		personalityTraits[node.text!] = true
	}
	
	func magnetic(_ magnetic: Magnetic, didDeselect node: Node) {
		node.color = UIColor(named: "primaryLight")!
		personalityTraits[node.text!] = false
	}
}
