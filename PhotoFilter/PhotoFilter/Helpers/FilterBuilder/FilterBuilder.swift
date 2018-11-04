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
}

protocol FilterBuilder {
    
    func buildFilter(type: FilterType,
                     inputImage: UIImage) -> CIFilter?

}
