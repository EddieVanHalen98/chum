//
//  InitialViewController.swift
//  chum
//
//  Created by James Saeed on 14/04/2019.
//  Copyright © 2019 James Saeed. All rights reserved.
//

import UIKit

class LogInViewController: UIViewController, Storyboarded {

    weak var coordinator: SetupCoordinator?
    
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    @IBAction func logInButtonPressed(_ sender: Any) {
        if let email = emailField.text, let password = passwordField.text {
            AuthGateway.shared.logIn(email: email, password: password) { (error) in
                if error == nil {
                    self.coordinator?.appCoordinator?.goHome()
                } else {
                    print(error?.localizedDescription)
                }
            }
        }
    }
    
    @IBAction func registerButtonPressed(_ sender: Any) {
        if let email = emailField.text, let password = passwordField.text {
            AuthGateway.shared.createUser(email: email, password: password) { (error) in
                if error == nil {
					self.coordinator?.askForPersonalInfo()
                } else {
                    print(error?.localizedDescription)
                }
            }
        }
    }
}
