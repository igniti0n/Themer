//
//  Themes.swift
//  temp
//
//  Created by Ivan Stajcer on 09.02.2022..
//

import Foundation
import UIKit

protocol ThemeProtocol {
    var assets: ThemeAssets { get }
    var extend: (() -> Void)? { get }
}

/// Protocol describing what a created theme should contain.
public protocol ApplicationTheme {
    var theme: Theme { get }
}

/**
Used  to  represent a single theme. Holding `assets` that represent a theme's button, labels,, navigation bar... This  assets are applied to
 `ThemedButton`, `ThemedLabel`, `ThemedNavigationBar`...,   and can be used in your view's by replacing UIKit view classes
 with themed ones. So, instead UIButton use ThemedButton, and so on.
 
 Enabels you to use `extend` callback. Which is used to extend some thing on the theme. For ex, when a ThemedButton is inside ThemedView, make its color blue.
*/
public class Theme: ThemeProtocol {
    
    // MARK: - Properties -
    
    /// Represent a theme's button, labels,, navigation bar... This  assets are applied to
    /// `ThemedButton`, `ThemedLabel`, `ThemedNavigationBar`...,   and can be used in your view's by replacing UIKit view classes
    /// with themed ones. So, instead UIButton use ThemedButton, and so on.
    public var assets: ThemeAssets
    
    /// Used to extend some thing on the theme. For ex, when a ThemedButton is inside ThemedView, make its color blue.
    public var extend: (() -> Void)?
    
    // MARK: - Init -
    
    /// Creates a `Theme` from a `ThemeAssets` and other parameters.
       ///
       /// - Parameters:
       ///   - assets:                  Assts that describe this theme.
       ///   - extension:               Convinience closure for extensing theme apperance.
    public init(assets: ThemeAssets, extension: (() -> Void)? = nil) {
        self.assets = assets
        self.extend = `extension`
    }
    
    /// Creates a copy of this `Theme` with additional `ThemeAssets`.
       ///
       /// - Parameters:
       ///   - newAssets:                  Additional assets to apply to newly created theme.
    public func copyWith(_ newAsssets: ThemeAssets) -> Theme {
        return Theme(
            assets: ThemeAssets(
                labelAssets: self.assets.labelAssets.copyWith(newAssets: newAsssets.labelAssets),
                buttonAssets: self.assets.buttonAssets.copyWith(newAssets: newAsssets.buttonAssets),
                imageViewAssets: self.assets.imageViewAssets.copyWith(newAssets: newAsssets.imageViewAssets),
                switchAssets: self.assets.switchAssets.copyWith(newAssets: newAsssets.switchAssets),
                tableViewAssets: self.assets.tableViewAssets.copyWith(newAssets: newAsssets.tableViewAssets),
                tableViewCellAssets: self.assets.tableViewCellAssets.copyWith(newAssets: newAsssets.tableViewCellAssets),
                collectionViewAssets: self.assets.collectionViewAssets.copyWith(newAssets: newAsssets.collectionViewAssets),
                collectionViewCellAssets: self.assets.collectionViewCellAssets.copyWith(newAssets: newAsssets.collectionViewCellAssets),
                navigationBarAssets: self.assets.navigationBarAssets.copyWith(newAssets: newAsssets.navigationBarAssets)
              )) {
                  self.extend?()
                }
    }
    
    func addCustomAsset(_ asset: ThemeAsset) {
        assets.addCustomAsset(asset)
    }
}


