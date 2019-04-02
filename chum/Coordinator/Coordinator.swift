//
//  Coordinator.swift
//  chum
//
//  Created by James Saeed on 13/09/2018.
//  Copyright © 2018 James Saeed. All rights reserved.
//

import UIKit

protocol Coordinator {
    
    var navigationController: UINavigationController { get set }
    
}

protocol Storyboarded {
    
    static func instantiate() -> Self
}

extension Storyboarded where Self: UIViewController {
    
    static func instantiate() -> Self {
        let fullName = NSStringFromClass(self)
        let className = fullName.components(separatedBy: ".")[1]
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        
        return storyboard.instantiateViewController(withIdentifier: className) as! Self
    }
}
