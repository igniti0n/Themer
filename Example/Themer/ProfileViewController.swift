//
//  ProfileViewController.swift
//  temp
//
//  Created by Ivan Stajcer on 11.02.2022..
//  Copyright (c) 2022 ___ORGANIZATIONNAME___. All rights reserved.
//
//  This file was generated by the 🐍 VIPER generator
//

import Foundation
import UIKit

final class ProfileViewController: UIViewController {
    
    // MARK: - Properties -
    
    private let mainView = ProfileView()
    private let tableDataSource = ["hello","hi","some data","I am themed cell"]
    
    // MARK: - Lifecycle -
    
    override func loadView() {
        super.loadView()
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mainView.setupTableViewDelegateAndDataSource(to: self)
        navigationItem.title = "Profile"
    }
}


// MARK: - UITableViewDelegate methods -

extension ProfileViewController: UITableViewDelegate {}

// MARK: - UITableViewDataSource methods -

extension ProfileViewController:  UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        tableDataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ProfileTableViewCell.reuseIdentifier) as! ProfileTableViewCell
        cell.updateCell(with: tableDataSource[indexPath.row])
        return cell
    }
}
