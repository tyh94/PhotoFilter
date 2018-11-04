//
//  SharingHelperImpl.swift
//  PhotoFilter
//
//  Created by Татьяна on 04/11/2018.
//  Copyright © 2018 Татьяна. All rights reserved.
//

import UIKit

class SharingHelperImpl: NSObject, SharingHelper {

    var controller: UIViewController!
    
    // MARK: SharingHelper
    
    func share(image: UIImage,
               barButtonItem: UIBarButtonItem) {
        let activity = UIActivityViewController(activityItems: [image],
                                                applicationActivities: nil)
        activity.popoverPresentationController?.barButtonItem = barButtonItem
        controller.present(activity,
                           animated: true,
                           completion: nil)
    }
    
}

