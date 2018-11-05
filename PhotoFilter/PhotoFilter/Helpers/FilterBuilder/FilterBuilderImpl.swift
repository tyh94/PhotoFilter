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
                filter.setValue(inputImage, forKey: kCIInputImageKey)
                filter.setValue(1.5, forKey: "inputContrast")
                return filter
            }
        case .invert:
            if let filter = CIFilter.init(name: "CIColorInvert") {
                let inputImage = CIImage.init(image: inputImage)
                filter.setValue(inputImage, forKey: kCIInputImageKey)
                return filter
            }
        case .monochrome:
            if let filter = CIFilter.init(name: "CIColorMonochrome") {
                let inputImage = CIImage.init(image: inputImage)
                filter.setValue(inputImage, forKey: kCIInputImageKey)
                return filter
            }
        case .posterize:
            if let filter = CIFilter.init(name: "CIColorPosterize") {
                let inputImage = CIImage.init(image: inputImage)
                filter.setValue(inputImage, forKey: kCIInputImageKey)
                return filter
            }
        case .falseColor:
            if let filter = CIFilter.init(name: "CIFalseColor") {
                let inputImage = CIImage.init(image: inputImage)
                filter.setValue(inputImage, forKey: kCIInputImageKey)
                return filter
            }
        case .mono:
            if let filter = CIFilter.init(name: "CIPhotoEffectMono") {
                let inputImage = CIImage.init(image: inputImage)
                filter.setValue(inputImage, forKey: kCIInputImageKey)
                return filter
            }
        case .maximumComponent:
            if let filter = CIFilter.init(name: "CIMaximumComponent") {
                let inputImage = CIImage.init(image: inputImage)
                filter.setValue(inputImage, forKey: kCIInputImageKey)
                return filter
            }
        case .minimumComponent:
            if let filter = CIFilter.init(name: "CIMinimumComponent") {
                let inputImage = CIImage.init(image: inputImage)
                filter.setValue(inputImage, forKey: kCIInputImageKey)
                return filter
            }
        case .transfer:
            if let filter = CIFilter.init(name: "CIPhotoEffectTransfer") {
                let inputImage = CIImage.init(image: inputImage)
                filter.setValue(inputImage, forKey: kCIInputImageKey)
                return filter
            }
        case .sepia:
            if let filter = CIFilter.init(name: "CISepiaTone") {
                let inputImage = CIImage.init(image: inputImage)
                filter.setValue(inputImage, forKey: kCIInputImageKey)
                filter.setValue(1.5, forKey: "inputIntensity")
                return filter
            }
        case .vignette:
            if let filter = CIFilter.init(name: "CIVignette") {
                let inputImage = CIImage.init(image: inputImage)
                filter.setValue(inputImage, forKey: kCIInputImageKey)
                filter.setValue(5.0, forKey: "inputIntensity")
                filter.setValue(15.0, forKey: "inputRadius")
                return filter
            }
        }
        return nil
    }
}
