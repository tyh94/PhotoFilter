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
    var shareHelper: SharingHelper!
    
    var originalImage: UIImage!
    var originalScalledImage: UIImage!
    var filteredImage: UIImage!
    var cellObjects = [FilterCollectionViewCellObject]()

    // MARK: FilterViewOutput
    
    func configure(image: UIImage) {
        let normalizedImage = image.fixOrientation()
        originalImage = normalizedImage
        let cellSide = 150 * UIScreen.main.scale
        originalScalledImage = normalizedImage.resizeImage(targetSize: CGSize(width: cellSide, height: cellSide))
        filteredImage = normalizedImage
    }
    
    func getImage(index: Int, completion: @escaping ((UIImage) -> (Void))) {
        guard cellObjects.count > index else { return }
        let object = cellObjects[index]
        if (object.image != nil) {
            completion(object.image)
        }
        else {
            DispatchQueue.global(qos: .userInitiated).async { [weak self] in
                guard let self = self else { return }
                let context = CIContext.init(options: nil)
                if let filter = self.builder.buildFilter(type: object.type,
                                                         inputImage: self.originalScalledImage) {
                    if let image = self.createFilteredImage(context: context,
                                                            filter: filter) {
                        object.image = image
                        DispatchQueue.main.async {
                            completion(image)
                        }
                    }
                } else {
                    DispatchQueue.main.async {[weak self] in
                        guard let self = self else { return }
                        completion(self.originalScalledImage)
                    }
                }
            }
        }
    }
    
    func moduleWasLoaded() {
        viewInput.setup(image: originalImage)
        DispatchQueue.global(qos: .userInitiated).async { [weak self] in
            guard let self = self else { return }
            let cellObjects = self.factory.cellObjects()
            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return }
                self.cellObjects = cellObjects
                self.viewInput.update(cellObjects: cellObjects)
            }
        }
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
    
    func shareCurrentImage(barButtonItem: UIBarButtonItem) {
        shareHelper.share(image: filteredImage,
                          barButtonItem: barButtonItem)
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
