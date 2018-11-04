//
//  FilterViewController.swift
//  PhotoFilter
//
//  Created by Татьяна on 03/11/2018.
//  Copyright © 2018 Татьяна. All rights reserved.
//

import UIKit

class FilterViewController: UIViewController, FilterViewInput {
    
    var viewOutput: FilterViewOutput!

    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = NSLocalizedString("FILTER_NAVIGATION_TITLE", comment: "")
        viewOutput.moduleWasLoaded()
    }
    
    // MARK: FilterViewInput
    
    func setup(image: UIImage) {
        imageView.image = image
    }
    
}
