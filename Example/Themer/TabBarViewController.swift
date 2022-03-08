//
//  TabBarViewController.swift
//  temp
//
//  Created by Ivan Stajcer on 11.02.2022..
//

import Foundation
import UIKit

class TabBarViewController: UITabBarController {
    
    // MARK: - Properties -
    
    var coordinators: [Coordinator] = []
    
    // MARK: - Lifecycle -
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupHome()
        setupProfile()
    }
}

// MARK: - Private methods -

extension TabBarViewController {
    func setupHome() {
        let homeCoordinator = HomeCoordinator()
        coordinators.append(homeCoordinator)
        let viewController = homeCoordinator.start()
        viewController.tabBarItem = UITabBarItem(tabBarSystemItem: .bookmarks, tag: 0)
        viewControllers = [viewController]
    }
    
    func setupProfile() {
        let profileCoordinator = ProfileCoordinator()
        coordinators.append(profileCoordinator)
        let viewController = profileCoordinator.start()
        viewController.tabBarItem = UITabBarItem(tabBarSystemItem: .favorites, tag: 1)
        viewControllers?.append(viewController)
    }
}
