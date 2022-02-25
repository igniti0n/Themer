//
//  TabBarViewController.swift
//  temp
//
//  Created by Ivan Stajcer on 11.02.2022..
//

import Foundation
import Foundation
import UIKit

class TabBarCoordinator: Coordinator {
    let tabBarController = TabBarViewController()
    
    func start() -> UIViewController {
        return tabBarController
    }
}
