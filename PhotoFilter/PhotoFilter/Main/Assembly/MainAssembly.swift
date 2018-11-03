//
//  MainAssembly.swift
//  PhotoFilter
//
//  Created by Татьяна on 03/11/2018.
//  Copyright © 2018 Татьяна. All rights reserved.
//

import Swinject
import SwinjectStoryboard

class MainAssembly: Assembly {
    
    // MARK: Assembly
    func assemble(container: Container) {
        
        let assemler = Assembler([HelperAssembly()])
        
        container.storyboardInitCompleted(MainViewController.self) { r, c in
            c.viewOutput = r.resolve(MainViewOutput.self,
                                     argument: c as MainViewController)
        }
        
        container.register(MainViewOutput.self) { (r, controller: MainViewController) in
            let model = MainViewModel()
            model.viewInput = controller
            model.router = r.resolve(MainRouter.self, argument: controller)
            model.imagePickerHelper = assemler.resolver.resolve(ImagePickerHelper.self,
                                                                argument: controller as UIViewController)
            return model
        }
        
        container.register(MainRouter.self) { (r, controller: MainViewController) in
            let router = MainRouter()
            router.controller = controller
            router.filterAssembly = FilterAssembly()
            return router
        }
    }}
