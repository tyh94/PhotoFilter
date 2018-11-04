//
//  FilterBuilder.swift
//  PhotoFilter
//
//  Created by Татьяна on 04/11/2018.
//  Copyright © 2018 Татьяна. All rights reserved.
//

import UIKit

enum FilterType {
    case no
    case contrast
    case invert
    case monochrome
    case posterize
    case falseColor
    case mono
    case maximumComponent
    case minimumComponent
    case transfer
    case sepia
    case vignette
}

protocol FilterBuilder {
    
    func buildFilter(type: FilterType,
                     inputImage: UIImage) -> CIFilter?

}
