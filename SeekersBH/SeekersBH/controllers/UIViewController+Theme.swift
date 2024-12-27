//
//  UIViewController+Theme.swift
//  SeekersBH
//
//  Created by Noora Qasim on 27/12/2024.
//

import UIKit

extension UIViewController {
    func applyCurrentTheme() {
        let isDarkMode = UserDefaults.standard.bool(forKey: "isDarkMode")
        if let window = view.window {
            window.overrideUserInterfaceStyle = isDarkMode ? .dark : .light
        }
    }
}
