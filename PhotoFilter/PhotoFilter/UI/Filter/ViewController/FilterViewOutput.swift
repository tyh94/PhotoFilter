//
//  FilterViewOutput.swift
//  PhotoFilter
//
//  Created by Татьяна on 04/11/2018.
//  Copyright © 2018 Татьяна. All rights reserved.
//

import UIKit

protocol FilterViewOutput: AnyObject {
    
    func moduleWasLoaded()
    
    func configure(image: UIImage)
    
    func didSelect(object: FilterCollectionViewCellObject)
    
    func shareCurrentImage()

}
