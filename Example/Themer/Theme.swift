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
            navigationBarAssets: NavigationBarAssets(standardApprance: { appearance in
                appearance.backgroundColor = .blue
                appearance.titleTextAttributes = [.font : UIFont.systemFont(ofSize: 28), .foregroundColor : UIColor.purple]
            }, scrollEdgeApperance: { appearance in
                appearance.backgroundColor = .purple
                appearance.titleTextAttributes = [.font : UIFont.systemFont(ofSize: 24), .foregroundColor : UIColor.yellow]
            }, compactApperance: { appearance in
                appearance.titleTextAttributes = [.font : UIFont.systemFont(ofSize: 20), .foregroundColor : UIColor.blue]
            }
            ))) {
                Themer.shared.addCustomAssets(to: .dark, asset: ButtonAssets<CustomThemedButton>(buttonColor: .systemBlue))
                CustomThemedButton.appearance(whenContainedInInstancesOf: [CustomThemedView.self]).backgroundColor = .systemBrown
            }
}

class LightTheme: ApplicationTheme {
    var theme: Theme =  DarkTheme().theme.copyWith(ThemeAssets(
        labelAssets: LabelAssets(
            color: .blue
        ),
        buttonAssets: ButtonAssets(
            buttonColor: .blue,
            cornerRadius: 16,
            borderColor: .red,
            borderWidth: 4,
            shadowColor: .orange,
            shadowOffset: CGSize(width: 10, height: 20),
            shadowRadius: 8,
            shadowOpacity: 0.8
        ),
        imageViewAssets: ImageViewAssets(
            tintColor: .yellow
        ),
        navigationBarAssets: NavigationBarAssets(
            standardApprance: { appearance in
                appearance.backgroundColor = .red
            }
            , scrollEdgeApperance: { appearance in
                appearance.backgroundColor = .orange
                appearance.titleTextAttributes = [.font : UIFont.systemFont(ofSize: 24), .foregroundColor : UIColor.yellow]
            }
        ))) {
            Themer.shared.addCustomAssets(to: .light, asset: ButtonAssets<CustomThemedButton>(buttonColor: .orange))
            CustomThemedButton.appearance(whenContainedInInstancesOf: [CustomThemedView.self]).backgroundColor = .systemRed
        }
}

class CustomThemedButton: ThemableButton {
}

class CustomThemedView: ThemableView {
    
}
