//
//  ThemeViews.swift
//  temp
//
//  Created by Ivan Stajcer on 09.02.2022..
//

import Foundation
import UIKit

// MARK: - UIView -

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

public class ThemedView: ThemableView {}

// MARK: - UIButton -

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
public class ThemedButton: ThemableButton {
}

// MARK: - UILabel -

open class ThemableLabel: UILabel {}
public class ThemedLabel: ThemableLabel {}

// MARK: - UISwitch -

open class ThemableSwitch: UISwitch {
}
public class ThemedSwitch: ThemableSwitch {}

// MARK: - UIImageView -

open class ThemableImageView: UIImageView {
    var lightImage: UIImage?
    var darkImage: UIImage?
    
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
        ThemeManager.shared.addDelegate(self)
        setImageToCurretTheme()
    }
    
    required public init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func setImageToCurretTheme() {
        let isDark = ThemeManager.shared.currentThemeType == .dark
        if isDark {
            assert(darkImage != nil)
            self.image =  darkImage
        } else {
            assert(lightImage != nil)
            self.image = lightImage
        }
    }
    
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

// TODO:  See if this is neccessary
extension ThemableImageView: ThemeManagerDelegateProtocol {
    public func willChageTheme(to theme: AppThemeType) {
        setImageToCurretTheme()
    }
}

public class ThemedImageView: ThemableImageView {
    
}

// MARK: - UITableView -

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
public class ThemedTableView: ThemableTableView {
    
}

// MARK: - UITableViewCell -

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
open class ThemedTableViewCell: ThemableTableViewCell {
    
}


// MARK: - UICollectionView -

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

public  class ThemedCollectionView: ThemableCollectionView { }

// MARK: - UICollectionViewCell -

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
public class ThemedCollectionViewCell: ThemableCollectionViewCell {
    
}
// MARK: - UINavigationBar -

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
public class ThemedNavigationBar: ThemeableNavigationBar {}
