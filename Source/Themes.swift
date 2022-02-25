//
//  Themes.swift
//  temp
//
//  Created by Ivan Stajcer on 09.02.2022..
//

import Foundation
import UIKit

public protocol ThemeProtocol {
    var assets: ThemeAssets { get }
    var extend: (() -> Void)? { get }
}

public protocol ApplicationTheme {
    var theme: Theme { get }
}

public class Theme: ThemeProtocol {
    // MARK: - Properties -
    public var assets: ThemeAssets
    public var extend: (() -> Void)?
    
    // MARK: - Init-
    public init(assets: ThemeAssets, extension: (() -> Void)? = nil) {
        self.assets = assets
        self.extend = `extension`
    }
}

// MARK: - Public methods -
extension Theme {
    func addCustomAsset(_ asset: ThemeAsset) {
        assets.addCustomAsset(asset)
    }
    
    func copyWith(_ newAsssets: ThemeAssets) -> Theme {
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
}


