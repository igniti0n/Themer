//
//  HomeCoordinator.swift
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

final class HomeCoordinator: Coordinator {
    let navigationController: UINavigationController?

    init() {
        self.navigationController = UINavigationController(navigationBarClass: ThemedNavigationBar.self, toolbarClass: nil)
    }
    func start() -> UIViewController {
        let homeViewController = HomeViewController()
        navigationController?.viewControllers = [homeViewController]
        return navigationController!
    }
}