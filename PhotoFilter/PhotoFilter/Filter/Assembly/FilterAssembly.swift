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
        
        container.storyboardInitCompleted(FilterViewController.self) { r, c in
            c.viewOutput = r.resolve(FilterViewOutput.self,
                                     argument: c as FilterViewController)
        }
        
        container.register(FilterViewOutput.self) { (r, controller: FilterViewController) in
            let model = FilterViewModel()
            model.viewInput = controller
            return model
        }
    }
}
