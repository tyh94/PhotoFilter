//
//  MainRouter.swift
//  PhotoFilter
//
//  Created by Татьяна on 03/11/2018.
//  Copyright © 2018 Татьяна. All rights reserved.
//

import UIKit
import Swinject
import SwinjectStoryboard

class MainRouter: NSObject {

    var controller: UIViewController!
    var filterAssembly: FilterAssembly!
    
    func openFilterModule(image: UIImage) {
        let filterController = getFilterController()
        controller.present(filterController, animated: true, completion: {
            
            filterController.imageView.image = image
        })
    }
    
    // Private
    private func getFilterController() -> FilterViewController {
        let assembler = Assembler([filterAssembly])
        let storyboard = SwinjectStoryboard.create(name: "Filter",
                                                   bundle: nil,
                                                   container: assembler.resolver)
        return storyboard.instantiateInitialViewController() as! FilterViewController
    }
}
