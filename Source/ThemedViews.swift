//
//  ThemeViews.swift
//  temp
//
//  Created by Ivan Stajcer on 09.02.2022..
//

import Foundation
import UIKit

// MARK: - UIView -

/// Provides ways to  update properties on an `UIAppearance` of a  `UIView`, with all its normal functionalities.
///
///  - Note: Inherit from this class in order to be able eto apply `ViewAssets` to that class.
open class ThemableView: UIView {
    @objc dynamic var cornerRadius: CGFloat {
        get { self.cornerRadius }
        set(value) { layer.cornerRadius = value }
    }
    
    @objc dynamic var borderWidth: CGFloat {
        get { self.borderWidth }
        set(newValue) { layer.borderWidth = newValue }
    }
    
    @objc dynamic var borderColor: UIColor? {
        get {
            guard let color = self.layer.borderColor else { return nil}
            return UIColor(cgColor: color)
        }
        set(newValue) { layer.borderColor = newValue?.cgColor }
    }
    
    @objc dynamic var shadowColor: UIColor? {
        get {
            guard let color = self.layer.shadowColor else { return nil}
            return UIColor(cgColor: color)
        }
        set(newValue) { layer.shadowColor = newValue?.cgColor }
    }
    
    @objc dynamic var shadowOffset: CGSize {
        get { self.shadowOffset }
        set(newValue) { layer.shadowOffset = newValue }
    }
    
    @objc dynamic var shadowRadius: CGFloat {
        get { self.shadowRadius }
        set(newValue) { layer.shadowRadius = newValue }
    }
    
    @objc dynamic var shadowOpacity: Float {
        get { self.shadowOpacity }
        set(newValue) { layer.shadowOpacity = newValue }
    }
}

/// Default class for a view with `ViewAssets` of a theme being applied to it.
///
///  - Note: `ViewAssets` from a provided `ThemeAssets` of a theme are being applied to this  view.
///
public class ThemedView: ThemableView {}

// MARK: - UIButton -

/// Provides ways to  update properties on an `UIAppearance` of a  `UIButton`, with all its normal functionalities.
///
///  - Note: Inherit from this class in order to be able eto apply `ButtonAssets` to that class.
open class ThemableButton: UIButton {
    @objc dynamic var cornerRadius: CGFloat {
        get { self.cornerRadius }
        set(value) { layer.cornerRadius = value }
    }
    
    @objc dynamic var borderWidth: CGFloat {
        get { self.borderWidth }
        set(newValue) { layer.borderWidth = newValue }
    }
    
    @objc dynamic var borderColor: UIColor? {
        get {
            guard let color = self.layer.borderColor else { return nil}
            return UIColor(cgColor: color)
        }
        set(newValue) { layer.borderColor = newValue?.cgColor }
    }
    
    @objc dynamic var shadowColor: UIColor? {
        get {
            guard let color = self.layer.shadowColor else { return nil}
            return UIColor(cgColor: color)
        }
        set(newValue) { layer.shadowColor = newValue?.cgColor }
    }
    
    @objc dynamic var shadowOffset: CGSize {
        get { self.shadowOffset }
        set(newValue) { layer.shadowOffset = newValue }
    }
    
    @objc dynamic var shadowRadius: CGFloat {
        get { self.shadowRadius }
        set(newValue) { layer.shadowRadius = newValue }
    }
    
    @objc dynamic var shadowOpacity: Float {
        get { self.shadowOpacity }
        set(newValue) { layer.shadowOpacity = newValue }
    }
}

/// Default class for a view with `ButtonAssets` of a theme being applied to it.
///
///  - Note: `ButtonAssets` from a provided `ThemeAssets` of a theme are being applied to this  view.
///
public class ThemedButton: ThemableButton {
}

// MARK: - UILabel -

/// Provides ways to  update properties on an `UIAppearance` of a  `UILabel`, with all its normal functionalities.
///
///  - Note: Inherit from this class in order to be able eto apply `LabelAssets` to that class.
open class ThemableLabel: UILabel {}

/// Default class for a view with `LabelAssets` of a theme being applied to it.
///
///  - Note: `LabelAssets` from a provided `LabelAssets` of a theme are being applied to this  view.
///
public class ThemedLabel: ThemableLabel {}

// MARK: - UISwitch -

/// Provides ways to  update properties on an `UIAppearance` of a  `UISwitch`, with all its normal functionalities.
///
///  - Note: Inherit from this class in order to be able eto apply `SwitchAssets` to that class.
open class ThemableSwitch: UISwitch {}

/// Default class for a view with `SwitchAssets` of a theme being applied to it.
///
///  - Note: `SwitchAssets` from a provided `SwitchAssets` of a theme are being applied to this  view.
///
public class ThemedSwitch: ThemableSwitch {}

// MARK: - UIImageView -

/// Provides ways to  update properties on an `UIAppearance` of a  `UIImageView`, with all its normal functionalities.
///
///  - Note: Inherit from this class in order to be able eto apply `ImageViewAssets` to that class.
open class ThemableImageView: UIImageView {
    // MARK: - Properties
    var lightImage: UIImage?
    var darkImage: UIImage?
    
    // MARK: - Init
    public init(namedTinted: String) {
        super.init(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
        let assetImage = UIImage(named: namedTinted)
        assert(assetImage != nil)
        if let assetImage = assetImage {
            let templatedImage = assetImage.withRenderingMode(.alwaysTemplate)
            lightImage = templatedImage
            darkImage = templatedImage
            setImageToCurretTheme()
        }
    }
    
    public init(namedAny: String) {
        super.init(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
        lightImage = UIImage(named: namedAny)
        darkImage = UIImage(named: namedAny)
        setImageToCurretTheme()
    }
    
    public init(namedLight imageLight: String, namedDark imageDark: String) {
        super.init(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
        lightImage = UIImage(named: imageLight)
        darkImage = UIImage(named: imageDark)
        let nc = NotificationCenter.default
        nc.addObserver(self, selector: #selector(willChageTheme), name: Themer.notificationName, object: nil)
        //Themer.shared.addDelegate(self)
        setImageToCurretTheme()
    }
    
    required public init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    // MARK: - Deinit
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    // MARK: - Computed properties
    @objc dynamic var cornerRadius: CGFloat {
        get { self.cornerRadius }
        set(newValue) { layer.cornerRadius = newValue }
    }
    
    @objc dynamic var borderWidth: CGFloat {
        get { self.borderWidth }
        set(newValue) { layer.borderWidth = newValue }
    }
    
    @objc dynamic var borderColor: UIColor? {
        get {
            guard let color = self.layer.borderColor else { return nil}
            return UIColor(cgColor: color)
        }
        set(newValue) { layer.borderColor = newValue?.cgColor }
    }
    
    @objc dynamic var shadowColor: UIColor? {
        get {
            guard let color = self.layer.shadowColor else { return nil}
            return UIColor(cgColor: color)
        }
        set(newValue) { layer.shadowColor = newValue?.cgColor }
    }
    
    @objc dynamic var shadowOffset: CGSize {
        get { self.shadowOffset }
        set(newValue) { layer.shadowOffset = newValue }
    }
    
    @objc dynamic var shadowRadius: CGFloat {
        get { self.shadowRadius }
        set(newValue) { layer.shadowRadius = newValue }
    }
    
    @objc dynamic var shadowOpacity: Float {
        get { self.shadowOpacity }
        set(newValue) { layer.shadowOpacity = newValue }
    }
    
    
    // MARK: - Private methods
    private func setImageToCurretTheme() {
        let isDark = Themer.shared.currentlyAppliedTheme == .dark
        if isDark {
            assert(darkImage != nil)
            self.image =  darkImage
        } else {
            assert(lightImage != nil)
            self.image = lightImage
        }
    }
    
    @objc private func willChageTheme() {
        setImageToCurretTheme()
    }
}

/// Default class for a view with `ImageViewAssets` of a theme being applied to it.
///
///  - Note: `ImageViewAssets` from a provided `ImageViewAssets` of a theme are being applied to this  view.
///
public class ThemedImageView: ThemableImageView {
    
}

// MARK: - UITableView -

/// Provides ways to  update properties on an `UIAppearance` of a  `UITableView`, with all its normal functionalities.
///
///  - Note: Inherit from this class in order to be able eto apply `TableViewAssets` to that class.
///
open class ThemableTableView: UITableView {
    @objc dynamic var cornerRadius: CGFloat {
        get { self.cornerRadius }
        set(newValue) { layer.cornerRadius = newValue }
    }
    
    @objc dynamic var borderWidth: CGFloat {
        get { self.borderWidth }
        set(newValue) { layer.borderWidth = newValue }
    }
    
    @objc dynamic var borderColor: UIColor? {
        get {
            guard let color = self.layer.borderColor else { return nil}
            return UIColor(cgColor: color)
        }
        set(newValue) { layer.borderColor = newValue?.cgColor }
    }
    
    @objc dynamic var shadowColor: UIColor? {
        get {
            guard let color = self.layer.shadowColor else { return nil}
            return UIColor(cgColor: color)
        }
        set(newValue) { layer.shadowColor = newValue?.cgColor }
    }
    
    @objc dynamic var shadowOffset: CGSize {
        get { self.shadowOffset }
        set(newValue) { layer.shadowOffset = newValue }
    }
    
    @objc dynamic var shadowRadius: CGFloat {
        get { self.shadowRadius }
        set(newValue) { layer.shadowRadius = newValue }
    }
    
    @objc dynamic var shadowOpacity: Float {
        get { self.shadowOpacity }
        set(newValue) { layer.shadowOpacity = newValue }
    }
}

/// Default class for a view with `TableViewAssets` of a theme being applied to it.
///
///  - Note: `TableViewAssets` from a provided `TableViewAssets` of a theme are being applied to this  view.
///
public class ThemedTableView: ThemableTableView {}

// MARK: - UITableViewCell -

/// Provides ways to  update properties on an `UIAppearance` of a  `UITableViewCell`, with all its normal functionalities.
///
///  - Note: Inherit from this class in order to be able eto apply `TableViewCellAssets` to that class.
///
open class ThemableTableViewCell: UITableViewCell {
    @objc dynamic var cornerRadius: CGFloat {
        get { self.cornerRadius }
        set(newValue) { layer.cornerRadius = newValue }
    }
    
    @objc dynamic var borderWidth: CGFloat {
        get { self.borderWidth }
        set(newValue) { layer.borderWidth = newValue }
    }
    
    @objc dynamic var borderColor: UIColor? {
        get {
            guard let color = self.layer.borderColor else { return nil}
            return UIColor(cgColor: color)
        }
        set(newValue) { layer.borderColor = newValue?.cgColor }
    }
    
    @objc dynamic var shadowColor: UIColor? {
        get {
            guard let color = self.layer.shadowColor else { return nil}
            return UIColor(cgColor: color)
        }
        set(newValue) { layer.shadowColor = newValue?.cgColor }
    }
    
    @objc dynamic var shadowOffset: CGSize {
        get { self.shadowOffset }
        set(newValue) { layer.shadowOffset = newValue }
    }
    
    @objc dynamic var shadowRadius: CGFloat {
        get { self.shadowRadius }
        set(newValue) { layer.shadowRadius = newValue }
    }
    
    @objc dynamic var shadowOpacity: Float {
        get { self.shadowOpacity }
        set(newValue) { layer.shadowOpacity = newValue }
    }
}

/// Default class for a view with `TableViewCellAssets` of a theme being applied to it.
///
///  - Note: `TableViewCellAssets` from a provided `TableViewCellAssets` of a theme are being applied to this  view.
///
open class ThemedTableViewCell: ThemableTableViewCell {}


// MARK: - UICollectionView -

/// Provides ways to  update properties on an `UIAppearance` of a  `UICollectionView`, with all its normal functionalities.
///
///  - Note: Inherit from this class in order to be able eto apply `CollectionViewAssets` to that class.
///
open class ThemableCollectionView: UICollectionView {
    @objc dynamic var cornerRadius: CGFloat {
        get { self.cornerRadius }
        set(newValue) { layer.cornerRadius = newValue }
    }
    
    @objc dynamic var borderWidth: CGFloat {
        get { self.borderWidth }
        set(newValue) { layer.borderWidth = newValue }
    }
    
    @objc dynamic var borderColor: UIColor? {
        get {
            guard let color = self.layer.borderColor else { return nil}
            return UIColor(cgColor: color)
        }
        set(newValue) { layer.borderColor = newValue?.cgColor }
    }
    
    @objc dynamic var shadowColor: UIColor? {
        get {
            guard let color = self.layer.shadowColor else { return nil}
            return UIColor(cgColor: color)
        }
        set(newValue) { layer.shadowColor = newValue?.cgColor }
    }
    
    @objc dynamic var shadowOffset: CGSize {
        get { self.shadowOffset }
        set(newValue) { layer.shadowOffset = newValue }
    }
    
    @objc dynamic var shadowRadius: CGFloat {
        get { self.shadowRadius }
        set(newValue) { layer.shadowRadius = newValue }
    }
    
    @objc dynamic var shadowOpacity: Float {
        get { self.shadowOpacity }
        set(newValue) { layer.shadowOpacity = newValue }
    }
}

/// Default class for a view with `CollectionViewAssets` of a theme being applied to it.
///
///  - Note: `CollectionViewAssets` from a provided `CollectionViewAssets` of a theme are being applied to this  view.
///
public  class ThemedCollectionView: ThemableCollectionView { }

// MARK: - UICollectionViewCell -

/// Provides ways to  update properties on an `UIAppearance` of a  `UICollectionViewCell`, with all its normal functionalities.
///
///  - Note: Inherit from this class in order to be able eto apply `CollctionViewCellAssets` to that class.
///
open class ThemableCollectionViewCell: UICollectionViewCell {
    @objc dynamic var cornerRadius: CGFloat {
        get { self.cornerRadius }
        set(newValue) { layer.cornerRadius = newValue }
    }
    
    @objc dynamic var borderWidth: CGFloat {
        get { self.borderWidth }
        set(newValue) { layer.borderWidth = newValue }
    }
    
    @objc dynamic var borderColor: UIColor? {
        get {
            guard let color = self.layer.borderColor else { return nil}
            return UIColor(cgColor: color)
        }
        set(newValue) { layer.borderColor = newValue?.cgColor }
    }
    
    @objc dynamic var shadowColor: UIColor? {
        get {
            guard let color = self.layer.shadowColor else { return nil}
            return UIColor(cgColor: color)
        }
        set(newValue) { layer.shadowColor = newValue?.cgColor }
    }
    
    @objc dynamic var shadowOffset: CGSize {
        get { self.shadowOffset }
        set(newValue) { layer.shadowOffset = newValue }
    }
    
    @objc dynamic var shadowRadius: CGFloat {
        get { self.shadowRadius }
        set(newValue) { layer.shadowRadius = newValue }
    }
    
    @objc dynamic var shadowOpacity: Float {
        get { self.shadowOpacity }
        set(newValue) { layer.shadowOpacity = newValue }
    }
}

/// Default class for a view with `CollctionViewCellAssets` of a theme being applied to it.
///
///  - Note: `CollctionViewCellAssets` from a provided `CollctionViewCellAssets` of a theme are being applied to this  view.
///
public class ThemedCollectionViewCell: ThemableCollectionViewCell {}

// MARK: - UINavigationBar -

/// Provides ways to  update properties on an `UIAppearance` of a  `UINavigationBar`, with all its normal functionalities.
///
///  - Note: Inherit from this class in order to be able eto apply `NavigationBarAssets` to that class.
///
open class ThemeableNavigationBar: UINavigationBar {
    @objc dynamic var titleFont: UIFont? {
        get { self.titleTextAttributes?[.font] as? UIFont ?? nil}
        set(value) {
            guard let newFont = value else {
                return
            }
            var attributes = titleTextAttributes ?? [:]
            attributes[NSAttributedString.Key.font] = newFont
            self.titleTextAttributes = attributes
        }
    }
    
    @objc dynamic var cornerRadius: CGFloat {
        get { self.cornerRadius }
        set(newValue) { layer.cornerRadius = newValue }
    }
    
    @objc dynamic var borderWidth: CGFloat {
        get { self.borderWidth }
        set(newValue) { self.layer.borderWidth = newValue }
    }
    
    @objc dynamic var borderColor: UIColor? {
        get {
            guard let color = self.layer.borderColor else { return nil}
            return UIColor(cgColor: color)
        }
        set(newValue) { layer.borderColor = newValue?.cgColor }
    }
    
    @objc dynamic var shadowOffset: CGSize {
        get { self.shadowOffset }
        set(newValue) { layer.shadowOffset = newValue }
    }
    
    @objc dynamic var shadowColor: UIColor? {
        get {
            guard let color = self.layer.shadowColor else { return nil}
            return UIColor(cgColor: color)
        }
        set(newValue) { layer.shadowColor = newValue?.cgColor }
    }
    
    @objc dynamic var shadowRadius: CGFloat {
        get { self.shadowRadius }
        set(newValue) { self.layer.shadowRadius = newValue }
    }
    
    @objc dynamic var shadowOpacity: Float {
        get { self.shadowOpacity }
        set(newValue) { self.layer.shadowOpacity = newValue }
    }
}

/// Default class for a view with `NavigationBarAssets` of a theme being applied to it.
///
///  - Note: `NavigationBarAssets` from a provided `NavigationBarAssets` of a theme are being applied to this  view.
///
public class ThemedNavigationBar: ThemeableNavigationBar {}
