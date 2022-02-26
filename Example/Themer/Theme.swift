//
//  Theme.swift
//  temp
//
//  Created by Ivan Stajcer on 15.02.2022..
//

import Foundation
import UIKit
import Themer

class DarkTheme: ApplicationTheme {
    var theme: Theme = Theme(
        assets: ThemeAssets(
            labelAssets: LabelAssets(
                color: .orange,
                font: .systemFont(ofSize: 48),
                backgroundColor: .white
            ),
            buttonAssets: ButtonAssets(
                buttonColor: .black,
                titleColor: .white,
                font: .systemFont(ofSize: 28),
                cornerRadius: 80,
                borderColor: .systemPurple,
                borderWidth: 4,
                shadowColor: .purple,
                shadowOffset: CGSize(width: 10, height: 20),
                shadowRadius: 8,
                shadowOpacity: 1
            ),
            imageViewAssets: ImageViewAssets(
                tintColor: .systemRed
            ),
            tableViewAssets: TableViewAssets(
                backgroundColor: .orange.withAlphaComponent(0.44),
                cornerRadius: 10,
                borderWidth: 1
            ),
            tableViewCellAssets: TableViewCellAssets(
                backgroundColor: .purple,
                cornerRadius: 20,
                borderWidth: 2
            ),
            navigationBarAssets: NavigationBarAssets(
                color: .systemBlue,
                font: .systemFont(ofSize: 28),
                cornerRadius: 40,
                borderColor: .systemBlue,
                borderWidth: 2
            ))) {
                Themer.shared.addCustomAssets(to: .dark, asset: ButtonAssets<CustomThemedButton>(buttonColor: .systemBlue))
                CustomThemedButton.appearance(whenContainedInInstancesOf: [CustomThemedView.self]).backgroundColor = .systemBrown
            }
}

class LightTheme: ApplicationTheme {
    var theme = Theme(
        assets:
            ThemeAssets(
                labelAssets: LabelAssets(
                    color: .blue,
                    font: .systemFont(ofSize: 48),
                    backgroundColor: .white
                ),
                buttonAssets: ButtonAssets(
                    buttonColor: .blue,
                    titleColor: .white,
                    font: .systemFont(ofSize: 28),
                    cornerRadius: 16,
                    borderColor: .red,
                    borderWidth: 4,
                    shadowColor: .orange,
                    shadowOffset: CGSize(width: 10, height: 20),
                    shadowRadius: 8,
                    shadowOpacity: 0.8
                ),
                imageViewAssets: ImageViewAssets(
                    backgroundColor: .blue,
                    cornerRadius: 10,
                    borderColor: .systemTeal,
                    borderWidth: 4,
                    shadowOpacity: 0.8,
                    tintColor: .systemTeal
                ),
                navigationBarAssets: NavigationBarAssets(
                    color: .cyan,
                    font: .systemFont(ofSize: 28),
                    cornerRadius: 4,
                    borderColor: .systemPurple,
                    borderWidth: 2,
                    shadowColor: .systemTeal,
                    shadowOffset: CGSize(width: 10, height: 20),
                    shadowRadius: 8
                ))) {
                    Themer.shared.addCustomAssets(to: .light, asset: ButtonAssets<CustomThemedButton>(buttonColor: .orange))
                    CustomThemedButton.appearance(whenContainedInInstancesOf: [CustomThemedView.self]).backgroundColor = .systemRed
                }
//        var theme: Theme = DarkTheme().theme.copyWith(ThemeAssets(
//            labelAssets: LabelAssets(
//                color: .blue
//            ),
//            buttonAssets: ButtonAssets(
//                buttonColor: .blue
//            ),
//            imageViewAssets: ImageViewAssets(
//                tintColor: .yellow
//            ),
//            navigationBarAssets: NavigationBarAssets(
//                color: .darkGray,
//                font: .systemFont(ofSize: 28),
//                cornerRadius: 4,
//                borderColor: .systemPurple,
//                borderWidth: 2,
//                shadowColor: .systemTeal,
//                shadowOffset: CGSize(width: 10, height: 20),
//                shadowRadius: 8
//            )))
}

class CustomThemedButton: ThemableButton {
}

class CustomThemedView: ThemableView {
    
}
