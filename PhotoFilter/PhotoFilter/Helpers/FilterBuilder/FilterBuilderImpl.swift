//
//  FilterFactoryImpl.swift
//  PhotoFilter
//
//  Created by Татьяна on 04/11/2018.
//  Copyright © 2018 Татьяна. All rights reserved.
//

import UIKit

class FilterBuilderImpl: NSObject, FilterBuilder {

    // MARK: FilterFactory
    func buildFilter(type: FilterType,
                     inputImage: UIImage) -> CIFilter? {
        switch type {
        case .no:
            return nil
        case .contrast:
            if let filter = CIFilter.init(name: "CIColorControls") {
                let inputImage = CIImage.init(image: inputImage)
                filter.setValue(inputImage, forKey: "inputImage")
                filter.setValue(1.5, forKey: "inputContrast")
                return filter
            }
        case .invert:
            if let filter = CIFilter.init(name: "CIColorInvert") {
                let inputImage = CIImage.init(image: inputImage)
                filter.setValue(inputImage, forKey: "inputImage")
                return filter
            }
        case .monochrome:
            if let filter = CIFilter.init(name: "CIColorMonochrome") {
                let inputImage = CIImage.init(image: inputImage)
                filter.setValue(inputImage, forKey: "inputImage")
                return filter
            }
        }
        return nil
    }
}
