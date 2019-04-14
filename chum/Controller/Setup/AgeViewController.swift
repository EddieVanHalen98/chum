//
//  AgeViewController.swift
//  chum
//
//  Created by James Saeed on 14/04/2019.
//  Copyright © 2019 James Saeed. All rights reserved.
//

import UIKit

class AgeViewController: UIViewController, Storyboarded {

    weak var coordinator: SetupCoordinator?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
}
