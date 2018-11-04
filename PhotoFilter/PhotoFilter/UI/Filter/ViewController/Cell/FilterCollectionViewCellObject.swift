//
//  FilterCollectionViewCellObject.swift
//  PhotoFilter
//
//  Created by Татьяна on 04/11/2018.
//  Copyright © 2018 Татьяна. All rights reserved.
//

import UIKit
import IGListKit

class FilterCollectionViewCellObject: NSObject, ListDiffable {

    var type: FilterType!
    var image: UIImage!
    
    init(type: FilterType,
         image: UIImage) {
        super.init()
        self.type = type
        self.image = image
    }
    
    // MARK: ListDiffable
    func diffIdentifier() -> NSObjectProtocol {
        return hash as NSObjectProtocol
    }
    
    func isEqual(toDiffableObject object: ListDiffable?) -> Bool {
        if let object = object as? FilterCollectionViewCellObject {
            return type == object.type
        }
        return false
    }
}
