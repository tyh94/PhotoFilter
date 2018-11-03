//
//  MainViewModel.swift
//  PhotoFilter
//
//  Created by Татьяна on 03/11/2018.
//  Copyright © 2018 Татьяна. All rights reserved.
//

import UIKit

class MainViewModel: NSObject, MainViewOutput {
    
    weak var viewInput: MainViewInput!
    var router: MainRouter!
    var imagePickerHelper: ImagePickerHelper!
    
    // MARK: MainViewOutput
    
    func openCamera() {
        imagePickerHelper.openCamera { mediaInfo in
            if let mediaInfo = mediaInfo {
                self.router.openFilterModule(image: mediaInfo)
            }
        }
    }
    
    func openGallery() {
        imagePickerHelper.openPhotoLibrary { mediaInfo in
            if let mediaInfo = mediaInfo {
                self.router.openFilterModule(image: mediaInfo)
            }
        }
    }
    
}
