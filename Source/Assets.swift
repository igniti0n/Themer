//
//  Assets.swift
//  temp
//
//  Created by Ivan Stajcer on 10.02.2022..
//

import Foundation
import UIKit

// MARK: - ViewAssets

public struct ViewAssets<T: ThemableView>: ThemeAsset {    
    var color: UIColor?
    var cornerRadius: CGFloat?
    var borderColor: UIColor?
    var borderWidth: CGFloat?
    var shadowColor: UIColor?
    var shadowOffset: CGSize?
    var shadowRadius: CGFloat?
    var shadowOpacity: Float?
    
    public func activate() {
        T.appearance().backgroundColor = color
        T.appearance().cornerRadius = cornerRadius ?? 0
        T.appearance().borderColor = borderColor
        T.appearance().borderWidth = borderWidth ?? 0
        T.appearance().shadowColor = shadowColor
        T.appearance().shadowOffset = shadowOffset ?? CGSize(width: 0, height: 0)
        T.appearance().shadowRadius = shadowRadius ?? 0
        T.appearance().shadowOpacity = shadowOpacity ?? 0
    }
    
    func copyWith(newAssets: ViewAssets<T>?) -> ViewAssets<T> {
        guard let newAssets = newAssets else {
            return self
        }
        return ViewAssets(
            color: newAssets.color ?? self.color,
            cornerRadius: newAssets.cornerRadius ?? self.cornerRadius,
            borderColor: newAssets.borderColor ?? self.borderColor,
            borderWidth: newAssets.borderWidth ?? self.borderWidth,
            shadowColor: newAssets.shadowColor ?? self.shadowColor,
            shadowOffset: newAssets.shadowOffset ?? self.shadowOffset,
            shadowRadius: newAssets.shadowRadius ?? self.shadowRadius,
            shadowOpacity: newAssets.shadowOpacity ?? self.shadowOpacity
        )
    }
}

// MARK: - NavigationBar

public struct NavigationBarAssets<T: ThemedNavigationBar>: ThemeAsset {
    var color: UIColor?
    var cornerRadius: CGFloat?
    var borderColor: UIColor?
    var borderWidth: CGFloat?
    var shadowColor: UIColor?
    var shadowOffset: CGSize?
    var shadowRadius: CGFloat?
    var shadowOpacity: Float?
    var font: UIFont?
    
    public func activate() {
        T.appearance().titleFont = font
        T.appearance().backgroundColor = color
        T.appearance().cornerRadius = cornerRadius ?? 0
        T.appearance().borderColor = borderColor
        T.appearance().borderWidth = borderWidth ?? 0
        T.appearance().shadowColor = shadowColor
        T.appearance().shadowOffset = shadowOffset ?? CGSize(width: 0, height: 0)
        T.appearance().shadowRadius = shadowRadius ?? 0
        T.appearance().shadowOpacity = shadowOpacity ?? 0
    }
    
    func copyWith(newAssets: NavigationBarAssets<T>?) -> NavigationBarAssets<T> {
        guard let newAssets = newAssets else {
            return self
        }
        return NavigationBarAssets(
            color: newAssets.color ?? self.color,
            cornerRadius: newAssets.cornerRadius ?? self.cornerRadius,
            borderColor: newAssets.borderColor ?? self.borderColor,
            borderWidth: newAssets.borderWidth ?? self.borderWidth,
            shadowColor: newAssets.shadowColor ?? self.shadowColor,
            shadowOffset: newAssets.shadowOffset ?? self.shadowOffset,
            shadowRadius: newAssets.shadowRadius ?? self.shadowRadius,
            shadowOpacity: newAssets.shadowOpacity ?? self.shadowOpacity,
            font: newAssets.font ?? self.font
        )
    }
}


// MARK: - LabelAssets

public struct LabelAssets<T: ThemableLabel>: ThemeAsset {
    var color: UIColor?
    var font: UIFont?
    var backgroundColor: UIColor?
    
    public func activate() {
        T.appearance().textColor = color
        T.appearance().font = font
        T.appearance().backgroundColor = backgroundColor
    }
    
    func copyWith(newAssets: LabelAssets<T>?) -> LabelAssets<T> {
        guard let newAssets = newAssets else {
            return self
        }
        return LabelAssets(
            color: newAssets.color ?? self.color,
            font: newAssets.font ?? self.font,
            backgroundColor: newAssets.backgroundColor ?? self.backgroundColor
        )
    }
}

// MARK: - ButtonAssets

public struct ButtonAssets<T: ThemableButton>: ThemeAsset {
    var buttonColor: UIColor?
    var titleColor: UIColor?
    var font: UIFont?
    var cornerRadius: CGFloat?
    var borderColor: UIColor?
    var borderWidth: CGFloat?
    var shadowColor: UIColor?
    var shadowOffset: CGSize?
    var shadowRadius: CGFloat?
    var shadowOpacity: Float?
    
    public func activate() {
        T.appearance().backgroundColor = buttonColor
        T.appearance().titleLabel?.font = font
        T.appearance().setTitleColor(titleColor, for: .normal)
        T.appearance().cornerRadius = cornerRadius ?? 0
        T.appearance().borderColor = borderColor
        T.appearance().borderWidth = borderWidth ?? 0
        T.appearance().shadowColor = shadowColor
        T.appearance().shadowOffset = shadowOffset ?? CGSize(width: 0, height: 0)
        T.appearance().shadowRadius = shadowRadius ?? 0
        T.appearance().shadowOpacity = shadowOpacity ?? 0
    }
    
    func copyWith(newAssets: ButtonAssets<T>?) -> ButtonAssets<T> {
        guard let newAssets = newAssets else {
            return self
        }
        return ButtonAssets(
            buttonColor: newAssets.buttonColor ?? self.buttonColor,
            titleColor: newAssets.titleColor ?? self.titleColor,
            font: newAssets.font ?? self.font,
            cornerRadius: newAssets.cornerRadius ?? self.cornerRadius,
            borderColor: newAssets.borderColor ?? self.borderColor,
            borderWidth: newAssets.borderWidth ?? self.borderWidth,
            shadowColor: newAssets.shadowColor ?? self.shadowColor,
            shadowOffset: newAssets.shadowOffset ?? self.shadowOffset,
            shadowRadius: newAssets.shadowRadius ?? self.shadowRadius,
            shadowOpacity: newAssets.shadowOpacity ?? self.shadowOpacity
        )
    }
}

// MARK: - SwitchAssets

public struct SwitchAssets<T: ThemableSwitch>: ThemeAsset {
    var backgroundColor: UIColor?
    var onImage: UIImage?
    var offImage: UIImage?
    var thumbTintColor: UIColor?
    var onTintColor: UIColor?
    
    public func activate() {
        T.appearance().backgroundColor = backgroundColor
        T.appearance().onImage = onImage
        T.appearance().offImage = offImage
        T.appearance().onTintColor = onTintColor
        T.appearance().thumbTintColor = thumbTintColor
    }
    
    func copyWith(newAssets: SwitchAssets<T>?) -> SwitchAssets<T> {
        guard let newAssets = newAssets else {
            return self
        }
        return SwitchAssets(
            backgroundColor: newAssets.backgroundColor ?? self.backgroundColor,
            onImage: newAssets.onImage ?? self.onImage,
            offImage: newAssets.offImage ?? self.offImage,
            thumbTintColor: newAssets.thumbTintColor ?? self.thumbTintColor,
            onTintColor: newAssets.onTintColor ?? self.onTintColor
        )
    }
}

// MARK: - ImageViewAssets

public struct ImageViewAssets<T: ThemableImageView>: ThemeAsset {
    var backgroundColor: UIColor?
    var cornerRadius: CGFloat?
    var borderColor: UIColor?
    var borderWidth: CGFloat?
    var shadowColor: UIColor?
    var shadowOffset: CGSize?
    var shadowRadius: CGFloat?
    var shadowOpacity: Float?
    var tintColor: UIColor?
    
    public func activate() {
        T.appearance().backgroundColor = backgroundColor
        T.appearance().cornerRadius = cornerRadius ?? 0
        T.appearance().borderColor = borderColor
        T.appearance().borderWidth = borderWidth ?? 0
        T.appearance().shadowColor = shadowColor
        T.appearance().shadowOffset = shadowOffset ?? CGSize(width: 0, height: 0)
        T.appearance().shadowRadius = shadowRadius ?? 0
        T.appearance().shadowOpacity = shadowOpacity ?? 0
        if let tintColor = tintColor {
            T.appearance().tintColor = tintColor

        }
    }
    
    func copyWith(newAssets: ImageViewAssets<T>?) -> ImageViewAssets<T> {
        guard let newAssets = newAssets else {
            return self
        }
        return ImageViewAssets(
            backgroundColor: newAssets.backgroundColor ?? self.backgroundColor,
            cornerRadius: newAssets.cornerRadius ?? self.cornerRadius,
            borderColor: newAssets.borderColor ?? self.borderColor,
            borderWidth: newAssets.borderWidth ?? self.borderWidth,
            shadowColor: newAssets.shadowColor ?? self.shadowColor,
            shadowOffset: newAssets.shadowOffset ?? self.shadowOffset,
            shadowRadius: newAssets.shadowRadius ?? self.shadowRadius,
            shadowOpacity: newAssets.shadowOpacity ?? self.shadowOpacity,
            tintColor: newAssets.tintColor ?? self.tintColor
        )
    }
}

// MARK: - TableViewAssets

public struct TableViewAssets<T: ThemableTableView>: ThemeAsset {
    var backgroundColor: UIColor?
    var cornerRadius: CGFloat?
    var borderColor: UIColor?
    var borderWidth: CGFloat?
    var shadowColor: UIColor?
    var shadowOffset: CGSize?
    var shadowRadius: CGFloat?
    var shadowOpacity: Float?
    
    public func activate() {
        T.appearance().backgroundColor = backgroundColor
        T.appearance().cornerRadius = cornerRadius ?? 0
        T.appearance().borderColor = borderColor
        T.appearance().borderWidth = borderWidth ?? 0
        T.appearance().shadowColor = shadowColor
        T.appearance().shadowOffset = shadowOffset ?? CGSize(width: 0, height: 0)
        T.appearance().shadowRadius = shadowRadius ?? 0
        T.appearance().shadowOpacity = shadowOpacity ?? 0
    }
    
    func copyWith(newAssets: TableViewAssets<T>?) -> TableViewAssets<T> {
        guard let newAssets = newAssets else {
            return self
        }
        return TableViewAssets(
            backgroundColor: newAssets.backgroundColor ?? self.backgroundColor,
            cornerRadius: newAssets.cornerRadius ?? self.cornerRadius,
            borderColor: newAssets.borderColor ?? self.borderColor,
            borderWidth: newAssets.borderWidth ?? self.borderWidth,
            shadowColor: newAssets.shadowColor ?? self.shadowColor,
            shadowOffset: newAssets.shadowOffset ?? self.shadowOffset,
            shadowRadius: newAssets.shadowRadius ?? self.shadowRadius,
            shadowOpacity: newAssets.shadowOpacity ?? self.shadowOpacity
        )
    }
}

// MARK: - TableViewCellAssets

public struct TableViewCellAssets<T: ThemableTableViewCell>: ThemeAsset {
    var backgroundColor: UIColor?
    var cornerRadius: CGFloat?
    var borderColor: UIColor?
    var borderWidth: CGFloat?
    var shadowColor: UIColor?
    var shadowOffset: CGSize?
    var shadowRadius: CGFloat?
    var shadowOpacity: Float?
    
    public func activate() {
        T.appearance().backgroundColor = backgroundColor
        T.appearance().cornerRadius = cornerRadius ?? 0
        T.appearance().borderColor = borderColor
        T.appearance().borderWidth = borderWidth ?? 0
        T.appearance().shadowColor = shadowColor
        T.appearance().shadowOffset = shadowOffset ?? CGSize(width: 0, height: 0)
        T.appearance().shadowRadius = shadowRadius ?? 0
        T.appearance().shadowOpacity = shadowOpacity ?? 0
    }
    
    func copyWith(newAssets: TableViewCellAssets<T>?) -> TableViewCellAssets<T> {
        guard let newAssets = newAssets else {
            return self
        }
        return TableViewCellAssets(
            backgroundColor: newAssets.backgroundColor ?? self.backgroundColor,
            cornerRadius: newAssets.cornerRadius ?? self.cornerRadius,
            borderColor: newAssets.borderColor ?? self.borderColor,
            borderWidth: newAssets.borderWidth ?? self.borderWidth,
            shadowColor: newAssets.shadowColor ?? self.shadowColor,
            shadowOffset: newAssets.shadowOffset ?? self.shadowOffset,
            shadowRadius: newAssets.shadowRadius ?? self.shadowRadius,
            shadowOpacity: newAssets.shadowOpacity ?? self.shadowOpacity
        )
    }
}

// MARK: - CollectionViewAssets

public struct CollectionViewAssets<T: ThemableCollectionView>: ThemeAsset {
    var backgroundColor: UIColor?
    var cornerRadius: CGFloat?
    var borderColor: UIColor?
    var borderWidth: CGFloat?
    var shadowColor: UIColor?
    var shadowOffset: CGSize?
    var shadowRadius: CGFloat?
    var shadowOpacity: Float?
    
    public func activate() {
        T.appearance().backgroundColor = backgroundColor
        T.appearance().cornerRadius = cornerRadius ?? 0
        T.appearance().borderColor = borderColor
        T.appearance().borderWidth = borderWidth ?? 0
        T.appearance().shadowColor = shadowColor
        T.appearance().shadowOffset = shadowOffset ?? CGSize(width: 0, height: 0)
        T.appearance().shadowRadius = shadowRadius ?? 0
        T.appearance().shadowOpacity = shadowOpacity ?? 0
    }
    
    func copyWith(newAssets: CollectionViewAssets<T>?) -> CollectionViewAssets<T> {
        guard let newAssets = newAssets else {
            return self
        }
        return CollectionViewAssets(
            backgroundColor: newAssets.backgroundColor ?? self.backgroundColor,
            cornerRadius: newAssets.cornerRadius ?? self.cornerRadius,
            borderColor: newAssets.borderColor ?? self.borderColor,
            borderWidth: newAssets.borderWidth ?? self.borderWidth,
            shadowColor: newAssets.shadowColor ?? self.shadowColor,
            shadowOffset: newAssets.shadowOffset ?? self.shadowOffset,
            shadowRadius: newAssets.shadowRadius ?? self.shadowRadius,
            shadowOpacity: newAssets.shadowOpacity ?? self.shadowOpacity
        )
    }
}

// MARK: - TableViewCellAssets

public struct CollectionViewCellAssets<T: ThemableCollectionViewCell>: ThemeAsset {
    var backgroundColor: UIColor?
    var cornerRadius: CGFloat?
    var borderColor: UIColor?
    var borderWidth: CGFloat?
    var shadowColor: UIColor?
    var shadowOffset: CGSize?
    var shadowRadius: CGFloat?
    var shadowOpacity: Float?
    
    public func activate() {
        T.appearance().backgroundColor = backgroundColor
        T.appearance().cornerRadius = cornerRadius ?? 0
        T.appearance().borderColor = borderColor
        T.appearance().borderWidth = borderWidth ?? 0
        T.appearance().shadowColor = shadowColor
        T.appearance().shadowOffset = shadowOffset ?? CGSize(width: 0, height: 0)
        T.appearance().shadowRadius = shadowRadius ?? 0
        T.appearance().shadowOpacity = shadowOpacity ?? 0
    }
    
    func copyWith(newAssets: CollectionViewCellAssets<T>?) -> CollectionViewCellAssets<T> {
        guard let newAssets = newAssets else {
            return self
        }
        return CollectionViewCellAssets(
            backgroundColor: newAssets.backgroundColor ?? self.backgroundColor,
            cornerRadius: newAssets.cornerRadius ?? self.cornerRadius,
            borderColor: newAssets.borderColor ?? self.borderColor,
            borderWidth: newAssets.borderWidth ?? self.borderWidth,
            shadowColor: newAssets.shadowColor ?? self.shadowColor,
            shadowOffset: newAssets.shadowOffset ?? self.shadowOffset,
            shadowRadius: newAssets.shadowRadius ?? self.shadowRadius,
            shadowOpacity: newAssets.shadowOpacity ?? self.shadowOpacity
        )
    }
}
