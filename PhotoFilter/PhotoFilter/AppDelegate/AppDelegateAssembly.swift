//
//  AppDelegateAssembly.swift
//  PhotoFilter
//
//  Created by Татьяна on 04/11/2018.
//  Copyright © 2018 Татьяна. All rights reserved.
//

import Swinject

class AppDelegateAssembly: Assembly {
    
    // MARK: Assembly
    func assemble(container: Container) {
        container.register(AppearanceConfigurator.self) { _ in AppearanceConfiguratorImpl() }
            .initCompleted { (resolver, configurator) in
                configurator.configure()
        }
    }
}
