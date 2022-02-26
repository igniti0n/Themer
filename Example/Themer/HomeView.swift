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
    private lazy var imageView = ThemedImageView(namedLight: "light", namedDark: "dark")
    private lazy var label = ThemedLabel()
    private lazy var lightButton =  CustomThemedButton()
    private lazy var darkButton = ThemedButton()
    private lazy var systemDefaultButton = ThemedButton()
    private let themer = Themer.shared

    // MARK: - Initi
    override init(frame: CGRect) {
        super.init(frame: frame)
        //Themer.shared.addDelegate(self)
        setupViews()
        let nc = NotificationCenter.default
        nc.addObserver(self, selector: #selector(onThemeChanged), name: Themer.notificationName, object: nil)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}

// MARK: - Private methods
private extension HomeView {
    @objc func onThemeChanged() {
        label.text = "\(themer.currentlyAppliedTheme.string)"

    }
    func setupViews() {
        backgroundColor = .white
        setupImageView()
        setupLabel()
        setupLightButton()
        setupDarkButton()
        setupSystemDefaultButton()
    }
    
    func setupImageView() {
        addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 20),
            imageView.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor),
            imageView.heightAnchor.constraint(equalToConstant: 128),
            imageView.widthAnchor.constraint(equalToConstant: 128)
        ])
        imageView.contentMode = .scaleAspectFill
    }
    
    func setupLabel() {
        addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 20),
            label.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor)
        ])
        label.text = "\(themer.currentlyAppliedTheme.string)"
    }
    
    func setupLightButton() {
        addSubview(lightButton)
        lightButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            lightButton.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 20),
            lightButton.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor),
            lightButton.heightAnchor.constraint(equalToConstant: 48),
            lightButton.widthAnchor.constraint(equalToConstant: 264)
        ])
        lightButton.setTitle("Light mode", for: .normal)
        lightButton.addTarget(self, action: #selector(lightThemeTapped), for: .touchUpInside)
    }
    
    func setupDarkButton() {
        addSubview(darkButton)
        darkButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            darkButton.topAnchor.constraint(equalTo: lightButton.bottomAnchor, constant: 10),
            darkButton.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor),
            darkButton.heightAnchor.constraint(equalToConstant: 48),
            darkButton.widthAnchor.constraint(equalToConstant: 264)
        ])
        darkButton.setTitle("Dark mode", for: .normal)
        darkButton.addTarget(self, action: #selector(darkThemeTapped), for: .touchUpInside)
        
    }
    
    func setupSystemDefaultButton() {
        addSubview(systemDefaultButton)
        systemDefaultButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            systemDefaultButton.topAnchor.constraint(equalTo: darkButton.bottomAnchor, constant: 10),
            systemDefaultButton.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor),
            systemDefaultButton.heightAnchor.constraint(equalToConstant: 48),
            systemDefaultButton.widthAnchor.constraint(equalToConstant: 264)
        ])
        systemDefaultButton.setTitle("System default", for: .normal)
        systemDefaultButton.addTarget(self, action: #selector(systemThemeTapped), for: .touchUpInside)
    }
    
    @objc func lightThemeTapped() {
        themer.apply(.light, withAnimation: ThemeAnimationSettings(duration: 0.4, delay: 0, animationOptions: .curveEaseIn))
    }
    
    @objc func darkThemeTapped() {
        themer.apply(.dark, withAnimation: ThemeAnimationSettings(duration: 0.4, delay: 0, animationOptions: .curveEaseOut))
    }
    
    @objc func systemThemeTapped() {
        themer.apply(.systemDefault, withAnimation: ThemeAnimationSettings(duration: 0.4, delay: 0, animationOptions: .transitionFlipFromTop))
    }
}

