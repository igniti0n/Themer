//
//  Assets.swift
//  temp
//
//  Created by Ivan Stajcer on 10.02.2022..
//

import Foundation
import UIKit

// MARK: - ViewAssets

/// Assets describing appearance of a `ThemableView`
public struct ViewAssets<T: ThemableView>: ThemeAsset {    
    var color: UIColor?
    var cornerRadius: CGFloat?
    var borderColor: UIColor?
    var borderWidth: CGFloat?
    var shadowColor: UIColor?
    var shadowOffset: CGSize?
    var shadowRadius: CGFloat?
    var shadowOpacity: Float?
    
    public init(
        color: UIColor? = nil,
        cornerRadius: CGFloat? = nil,
        borderColor: UIColor? = nil,
        borderWidth: CGFloat? = nil,
        shadowColor: UIColor? = nil,
        shadowOffset: CGSize? = nil,
        shadowRadius: CGFloat? = nil,
        shadowOpacity: Float? = nil
    ) {
        self.color = color
        self.cornerRadius = cornerRadius
        self.borderColor = borderColor
        self.borderWidth = borderWidth
        self.shadowColor = shadowColor
        self.shadowOffset = shadowOffset
        self.shadowRadius = shadowRadius
        self.shadowOpacity = shadowOpacity
    }
    
    /// Activates assets by applying them to the `ThemableView`appearance
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

/// Assets describing appearance of a `ThemableNavigationBar`
public struct NavigationBarAssets<T: ThemeableNavigationBar>: ThemeAsset {
    var standardApprance: UINavigationBarAppearance
    var scrollEdgeApperance: UINavigationBarAppearance?
    var compactApperance: UINavigationBarAppearance?
    
    private let standardClosure: ((inout UINavigationBarAppearance) -> Void)!
    private let scrollClosure: ((inout UINavigationBarAppearance) -> Void)?
    private let compactClosure: ((inout UINavigationBarAppearance) -> Void)?
    
    ///  Creates  'NavigationBarAssets' from three closures, used to deescribe NavigationBar apperance.
    ///
    /// - Parameters:
    ///   - standardAppearance: Closure that provides a UINavigationBarAppearance instance, on which you can setup the NavigationBar's standdard appearance. The default value of this property is an appearance object containing the system's default appearance settings.
    ///   - `scrollEdgeAppearance`: Closure that provides a UINavigationBarAppearance instance, on which you can setup the NavigationBar's scrollEdgeApperance  appearance. `The provided  instance is a copy of standardAppearance`,  so you can modify wwhat is changed based on the standardApperance. If the value of this property is nil,  the settings found in the standardAppearance property are used.
    ///   - `compactApperance`:  Closure that provides a UINavigationBarAppearance instance, on which you can setup the NavigationBar's compactAppearance. `The provided  instance is a copy of standardAppearance`,  so you can modify wwhat is changed based on the standardApperance. If the value of this property is nil,  the settings found in the standardAppearance property are used.
    public init(
        standardApprance: ((inout UINavigationBarAppearance) -> Void)? = nil,
        scrollEdgeApperance: ((inout UINavigationBarAppearance) -> Void)? = nil,
        compactApperance: ((inout UINavigationBarAppearance) -> Void)? = nil
    ) {
        standardClosure = standardApprance
        scrollClosure = scrollEdgeApperance
        compactClosure = compactApperance
        self.standardApprance = {
            var apperance = UINavigationBarAppearance()
            standardApprance?(&apperance)
            return apperance
        }()
        self.scrollEdgeApperance = {
            var apperance = UINavigationBarAppearance()
            standardClosure?(&apperance)
            scrollClosure?(&apperance)
            return apperance
        }()
        self.compactApperance = {
            var apperance = UINavigationBarAppearance()
            standardClosure?(&apperance)
            compactClosure?(&apperance)
            return apperance
        }()
    }
    
    /// Activates assets by applying them to the `ThemableNavigationBar`appearance
    public func activate() {
        print("Activating nav bar appearance")
        T.appearance().standardAppearance = standardApprance
        T.appearance().scrollEdgeAppearance = scrollEdgeApperance
        T.appearance().compactAppearance = compactApperance
        
    }
    
    func copyWith(newAssets: NavigationBarAssets?) -> NavigationBarAssets<T> {
        guard let newAssets = newAssets else {
            return self
        }
        return NavigationBarAssets { appearance in
            self.standardClosure?(&appearance)
            newAssets.standardClosure?(&appearance)
        }
        scrollEdgeApperance: { appearance in
            self.scrollClosure?(&appearance)
            newAssets.scrollClosure?(&appearance)
        }
        compactApperance: { appearance in
                self.compactClosure?(&appearance)
            newAssets.compactClosure?(&appearance)
        }
    }
}


// MARK: - LabelAssets

/// Assets describing appearance of a `ThemableLabel`
public struct LabelAssets<T: ThemableLabel>: ThemeAsset {
    var color: UIColor?
    var font: UIFont?
    var backgroundColor: UIColor?
    
    public init(
        color: UIColor? = nil,
        font: UIFont? = nil,
        backgroundColor: UIColor? = nil
    ) {
        self.color = color
        self.font = font
        self.backgroundColor = backgroundColor
    }
    
    /// Activates assets by applying them to the `ThemableLabel`appearance
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

/// Assets describing appearance of a `ThemableButton`
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
    
    public init(
        buttonColor: UIColor? = nil,
        titleColor: UIColor? = nil,
        font: UIFont? = nil,
        cornerRadius: CGFloat? = nil,
        borderColor: UIColor? = nil,
        borderWidth: CGFloat? = nil,
        shadowColor: UIColor? = nil,
        shadowOffset: CGSize? = nil,
        shadowRadius: CGFloat? = nil,
        shadowOpacity: Float? = nil
    ) {
        self.buttonColor = buttonColor
        self.titleColor = titleColor
        self.font = font
        self.cornerRadius = cornerRadius
        self.borderColor = borderColor
        self.borderWidth = borderWidth
        self.shadowColor = shadowColor
        self.shadowOffset = shadowOffset
        self.shadowRadius = shadowRadius
        self.shadowOpacity = shadowOpacity
    }
    
    /// Activates assets by applying them to the `ThemableButton`appearance
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

/// Assets describing appearance of a `ThemableSwitch`
public struct SwitchAssets<T: ThemableSwitch>: ThemeAsset {
    var backgroundColor: UIColor?
    var onImage: UIImage?
    var offImage: UIImage?
    var thumbTintColor: UIColor?
    var onTintColor: UIColor?
    
    public init(
        backgroundColor: UIColor? = nil,
        onImage: UIImage? = nil,
        offImage: UIImage? = nil,
        thumbTintColor: UIColor? = nil,
        onTintColor: UIColor? = nil
    ) {
        self.backgroundColor = backgroundColor
        self.onImage = onImage
        self.offImage = offImage
        self.thumbTintColor = thumbTintColor
        self.onTintColor = onTintColor
    }
    
    /// Activates assets by applying them to the `ThemableSwitch`appearance
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

/// Assets describing appearance of a `ThemableImageView`
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
    
    public init(
        backgroundColor: UIColor? = nil,
        cornerRadius: CGFloat? = nil,
        borderColor: UIColor? = nil,
        borderWidth: CGFloat? = nil,
        shadowColor: UIColor? = nil,
        shadowOffset: CGSize? = nil,
        shadowRadius: CGFloat? = nil,
        shadowOpacity: Float? = nil,
        tintColor: UIColor? = nil
    ) {
        self.backgroundColor = backgroundColor
        self.cornerRadius = cornerRadius
        self.borderColor = borderColor
        self.borderWidth = borderWidth
        self.shadowColor = shadowColor
        self.shadowOffset = shadowOffset
        self.shadowRadius = shadowRadius
        self.shadowOpacity = shadowOpacity
        self.tintColor = tintColor
    }
    
    /// Activates assets by applying them to the `ThemableImageView`appearance
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

/// Assets describing appearance of a `ThemableTableView`
public struct TableViewAssets<T: ThemableTableView>: ThemeAsset {
    var backgroundColor: UIColor?
    var cornerRadius: CGFloat?
    var borderColor: UIColor?
    var borderWidth: CGFloat?
    var shadowColor: UIColor?
    var shadowOffset: CGSize?
    var shadowRadius: CGFloat?
    var shadowOpacity: Float?
    
    public init(
        backgroundColor: UIColor? = nil,
        cornerRadius: CGFloat? = nil,
        borderColor: UIColor? = nil,
        borderWidth: CGFloat? = nil,
        shadowColor: UIColor? = nil,
        shadowOffset: CGSize? = nil,
        shadowRadius: CGFloat? = nil,
        shadowOpacity: Float? = nil
    ) {
        self.backgroundColor = backgroundColor
        self.cornerRadius = cornerRadius
        self.borderColor = borderColor
        self.borderWidth = borderWidth
        self.shadowColor = shadowColor
        self.shadowOffset = shadowOffset
        self.shadowRadius = shadowRadius
        self.shadowOpacity = shadowOpacity
    }
    
    /// Activates assets by applying them to the `ThemablTableView`appearance
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

/// Assets describing appearance of a `ThemableTableViewCell`
public struct TableViewCellAssets<T: ThemableTableViewCell>: ThemeAsset {
    var backgroundColor: UIColor?
    var cornerRadius: CGFloat?
    var borderColor: UIColor?
    var borderWidth: CGFloat?
    var shadowColor: UIColor?
    var shadowOffset: CGSize?
    var shadowRadius: CGFloat?
    var shadowOpacity: Float?
    
    public init(
        backgroundColor: UIColor? = nil,
        cornerRadius: CGFloat? = nil,
        borderColor: UIColor? = nil,
        borderWidth: CGFloat? = nil,
        shadowColor: UIColor? = nil,
        shadowOffset: CGSize? = nil,
        shadowRadius: CGFloat? = nil,
        shadowOpacity: Float? = nil
    ) {
        self.backgroundColor = backgroundColor
        self.cornerRadius = cornerRadius
        self.borderColor = borderColor
        self.borderWidth = borderWidth
        self.shadowColor = shadowColor
        self.shadowOffset = shadowOffset
        self.shadowRadius = shadowRadius
        self.shadowOpacity = shadowOpacity
    }
    
    /// Activates assets by applying them to the `ThemableTableViewCell`appearance
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

/// Assets describing appearance of a `ThemableCollectionView`
public struct CollectionViewAssets<T: ThemableCollectionView>: ThemeAsset {
    var backgroundColor: UIColor?
    var cornerRadius: CGFloat?
    var borderColor: UIColor?
    var borderWidth: CGFloat?
    var shadowColor: UIColor?
    var shadowOffset: CGSize?
    var shadowRadius: CGFloat?
    var shadowOpacity: Float?
    
    public init(
        backgroundColor: UIColor? = nil,
        cornerRadius: CGFloat? = nil,
        borderColor: UIColor? = nil,
        borderWidth: CGFloat? = nil,
        shadowColor: UIColor? = nil,
        shadowOffset: CGSize? = nil,
        shadowRadius: CGFloat? = nil,
        shadowOpacity: Float? = nil,
        tintColor: Float? = nil
    ) {
        self.backgroundColor = backgroundColor
        self.cornerRadius = cornerRadius
        self.borderColor = borderColor
        self.borderWidth = borderWidth
        self.shadowColor = shadowColor
        self.shadowOffset = shadowOffset
        self.shadowRadius = shadowRadius
        self.shadowOpacity = shadowOpacity
    }
    
    /// Activates assets by applying them to the `ThemableCollectionView`appearance
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

/// Assets describing appearance of a `ThemableCollectionViewCell`
public struct CollectionViewCellAssets<T: ThemableCollectionViewCell>: ThemeAsset {
    var backgroundColor: UIColor?
    var cornerRadius: CGFloat?
    var borderColor: UIColor?
    var borderWidth: CGFloat?
    var shadowColor: UIColor?
    var shadowOffset: CGSize?
    var shadowRadius: CGFloat?
    var shadowOpacity: Float?
    
    public init(
        backgroundColor: UIColor? = nil,
        cornerRadius: CGFloat? = nil,
        borderColor: UIColor? = nil,
        borderWidth: CGFloat? = nil,
        shadowColor: UIColor? = nil,
        shadowOffset: CGSize? = nil,
        shadowRadius: CGFloat? = nil,
        shadowOpacity: Float? = nil,
        tintColor: Float? = nil
    ) {
        self.backgroundColor = backgroundColor
        self.cornerRadius = cornerRadius
        self.borderColor = borderColor
        self.borderWidth = borderWidth
        self.shadowColor = shadowColor
        self.shadowOffset = shadowOffset
        self.shadowRadius = shadowRadius
        self.shadowOpacity = shadowOpacity
    }
    
    /// Activates assets by applying them to the `ThemableCollectionViewCell`appearance
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
