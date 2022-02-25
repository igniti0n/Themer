//
//  UIWindow.swift
//  temp
//
//  Created by Ivan Stajcer on 14.02.2022..
//

import Foundation
import UIKit

extension UIWindow {
    func reloadAllViews() {
        subviews.forEach { view in
            view.removeFromSuperview()
            addSubview(view)
        }
    }
}
