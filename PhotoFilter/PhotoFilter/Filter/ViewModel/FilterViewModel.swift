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
    var filteredImage: UIImage!

    // MARK: FilterViewOutput
    
    func configure(image: UIImage) {
        filteredImage = image
    }
    
    func moduleWasLoaded() {
        viewInput.setup(image: filteredImage)
    }
}
