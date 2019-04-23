//
//  MusicViewController.swift
//  chum
//
//  Created by James Saeed on 14/04/2019.
//  Copyright © 2019 James Saeed. All rights reserved.
//

import UIKit
import Magnetic

class MusicViewController: UIViewController, Storyboarded {

    weak var coordinator: SetupCoordinator?
    
	@IBOutlet weak var magneticView: MagneticView!
	var magnetic: Magnetic?
	
	var musicGenres = [
		"rock": false,
		"rnb": false,
		"jazz": false,
		"indie": false,
		"alternative": false,
		"blues": false,
		"rap": false,
		"classical": false,
		"pop": false,
		"metal": false,
		"electronic": false,
		"hip hop": false,
		"country": false,
		"house": false,
		"theatre": false,
		"punk": false,
	]
	
	override func viewDidLoad() {
        super.viewDidLoad()

		initialiseMagnetic()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
	
	@IBAction func finishButtonPressed(_ sender: Any) {
		coordinator?.musicGenres = musicGenres
		coordinator?.finishSetup()
	}
}

// MARK: - Magnetic

extension MusicViewController: MagneticDelegate {
	
	func initialiseMagnetic() {
		magnetic = magneticView.magnetic
		magnetic?.magneticDelegate = self
		magnetic?.backgroundColor = UIColor(named: "primary")!
		
		for key in musicGenres.keys {
			let node = Node(text: key, image: nil, color: UIColor(named: "primaryLight")!, radius: 40)
			node.strokeColor = .clear
			magnetic?.addChild(node)
		}
	}
	
	func magnetic(_ magnetic: Magnetic, didSelect node: Node) {
		node.color = UIColor(named: "secondaryLight")!
		musicGenres[node.text!] = true
	}
	
	func magnetic(_ magnetic: Magnetic, didDeselect node: Node) {
		node.color = UIColor(named: "primaryLight")!
		musicGenres[node.text!] = false
	}
}
