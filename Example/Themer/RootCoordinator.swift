//
//  RootCoordinator.swift
//  temp
//
//  Created by Ivan Stajcer on 12.02.2022..
//

import Foundation
import UIKit

class RootCoordinator: Coordinator {
    var childCoordinator: Coordinator?
    
    func start() -> UIViewController {
        let tabBarCoordinator = TabBarCoordinator()
        childCoordinator = tabBarCoordinator
        let vc = tabBarCoordinator.start()
        return vc
    }
}
