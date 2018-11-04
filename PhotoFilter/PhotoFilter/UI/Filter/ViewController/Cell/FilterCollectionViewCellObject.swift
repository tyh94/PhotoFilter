//
//  FilterCollectionViewCellObject.swift
//  PhotoFilter
//
//  Created by Татьяна on 04/11/2018.
//  Copyright © 2018 Татьяна. All rights reserved.
//

import UIKit

class FilterCollectionViewCellObject: NSObject {

    var type: FilterType!
    var image: UIImage!
    
    init(type: FilterType) {
        super.init()
        self.type = type
    }
    
}
