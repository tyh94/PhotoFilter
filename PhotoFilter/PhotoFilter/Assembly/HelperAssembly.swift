//
//  HelperAssembly.swift
//  PhotoFilter
//
//  Created by Татьяна on 03/11/2018.
//  Copyright © 2018 Татьяна. All rights reserved.
//

import Swinject

class HelperAssembly: Assembly {

    // MARK: Assembly
    
    func assemble(container: Container) {
        
        container.register(ImagePickerHelper.self) { (resolver, controller: UIViewController) in
            let helper = ImagePickerHelperImpl()
            helper.controller = controller
            return helper
        }
        
        container.register(FilterBuilder.self) { _ in FilterBuilderImpl() }
        
        container.register(SharingHelper.self) { (resolver, controller: UIViewController) in
            let helper = SharingHelperImpl()
            helper.controller = controller
            return helper
        }
    }
    
}
