//
//  AppearanceConfiguratorImpl.swift
//  PhotoFilter
//
//  Created by Татьяна on 04/11/2018.
//  Copyright © 2018 Татьяна. All rights reserved.
//

import UIKit

class AppearanceConfiguratorImpl: NSObject, AppearanceConfigurator {
    
    // MARK: AppearanceConfigurator
    
    func configure() {
        let navigationBarAppearace = UINavigationBar.appearance()
        navigationBarAppearace.tintColor = UIColor(named: "mainColor")
        navigationBarAppearace.barTintColor =  UIColor(named: "navigationBarTintColor")
        navigationBarAppearace.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor(named: "mainColor") as Any]
        let labelAppearence = UILabel.appearance()
        labelAppearence.textColor = UIColor(named: "mainColor")
    }
    
}
