//
//  TabBarViewController.swift
//  temp
//
//  Created by Ivan Stajcer on 11.02.2022..
//

import Foundation
import UIKit

class TabBarViewController: UITabBarController {
    var coordinators: [Coordinator] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupHome()
        setupProfile()
        UITabBar.appearance().backgroundColor = .systemBrown
    }
    
    func setupHome() {
        let hc = HomeCoordinator()
        coordinators.append(hc)
        let vc = hc.start()
        vc.tabBarItem = UITabBarItem(tabBarSystemItem: .bookmarks, tag: 0)
        viewControllers = [vc]
    }
    
    func setupProfile() {
        let pc = ProfileCoordinator(parent: self)
        coordinators.append(pc)
        let vc = pc.start()
        vc.tabBarItem = UITabBarItem(tabBarSystemItem: .favorites, tag: 1)
        viewControllers?.append(vc)
    }
}
