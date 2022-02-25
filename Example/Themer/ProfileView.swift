//
//  TempView.swift
//  temp
//
//  Created by Ivan Stajcer on 07.02.2022..
//

import Foundation
import UIKit
import Themer

final class ProfileView: UIView {
    // MARK: - Propertie
    private lazy  var tableView = ThemedTableView()
    private lazy var imageView = ThemedImageView(namedLight: "light", namedDark: "dark")
    private lazy var v2 = ThemedButton()
    private lazy var themedView = CustomThemedView()
    private lazy var c =  CustomThemedButton()
    private lazy var v4 = CustomThemedButton()
    private lazy var v5 = ThemedButton()
    private lazy var v6 = ThemedButton()
    private lazy var sw = UISwitch()

    // MARK: - Initi
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupViews()
    }
}

// MARK: - Public methods
extension ProfileView {
    func reloadView() {
        tableView.reloadData()
    }
    func setupTableViewDelegateAndDataSource(to delegate: UITableViewDelegate & UITableViewDataSource) {
        tableView.delegate = delegate
        tableView.dataSource = delegate
    }
}

// MARK: - Private methods
private extension ProfileView {
    func setupViews() {
        backgroundColor = .white
    }

    @objc func lightThemeTapped() {
        ThemeManager.shared.apply(.light)
    }
    
    @objc func darkThemeTapped() {
        ThemeManager.shared.apply(.dark)
    }
    
    @objc func systemThemeTapped() {
        ThemeManager.shared.apply(.systemDefault)
    }
}

