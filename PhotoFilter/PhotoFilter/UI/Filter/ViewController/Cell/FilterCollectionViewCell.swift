//
//  FilterCollectionViewCell.swift
//  PhotoFilter
//
//  Created by Татьяна on 04/11/2018.
//  Copyright © 2018 Татьяна. All rights reserved.
//

import UIKit

class FilterCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.layer.cornerRadius = 12.0
    }
    
    func bindViewModel(_ viewModel: FilterCollectionViewCellObject) {
        imageView.image = viewModel.image
    }

}
