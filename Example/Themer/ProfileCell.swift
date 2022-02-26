//
//  ProfileCell.swift
//  temp
//
//  Created by Ivan Stajcer on 23.02.2022..
//

import Foundation
import UIKit
import Themer

final class ProfileTableViewCell: ThemedTableViewCell {
    static let reuseIdentifier = "ProfileTableViewCell"
    private lazy var label = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupViews()
    }
}

// MARK: - Public meethods
extension ProfileTableViewCell {
    func updateCell(with text: String) {
        label.text = text
    }
}

// MARK: - Prvate meethods
private extension ProfileTableViewCell {
    func setupViews() {
        setupLabel()
    }
    
    func setupLabel() {
        addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            label.centerYAnchor.constraint(equalTo: centerYAnchor),
            label.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
    }
}
