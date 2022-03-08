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
    
    // MARK: - Properties -
    
    private lazy  var tableView = ThemedTableView()
    private lazy var imageViewTinted = ThemedImageView(namedTinted: "home")
    private lazy var imageView = ThemedImageView(namedAny: "light")
    private lazy var customThemedView = CustomThemedView()
    private lazy var lightButton = CustomThemedButton()
    private lazy var darkButton = ThemedButton()
    
    // MARK: - Init -
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupViews()
    }
}

// MARK: - Public methods -

extension ProfileView {
    func reloadView() {
        tableView.reloadData()
    }
    func setupTableViewDelegateAndDataSource(to delegate: UITableViewDelegate & UITableViewDataSource) {
        tableView.delegate = delegate
        tableView.dataSource = delegate
    }
}

// MARK: - Private methods -

private extension ProfileView {
    func setupViews() {
        backgroundColor = .white
        setupTableView()
        setupImageView()
        setupTintedImageView()
        setupCustomThemedView()
        setupLightButton()
        setupDarkButton()
    }
    
    func setupTableView() {
        addSubview(tableView)
        tableView.backgroundColor = .orange
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 20),
            tableView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 20),
            tableView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -20),
            tableView.heightAnchor.constraint(equalToConstant: 200),
        ])
        tableView.register(ProfileTableViewCell.self, forCellReuseIdentifier: ProfileTableViewCell.reuseIdentifier)
    }
    
    func setupImageView() {
        addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: tableView.bottomAnchor, constant: 20),
            imageView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 40),
            imageView.heightAnchor.constraint(equalToConstant: 64),
            imageView.widthAnchor.constraint(equalToConstant: 84)
        ])
        imageView.contentMode = .scaleAspectFit
    }
    
    func setupTintedImageView() {
        addSubview(imageViewTinted)
        imageViewTinted.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            imageViewTinted.topAnchor.constraint(equalTo: tableView.bottomAnchor, constant: 20),
            imageViewTinted.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -40),
            imageViewTinted.heightAnchor.constraint(equalToConstant: 64),
            imageViewTinted.widthAnchor.constraint(equalToConstant: 84)
        ])
        imageViewTinted.contentMode = .scaleAspectFit
    }
    
    func setupCustomThemedView() {
        addSubview(customThemedView)
        customThemedView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            customThemedView.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 10),
            customThemedView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            customThemedView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            customThemedView.heightAnchor.constraint(equalToConstant: 68)
        ])
    }
    
    func setupLightButton() {
        customThemedView.addSubview(lightButton)
        lightButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            lightButton.topAnchor.constraint(equalTo: customThemedView.topAnchor, constant: 10),
            lightButton.leadingAnchor.constraint(equalTo: customThemedView.leadingAnchor, constant: 20),
            lightButton.trailingAnchor.constraint(equalTo: customThemedView.trailingAnchor, constant: -20),
            lightButton.bottomAnchor.constraint(equalTo: customThemedView.bottomAnchor, constant: -10),
        ])
        lightButton.setTitle("Light mode", for: .normal)
        lightButton.addTarget(self, action: #selector(lightThemeTapped), for: .touchUpInside)
    }
    
    func setupDarkButton() {
        addSubview(darkButton)
        darkButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            darkButton.topAnchor.constraint(equalTo: customThemedView.bottomAnchor, constant: 10),
            darkButton.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor),
            darkButton.heightAnchor.constraint(equalToConstant: 48),
            darkButton.widthAnchor.constraint(equalToConstant: 264)
        ])
        darkButton.setTitle("Dark mode", for: .normal)
        darkButton.addTarget(self, action: #selector(darkThemeTapped), for: .touchUpInside)
        
    }
    
    @objc func lightThemeTapped() {
        Themer.shared.apply(.light)
    }
    
    @objc func darkThemeTapped() {
        Themer.shared.apply(.dark)
    }
}

