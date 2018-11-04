//
//  FrameView.swift
//  PhotoFilter
//
//  Created by Татьяна on 04/11/2018.
//  Copyright © 2018 Татьяна. All rights reserved.
//

import UIKit

class FrameView: UIView {

    override func awakeFromNib() {
        super.awakeFromNib()
        layer.cornerRadius = 12
        layer.borderColor = UIColor(named: "mainColor")?.cgColor
        layer.borderWidth = 3
    }

}
