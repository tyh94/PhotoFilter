//
//  FilterViewModel.swift
//  PhotoFilter
//
//  Created by Татьяна on 03/11/2018.
//  Copyright © 2018 Татьяна. All rights reserved.
//

import UIKit

class FilterViewModel: NSObject, FilterViewOutput {
    
    weak var viewInput: FilterViewInput!
    var factory: FilterObjectFactory!
    var builder: FilterBuilder!
    
    var originalImage: UIImage!
    var filteredImage: UIImage!

    // MARK: FilterViewOutput
    
    func configure(image: UIImage) {
        originalImage = image
        filteredImage = image
    }
    
    func moduleWasLoaded() {
        viewInput.setup(image: originalImage)
        let cellObjects = factory.cellObjects(for: originalImage)
        viewInput.update(cellObjects: cellObjects)
    }
    
    func didSelect(object: FilterCollectionViewCellObject) {
        let context = CIContext.init(options: nil)
        if let filter = builder.buildFilter(type: object.type,
                                            inputImage: originalImage) {
            if let image = createFilteredImage(context: context,
                                               filter: filter) {
                filteredImage = image
                viewInput.setup(image: image)
            }
        } else {
            viewInput.setup(image: originalImage)
        }
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
