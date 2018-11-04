//
//  MainViewController.swift
//  PhotoFilter
//
//  Created by Татьяна on 03/11/2018.
//  Copyright © 2018 Татьяна. All rights reserved.
//

import UIKit

class MainViewController: UIViewController, MainViewInput {

    var viewOutput: MainViewOutput!
    @IBOutlet weak var openCameraButton: BaseButton!
    @IBOutlet weak var openGalleryButton: BaseButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = NSLocalizedString("MAIN_NAVIGATION_TITLE",
                                  comment: "")
        openCameraButton.setTitle(NSLocalizedString("OPEN_CAMERA_BUTTON_TITLE", comment: ""), for: .normal)
        openGalleryButton.setTitle(NSLocalizedString("OPEN_PHOTO_LIBRARY_BUTTON_TITLE", comment: ""), for: .normal)

    }

    // MARK: MainViewInput

    // MARK: Action
    
    @IBAction func openCamera() {
        viewOutput.openCamera()
    }
    
    @IBAction func openGallery() {
        viewOutput.openGallery()
    }
}

