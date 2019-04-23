//
//  PersonalViewController.swift
//  chum
//
//  Created by James Saeed on 21/04/2019.
//  Copyright © 2019 James Saeed. All rights reserved.
//

import UIKit

class PersonalViewController: UIViewController, Storyboarded {
	
	weak var coordinator: SetupCoordinator?

	@IBOutlet weak var firstNameField: UITextField!
	@IBOutlet weak var lastNameField: UITextField!
	@IBOutlet weak var profileImageUploadButton: UIButtonX!
	
	override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
	
	@IBAction func profileImageUploadButtonPressed(_ sender: Any) {
		showImagePicker()
	}
	
	@IBAction func nextButtonPressed(_ sender: Any) {
		coordinator?.firstName = firstNameField.text
		coordinator?.lastName = lastNameField.text
		coordinator?.askForDateOfBirth()
	}
}

// MARK: - Image Picker

extension PersonalViewController: UINavigationControllerDelegate, UIImagePickerControllerDelegate {
	
	func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
		if let pickedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
			DataGateway.shared.uploadImage(pickedImage, for: AuthGateway.shared.getUserId()) { (url) in
				self.coordinator?.imageURL = url
			}
		}
		picker.dismiss(animated: true, completion: nil)
	}
}

// MARK: - Functionality

extension PersonalViewController {
	
	func showImagePicker() {
		let imagePicker = UIImagePickerController()
		imagePicker.delegate = self
		imagePicker.sourceType = .photoLibrary
		present(imagePicker, animated: true, completion: nil)
	}
}
