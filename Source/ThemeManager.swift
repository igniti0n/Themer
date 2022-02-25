//
//  ThemeManager.swift
//  temp
//
//  Created by Ivan Stajcer on 09.02.2022..
//

import Foundation
import UIKit

public enum AppThemeType: Int {
    case light = 1
    case dark = 2
    case systemDefault = 3
}

public enum AttachableTheme {
    case light
    case dark
    case both
}

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

public protocol ThemeManagerDelegateProtocol {
    func willChageTheme(to theme: AppThemeType)
}

fileprivate class DetectingThemeChangesView: UIView {
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        ThemeManager.shared.onSystemThemeChanged()
    }
}

public class ThemeManager {
    // MARK: - Properties -
    public static let shared: ThemeManager = ThemeManager()
    // is currenty theme mode light, dark or system default
   public var currentThemeType: AppThemeType = .systemDefault
    //  currently applieed theme either dark or light
    var currentlyAppliedTheme: AppThemeType?
    var animationSettings: ThemeAnimationSettings?
    private var lightTheme: ApplicationTheme?
    private var darkTheme: ApplicationTheme?
    private var delegates = [ThemeManagerDelegateProtocol]()
    private let detectingThemeChangesView = DetectingThemeChangesView()

    // MARK: - Computed properties -
    public var currentTheme: ApplicationTheme? {
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
public extension ThemeManager {
    func apply(_ theme: AppThemeType, withAnimation settings: ThemeAnimationSettings) {
        animationSettings = settings
        UIView.animate(withDuration: settings.duration, delay: settings.delay, options: settings.animationOptions) { [weak self] in
            self?.apply(theme)
        }
    }
    
    func apply(_ theme: AppThemeType) {
        if theme == currentlyAppliedTheme {
            return
        }
        currentThemeType = theme
        switch theme {
        case .light:
            applyLightTheme()
        case .dark:
            applyDarkTheme()
        case .systemDefault:
            chageThemeForSystemDefault()
        }
    }
    //  TODO: Check if unneccesary rebuilds for just one theme
    func setup(withUniversalTheme theme: ApplicationTheme) {
        lightTheme = theme
        darkTheme = theme
    }
    
    func setup(lightTheme: ApplicationTheme, darkTheme: ApplicationTheme) {
        self.lightTheme = lightTheme
        self.darkTheme = darkTheme
        setupSystemThemeChangeCallbacks()
    }
    
    func addDelegate(_ delegate: ThemeManagerDelegateProtocol) {
        delegates.append(delegate)
    }
    
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
private extension ThemeManager {
    func applyLightTheme() {
        assert(lightTheme != nil)
        guard let lightTheme = lightTheme else { return }
        notifyDelegatesOfThemeChange(to: .light)
        currentlyAppliedTheme = .light
        applyTheme(to: lightTheme.theme)
    }
    
    func applyDarkTheme() {
        assert(darkTheme != nil)
        guard let darkTheme = darkTheme else { return }
        notifyDelegatesOfThemeChange(to: .dark)
        currentlyAppliedTheme = .dark
        applyTheme(to: darkTheme.theme)
    }
    
    func applyTheme(to theme: ThemeProtocol, app: UIApplication = UIApplication.shared) {
        theme.assets.activateAssets()
        theme.extend?()
        saveCurrentThemeTypeToUserDefaults()
        
        UIApplication.shared.keyWindow?.reloadAllViews()
//        app.connectedScenes.forEach { scene in
//            guard let scene = (scene as? UIWindowScene) else { return }
//            scene.keyWindow?.reloadAllViews()
//        }
    }
    
    func chageThemeForSystemDefault(app: UIApplication = UIApplication.shared) {
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
    
    func notifyDelegatesOfThemeChange(to theme: AppThemeType) {
        delegates.forEach { delegate in
            delegate.willChageTheme(to: theme)
        }
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
            view = scene.windows.first
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
        defaults.set(currentThemeType.rawValue, forKey: "theme")
    }
    
    func getCurrentThemeTypeFromUserDefaults() {
        let defaults = UserDefaults.standard
        let themeIndex = defaults.integer(forKey: "theme")
        let theme = AppThemeType.init(rawValue: themeIndex)
        currentThemeType = theme ?? .light
    }
    
    func setupSystemThemeChangeCallbacks() {
        // Notified for when user exits, goes settings, changes theme mode, comes back
        let notifications = NotificationCenter.default
        notifications.addObserver(self, selector: #selector(onSystemThemeChanged), name: NSNotification.Name.UIApplicationDidBecomeActive, object: nil)
        // Notified when user changes theme mode during runtime
        UIApplication.shared.keyWindow?.addSubview(detectingThemeChangesView)
//        UIApplication.shared.connectedScenes.forEach { scene in
//            guard let scene = (scene as? UIWindowScene) else { return }
//            if #available(iOS 15.0, *) {
//                scene.keyWindow?.addSubview(detectingThemeChangesView)
//            } else {
//                // Fallback on earlier versions
//                scene.
//            }
//        }
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


