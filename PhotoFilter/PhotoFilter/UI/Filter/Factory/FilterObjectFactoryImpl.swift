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
        return array
    }
    
}
