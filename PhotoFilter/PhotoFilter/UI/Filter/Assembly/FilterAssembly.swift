//
//  FilterAssembly.swift
//  PhotoFilter
//
//  Created by Татьяна on 03/11/2018.
//  Copyright © 2018 Татьяна. All rights reserved.
//

import Swinject
import SwinjectStoryboard

class FilterAssembly: Assembly {

    // MARK: Assembly
    
    func assemble(container: Container) {
        
        let assembler = Assembler([HelperAssembly()])
        container.storyboardInitCompleted(FilterViewController.self) { r, c in
            c.viewOutput = r.resolve(FilterViewOutput.self,
                                     argument: c as FilterViewController)
        }
        
        container.register(FilterViewOutput.self) { (r, controller: FilterViewController) in
            let model = FilterViewModel()
            model.viewInput = controller
            model.factory = r.resolve(FilterObjectFactory.self)
            model.builder = assembler.resolver.resolve(FilterBuilder.self)
            model.shareHelper = assembler.resolver.resolve(SharingHelper.self,
                                                           argument: controller as UIViewController)
            return model
        }
        
        container.register(FilterObjectFactory.self) { _ in FilterObjectFactoryImpl() }
    }
}
