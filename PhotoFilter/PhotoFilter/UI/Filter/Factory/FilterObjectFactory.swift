//
//  FilterObjectFactory.swift
//  PhotoFilter
//
//  Created by Татьяна on 04/11/2018.
//  Copyright © 2018 Татьяна. All rights reserved.
//

import UIKit

protocol FilterObjectFactory {
    
    func cellObjects() -> [FilterCollectionViewCellObject]

}
