//
//  ImagePickerHelper.swift
//  PhotoFilter
//
//  Created by Татьяна on 03/11/2018.
//  Copyright © 2018 Татьяна. All rights reserved.
//

import UIKit

protocol ImagePickerHelper {

    func openCamera(completion: @escaping ((UIImage?) -> Void))
    
    func openPhotoLibrary(completion: @escaping ((UIImage?) -> Void))
}
