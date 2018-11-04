//
//  FilterObjectFactoryImpl.swift
//  PhotoFilter
//
//  Created by Татьяна on 04/11/2018.
//  Copyright © 2018 Татьяна. All rights reserved.
//

import UIKit

class FilterObjectFactoryImpl: NSObject, FilterObjectFactory {
    
    // MARK: FilterObjectFactory
    
    func cellObjects() -> [FilterCollectionViewCellObject] {
        var array = [FilterCollectionViewCellObject]()
        array.append(FilterCollectionViewCellObject(type: .no))
        array.append(FilterCollectionViewCellObject(type: .contrast))
        array.append(FilterCollectionViewCellObject(type: .invert))
        array.append(FilterCollectionViewCellObject(type: .monochrome))
        array.append(FilterCollectionViewCellObject(type: .posterize))
        array.append(FilterCollectionViewCellObject(type: .mono))
        array.append(FilterCollectionViewCellObject(type: .falseColor))
        array.append(FilterCollectionViewCellObject(type: .maximumComponent))
        array.append(FilterCollectionViewCellObject(type: .minimumComponent))
        array.append(FilterCollectionViewCellObject(type: .transfer))
        array.append(FilterCollectionViewCellObject(type: .sepia))
        array.append(FilterCollectionViewCellObject(type: .vignette))
        return array
    }
    
}
