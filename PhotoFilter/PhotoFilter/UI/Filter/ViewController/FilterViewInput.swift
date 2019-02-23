//
//  FilterViewInput.swift
//  PhotoFilter
//
//  Created by Татьяна on 04/11/2018.
//  Copyright © 2018 Татьяна. All rights reserved.
//

import UIKit

protocol FilterViewInput: AnyObject {
    
    func setup(image: UIImage)
    
    func update(image: UIImage)
    
    func update(cellObjects: [FilterCollectionViewCellObject])
    
    func croppedImageRect() -> CGRect
    
}
