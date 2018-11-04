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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = NSLocalizedString("MAIN_NAVIGATION_TITLE",
                                  comment: "")
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

