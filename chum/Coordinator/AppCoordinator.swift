//
//  AppCoordinator.swift
//  chum
//
//  Created by James Saeed on 02/04/2019.
//  Copyright © 2019 James Saeed. All rights reserved.
//

import UIKit

class AppCoordinator: Coordinator {
    
    var navigationController: UINavigationController
    var tabBarController: UITabBarController
    
    var setupCoordinator: SetupCoordinator
    
    var matchesCoordinator: MatchesCoordinator
    var chatsCoordinator: ChatsCoordinator
    var settingsCoordinator: SettingsCoordinator
    
    init() {
        // Construct nav bar
        self.navigationController = UINavigationController()
        self.tabBarController = UITabBarController()
        self.tabBarController.tabBar.tintColor = UIColor(named: "app")
        
        self.setupCoordinator = SetupCoordinator()
        
        // Initialise matches tab
        self.matchesCoordinator = MatchesCoordinator()
        let matchesViewController = matchesCoordinator.navigationController
        matchesViewController.tabBarItem = UITabBarItem(title: "Matches", image: UIImage(named: "first"), tag: 0)
        
        // Initialise chats tab
        self.chatsCoordinator = ChatsCoordinator()
        let chatsViewController = chatsCoordinator.navigationController
        matchesViewController.tabBarItem = UITabBarItem(title: "Matches", image: UIImage(named: "first"), tag: 1)
        
        // Initialise settings tab
        self.settingsCoordinator = SettingsCoordinator()
        let settingsViewController = settingsCoordinator.navigationController
        settingsViewController.tabBarItem = UITabBarItem(title: "Settings", image: UIImage(named: "first"), tag: 2)
        
        // Provides the app level coordinator to the screens that need it
//        self.setupCoordinator.appCoordinator = self
        
        // Construct the tab bar
        self.tabBarController.viewControllers = [matchesViewController, chatsViewController, settingsViewController]
    }
    
    /// Open the setup screen
    func setup() {
        tabBarController.present(setupCoordinator.navigationController, animated: false, completion: nil)
    }
}
