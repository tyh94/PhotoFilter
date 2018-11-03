//
//  ImagePickerHelperImpl.swift
//  PhotoFilter
//
//  Created by Татьяна on 03/11/2018.
//  Copyright © 2018 Татьяна. All rights reserved.
//

import UIKit

class ImagePickerHelperImpl: NSObject, ImagePickerHelper, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    var completion: ((UIImage?) -> Void)!
    var controller: UIViewController!
    
    // MARK: ImagePickerHelper
    func openCamera(completion: @escaping ((UIImage?) -> Void)) {
        self.completion = completion
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = .camera
//        imagePicker.mediaTypes = [kUTTypeImage]
        imagePicker.delegate = self
        controller.present(imagePicker, animated: true, completion: nil)
    }
    
    func openPhotoLibrary(completion: @escaping ((UIImage?) -> Void)) {
        self.completion = completion
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = .photoLibrary
        imagePicker.delegate = self
        controller.present(imagePicker, animated: true, completion: nil)
    }
    
    // MARK: UIImagePickerControllerDelegate
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true) {
            let pickedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage
            self.completion(pickedImage)
        }
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true) {
            self.completion(nil)
        }
    }
}
