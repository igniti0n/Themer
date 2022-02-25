//
//  TempView.swift
//  temp
//
//  Created by Ivan Stajcer on 07.02.2022..
//

import Foundation
import UIKit
import Themer

typealias EmptyCallback =  () -> Void

final class HomeView: UIView {
    // MARK: - Properties
    var onGoogleSignInTapped: EmptyCallback?
    private lazy var imageView = ThemedImageView(namedLight: "light", namedDark: "dark")
    private lazy var c =  CustomThemedButton()
    private lazy var v4 = ThemedButton()
    private lazy var v5 = ThemedButton()
    private lazy var v6 = ThemedButton()
    private lazy var label = ThemedLabel()

    // MARK: - Initi
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupViews()
    }
}

// MARK: - Extension ThemeManagerDelegateProtocol
extension HomeView: ThemeManagerDelegateProtocol {
    func willChageTheme(to theme: AppThemeType) {
        c.setTitle("\(ThemeManager.shared.currentThemeType)", for: .normal)
    }
}

// MARK: - Private methods
private extension HomeView {
    func setupViews() {
        backgroundColor = .white
        ThemeManager.shared.addDelegate(self)
    }
    
    @objc func lightThemeTapped() {
        ThemeManager.shared.apply(.light, withAnimation: ThemeAnimationSettings(duration: 0.4, delay: 0, animationOptions: .curveEaseIn))
    }
    
    @objc func darkThemeTapped() {
        ThemeManager.shared.apply(.dark, withAnimation: ThemeAnimationSettings(duration: 0.4, delay: 0, animationOptions: .curveEaseOut))
    }
    
    @objc func systemThemeTapped() {
        ThemeManager.shared.apply(.systemDefault, withAnimation: ThemeAnimationSettings(duration: 0.4, delay: 0, animationOptions: .transitionFlipFromTop))
    }
    
    @objc func googleSignInTapped() {
        onGoogleSignInTapped?()
    }
}

