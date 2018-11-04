//
//  FilterObjectFactoryImpl.swift
//  PhotoFilter
//
//  Created by Татьяна on 04/11/2018.
//  Copyright © 2018 Татьяна. All rights reserved.
//

import UIKit

class FilterObjectFactoryImpl: NSObject, FilterObjectFactory {

    var builder: FilterBuilder!
    // MARK: FilterObjectFactory
    
    func cellObjects(for image: UIImage) -> [FilterCollectionViewCellObject] {
        var array = [FilterCollectionViewCellObject]()
        array.append(FilterCollectionViewCellObject(type: .no,
                                                    image: image))
        let context = CIContext.init(options: nil)
        
        let contrastFilter = builder.buildFilter(type: .contrast,
                                                inputImage: image)
        array.append(FilterCollectionViewCellObject(type: .contrast,
                                                    image: createFilteredImage(context: context,
                                                                               filter: contrastFilter!)!))
        
        let invertFilter = builder.buildFilter(type: .invert,
                                               inputImage: image)
        array.append(FilterCollectionViewCellObject(type: .invert,
                                                    image: createFilteredImage(context: context,
                                                                               filter: invertFilter!)!))
        
        let monochromeFilter = builder.buildFilter(type: .monochrome,
                                               inputImage: image)
        array.append(FilterCollectionViewCellObject(type: .monochrome,
                                                    image: createFilteredImage(context: context,
                                                                               filter: monochromeFilter!)!))
        
        return array
    }
    
    func createFilteredImage(context: CIContext,
                             filter: CIFilter) -> UIImage? {
        if let outputImage = filter.outputImage {
            if let imageRef = context.createCGImage(outputImage,
                                                    from: outputImage.extent) {
                return UIImage.init(cgImage: imageRef)
            }
        }
        return nil
    }
}
