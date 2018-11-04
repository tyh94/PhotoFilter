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
    
    func share(image: UIImage) {
        let activity = UIActivityViewController(activityItems: [image],
                                                applicationActivities: nil)
        controller.present(activity,
                           animated: true,
                           completion: nil)
    }
    
}

