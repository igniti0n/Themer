//
//  ThemeAssets.swift
//  temp
//
//  Created by Ivan Stajcer on 09.02.2022..
//

import Foundation
import UIKit

/// Describes what an `ThemeAsset` should contain.
public protocol ThemeAsset {
    /// Activates `ThemeAsset` for the `UIAppearance` of the attached view.
    func activate()
}

/// Represents assets of a theme.
///
///  Comes with default assets like `LabelAssets` that apply for its attached class `ThemedLabel`.
///  Also, holds any added assets attached to custom classes.
public struct ThemeAssets {
    // MARK: - Properties -
    var viewAssets: ViewAssets<ThemedView>
    var labelAssets: LabelAssets<ThemedLabel>
    var buttonAssets: ButtonAssets<ThemedButton>
    var imageViewAssets: ImageViewAssets<ThemedImageView>
    var switchAssets: SwitchAssets<ThemedSwitch>
    var tableViewAssets: TableViewAssets<ThemedTableView>
    var tableViewCellAssets: TableViewCellAssets<ThemedTableViewCell>
    var collectionViewAssets: CollectionViewAssets<ThemedCollectionView>
    var collectionViewCellAssets: CollectionViewCellAssets<ThemedCollectionViewCell>
    var navigationBarAssets: NavigationBarAssets<ThemedNavigationBar>
    private var assets: [ThemeAsset] = []
    
    // MARK: - Init -
    
    /// Creates an instance with the provided assets.
    ///
    /// - Parameters:
    ///   - labelAssets:               Optional  assets applied to `ThemedLabel`
    ///   - buttonAssets:              Optional  assets applied to `ThemedButton`
    ///   - imageViewAssets:           Optional  assets applied to `ThemedImageView`
    ///   - switchAssets:              Optional  assets applied to `ThemedSwitch`
    ///   - tableViewAssets:           Optional  assets applied to `ThemedTableView`
    ///   - tableViewCellAssets:       Optional  assets applied to `ThemedTableViewCell`
    ///   - collectionViewAssets:      Optional  assets applied to `ThemedCollectionView`
    ///   - collectionViewCellAssets:  Optional  assets applied to `ThemedCollectionViewCell`
    ///   - navigationBarAssets:       Optional  assets applied to `ThemedNavigationBar`
    public init(viewAssets: ViewAssets<ThemedView> = ViewAssets(),
         labelAssets: LabelAssets<ThemedLabel> = LabelAssets(),
         buttonAssets: ButtonAssets<ThemedButton> = ButtonAssets(),
         imageViewAssets: ImageViewAssets<ThemedImageView> = ImageViewAssets(),
         switchAssets: SwitchAssets<ThemedSwitch> = SwitchAssets(),
         tableViewAssets: TableViewAssets<ThemedTableView> = TableViewAssets(),
         tableViewCellAssets: TableViewCellAssets<ThemedTableViewCell> = TableViewCellAssets(),
         collectionViewAssets: CollectionViewAssets<ThemedCollectionView> = CollectionViewAssets(),
         collectionViewCellAssets: CollectionViewCellAssets<ThemedCollectionViewCell> = CollectionViewCellAssets(),
         navigationBarAssets: NavigationBarAssets<ThemedNavigationBar> = NavigationBarAssets()
    ) {
        self.viewAssets = viewAssets
        self.labelAssets = labelAssets
        self.buttonAssets = buttonAssets
        self.imageViewAssets = imageViewAssets
        self.switchAssets = switchAssets
        self.tableViewAssets = tableViewAssets
        self.tableViewCellAssets = tableViewCellAssets
        self.collectionViewAssets = collectionViewAssets
        self.collectionViewCellAssets = collectionViewCellAssets
        self.navigationBarAssets = navigationBarAssets
    }
}

// MARK: - Public methods -
extension ThemeAssets {
    func activateAssets() {
        viewAssets.activate()
        buttonAssets.activate()
        imageViewAssets.activate()
        switchAssets.activate()
        tableViewAssets.activate()
        tableViewCellAssets.activate()
        navigationBarAssets.activate()
        labelAssets.activate()
        collectionViewAssets.activate()
        collectionViewCellAssets.activate()
        assets.forEach { asset in
            asset.activate()
        }
    }
    
    mutating func addCustomAsset(_ asset: ThemeAsset) {
        assets.append(asset)
        asset.activate()
    }
}
