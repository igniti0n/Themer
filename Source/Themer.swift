//
//  ThemeManager.swift
//  temp
//
//  Created by Ivan Stajcer on 09.02.2022..
//

import Foundation
import UIKit



/// Describes application theme as either light, dark or system default.
public enum AppThemeType: Int {
    case light = 1
    case dark = 2
    case systemDefault = 3
    
    public var string: String {
        switch self {
        case .light:
           return "light"
        case .dark:
           return "dark"
        case .systemDefault:
           return "systemDefault"
        }
    }
}

/// Describes what themes to attach to. Just to  light, just to dark,  or to both themes.
public enum AttachableTheme {
    case light
    case dark
    case both
}

/// Describes animation parameters when applying a theme with an animation.
public struct ThemeAnimationSettings {
    let duration: TimeInterval
    let delay: TimeInterval
    let animationOptions: UIView.AnimationOptions
    
    public init(
        duration: TimeInterval,
        delay: TimeInterval,
        animationOptions: UIView.AnimationOptions
    ) {
        self.duration = duration
        self.delay = delay
        self.animationOptions = animationOptions
    }
}

//This is a dummy view, it is places inside the view hierarchy in order to be able to catch system theme changes.
fileprivate class DetectingThemeChangesView: UIView {
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        Themer.shared.onSystemThemeChanged()
    }
}

public protocol ThemerProtocol {
    var currentlyAppliedTheme: AppThemeType? { get set}
    var currentThemeType: AppThemeType { get set }
    func apply(_ theme: AppThemeType, withAnimation settings: ThemeAnimationSettings)
    func apply(_ theme: AppThemeType)
    func setup(withUniversalTheme theme: ApplicationTheme)
    func setup(lightTheme: ApplicationTheme, darkTheme: ApplicationTheme)
    func addCustomAssets(to theme: AttachableTheme, asset: ThemeAsset)
    
}


/**
Used  for  `any theme related operations`. Enables applying a  theme, provides theme change  notification trough NotificationCenter,
enables adding custom assets fot any ThemeAsset.
*/
public class Themer: ThemerProtocol {
    
    // MARK: - Properties -
    
    /// Single instance of `Themer`
    public static let shared: Themer = Themer()
    
    ///  Used to identify `notification` for `theme change`
    public static let notificationName = Notification.Name("ThemerThemeChangeNotification")
    
    ///  Currently applied theme, either `dark` or  `light`
    public var currentlyAppliedTheme: AppThemeType?
    
    /// Current theme mode. `Light`, `dark` or `system default`
    public var currentThemeType: AppThemeType = .systemDefault
    private var animationSettings: ThemeAnimationSettings?
    private var lightTheme: ApplicationTheme?
    private var darkTheme: ApplicationTheme?
    private let detectingThemeChangesView = DetectingThemeChangesView()
    private let userDefaultsKey = "themer_user_theme_key"

    // MARK: - Computed properties -
    
    var currentTheme: ApplicationTheme? {
        switch currentThemeType {
        case .light:
            return lightTheme
        case .dark:
            return darkTheme
        case .systemDefault:
            let systemTheme = getSystemDefaultTheme()
            switch systemTheme {
            case .light:
                return lightTheme
            case .dark:
                return darkTheme
            default:
                return lightTheme
            }
        }
    }

    // MARK: - Init -
    private init() {}
}

// MARK: - Public methods -
public extension Themer {
    /// Applies a theme to the application, using animatioin with provided  animation settings.
    ///
    /// - Parameters:
    ///   - theme:  `AppThemeType` to apply to the application.
    ///   - settings:  animation settings to use when animating.
    func apply(_ theme: AppThemeType, withAnimation settings: ThemeAnimationSettings) {
        animationSettings = settings
        UIView.animate(withDuration: settings.duration, delay: settings.delay, options: settings.animationOptions) { [weak self] in
            self?.apply(theme)
        }
    }
    
    /// Applies a theme to the application, `without` using animation.
    ///
    ///  Changes `currentThemeType` and `currentlyAppliedTheme` properties according to provided theme parameter.
    ///
    /// - Parameters:
    ///   - theme:  `AppThemeType` to apply to the application.
    func apply(_ theme: AppThemeType) {
        if theme == currentThemeType {
            return
        }
        currentThemeType = theme
        applyThemeForThemeType(theme)
    }

    /// Sets up the application to have one universal theme.
    ///
    /// - Parameters:
    ///   - theme:  `ApplicationTheme` to apply to the application.
    func setup(withUniversalTheme theme: ApplicationTheme) {
        lightTheme = theme
        darkTheme = theme
        applyThemeForThemeType(currentThemeType)
    }

    /// Sets up the application to have light and dark theme.
    ///
    /// - Parameters:
    ///   - lightTheme:  Light version of the application.
    ///   - darkTheme:  Dark version of the application.
    func setup(lightTheme: ApplicationTheme, darkTheme: ApplicationTheme) {
        self.lightTheme = lightTheme
        self.darkTheme = darkTheme
        setupSystemThemeChangeCallbacks()
        getCurrentThemeTypeFromUserDefaults()
        applyThemeForThemeType(currentThemeType)
    }
    
    /// Adds a custom `ThemeAsset` attached to the generic class parameter of the provided asset.
    ///
    /// Use this to add custom look to custom made classes.
    ///
    /// - Parameters:
    ///   - theme: To what themes to apply  this asset.
    ///   - asset: Asset to apply.
    func addCustomAssets(to theme: AttachableTheme, asset: ThemeAsset) {
        switch theme {
        case .light:
            lightTheme?.theme.addCustomAsset(asset)
        case .dark:
            darkTheme?.theme.addCustomAsset(asset)
        case .both:
            lightTheme?.theme.addCustomAsset(asset)
            darkTheme?.theme.addCustomAsset(asset)
        }
    }
}

// MARK: - Private methods -
private extension Themer {
    func applyThemeForThemeType(_ type: AppThemeType) {
        switch type {
        case .light:
            applyLightTheme()
        case .dark:
            applyDarkTheme()
        case .systemDefault:
            chageThemeForSystemDefault()
        }
    }
    
    func applyLightTheme() {
        assert(lightTheme != nil)
        guard let lightTheme = lightTheme else { return }
        currentlyAppliedTheme = .light
        notifyDelegatesOfThemeChange()
        applyTheme(to: lightTheme.theme)
    }
    
    func applyDarkTheme() {
        assert(darkTheme != nil)
        guard let darkTheme = darkTheme else { return }
        currentlyAppliedTheme = .dark
        notifyDelegatesOfThemeChange()
        applyTheme(to: darkTheme.theme)
    }
    
    func applyTheme(to theme: ThemeProtocol) {
        theme.assets.activateAssets()
        theme.extend?()
        saveCurrentThemeTypeToUserDefaults()
        UIApplication.shared.connectedScenes.forEach { scene in
            guard let scene = scene as? UIWindowScene else { return }
            if #available(iOS 15.0, *) {
                scene.keyWindow?.reloadAllViews()
            } else {
                scene.windows.forEach { window in
                    window.reloadAllViews()
                }
            }
        }
    }
    
    func chageThemeForSystemDefault() {
        saveCurrentThemeTypeToUserDefaults()
        let systemTheme = getSystemDefaultTheme()
        if currentlyAppliedTheme == systemTheme {
            return
        }
        switch systemTheme {
        case .light:
            applyLightTheme()
        case .dark:
            applyDarkTheme()
        default:
            applyLightTheme()
        }
    }
    
    func notifyDelegatesOfThemeChange() {
        let nc = NotificationCenter.default
        nc.post(name: Themer.notificationName, object: nil)
    }
    
    func getSystemDefaultTheme() -> AppThemeType {
        guard
            let scene = UIApplication.shared.connectedScenes.first,
            let scene = (scene as? UIWindowScene)
        else {
            return .light
        }
        var view: UIView?
        if #available(iOS 15.0, *) {
            view = scene.keyWindow?.subviews.first
        } else {
            view = scene.windows.first?.subviews.first
        }
        guard let view = view else {
            return .light
        }
        
        let isSystemDark = view.traitCollection.userInterfaceStyle == .dark
        let systemTheme: AppThemeType = isSystemDark ? .dark : .light
        return systemTheme
    }
    
    func saveCurrentThemeTypeToUserDefaults() {
        let defaults = UserDefaults.standard
        defaults.set(currentThemeType.rawValue, forKey: userDefaultsKey)
    }
    
    func getCurrentThemeTypeFromUserDefaults() {
        let defaults = UserDefaults.standard
        let themeIndex = defaults.integer(forKey: userDefaultsKey)
        let theme = AppThemeType.init(rawValue: themeIndex)
        currentThemeType = theme ?? .systemDefault
    }
    
    func setupSystemThemeChangeCallbacks() {
        // Notified for when user exits, goes settings, changes theme mode, comes back
        let notifications = NotificationCenter.default
        notifications.addObserver(self, selector: #selector(onSystemThemeChanged), name: .UIApplicationDidBecomeActive, object: nil)
        // Notified when user changes theme mode during runtime
        UIApplication.shared.connectedScenes.forEach { scene in
            guard let scene = scene as? UIWindowScene else { return }
            if #available(iOS 15.0, *) {
                scene.keyWindow?.addSubview(detectingThemeChangesView)
            } else {
                scene.windows.first?.addSubview(detectingThemeChangesView)
            }
        }
    }
    
    @objc  func onSystemThemeChanged() {
        getCurrentThemeTypeFromUserDefaults()
        if currentThemeType == .systemDefault {
            if let animationSettings = animationSettings {
                UIView.animate(withDuration: animationSettings.delay, delay: animationSettings.delay, options: animationSettings.animationOptions) {
                    self.chageThemeForSystemDefault()
                }
            } else {
                chageThemeForSystemDefault()
            }
        }
    }
}


