//
//  FilterCollectionViewCell.swift
//  PhotoFilter
//
//  Created by Татьяна on 04/11/2018.
//  Copyright © 2018 Татьяна. All rights reserved.
//

import UIKit
import IGListKit

class FilterCollectionViewCell: UICollectionViewCell, ListBindable {
    
    @IBOutlet weak var imageView: UIImageView!
    
    override var isSelected: Bool {
        didSet {
            alpha = isSelected ? 0.5 : 1.0
        }
    }
    
    // MARK: ListBindable
    func bindViewModel(_ viewModel: Any) {
        if let viewModel = viewModel as? FilterCollectionViewCellObject {
            imageView.image = viewModel.image
        }
    }

}
