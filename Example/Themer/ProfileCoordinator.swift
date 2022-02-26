//
//  ProfileCoordinator.swift
//  temp
//
//  Created by Ivan Stajcer on 11.02.2022..
//  Copyright (c) 2022 ___ORGANIZATIONNAME___. All rights reserved.
//
//  This file was generated by the 🐍 VIPER generator
//

import Foundation
import UIKit
import Themer

final class ProfileCoordinator: Coordinator {
    let navigationController: UINavigationController?

    init() {
        self.navigationController = UINavigationController(navigationBarClass: ThemedNavigationBar.self, toolbarClass: nil)
    }
}

// MARK: - Public methods
extension ProfileCoordinator {
    func start() -> UIViewController {
        let viewController = ProfileViewController()
        let profileViewController = viewController
        navigationController?.viewControllers = [profileViewController]
        return navigationController!
    }
}
