//
//  Main+SwinjectStoryboard.swift
//  PhotoFilter
//
//  Created by Татьяна on 03/11/2018.
//  Copyright © 2018 Татьяна. All rights reserved.
//

import Swinject
import SwinjectStoryboard

extension SwinjectStoryboard {
    
    public static func setup() {
        Assembler([MainAssembly(), FilterAssembly()], container: defaultContainer)
    }
}
