//
//  BaseButton.swift
//  PhotoFilter
//
//  Created by Татьяна on 04/11/2018.
//  Copyright © 2018 Татьяна. All rights reserved.
//

import UIKit

class BaseButton: UIButton {
    
    override var isHighlighted: Bool {
        didSet(newValue) {
            backgroundColor = backgroundColor?.withAlphaComponent((state == .normal) ? 1 : 0.7)
        }
        willSet(newValue){
            backgroundColor = backgroundColor?.withAlphaComponent((state == .normal) ? 1 : 0.7)
        }
    }
    
    override var isSelected: Bool {
        didSet(newValue) {
            backgroundColor = backgroundColor?.withAlphaComponent((state == .normal) ? 1 : 0.7)
        }
        willSet(newValue){
            backgroundColor = backgroundColor?.withAlphaComponent((state == .normal) ? 1 : 0.7)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        layer.cornerRadius = 12
        setTitleColor(UIColor(named: "textColor"), for: .normal)
        setTitleColor(UIColor(named: "textColor")?.withAlphaComponent(0.7), for: .highlighted)
    }
    
}
