//
//  CustomRoundedGrayButton.swift
//  ZapisKZ
//
//  Created by Sultan on 11/17/20.
//  Copyright © 2020 Sultan Irkaliyev. All rights reserved.
//

import UIKit

class CustomRoundedGrayButton: UIButtonDeviceClass {
    
    @IBInspectable var image: UIImage? {
        didSet {
            setupButtonStyle()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupButton()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupButton()
    }
    
    func setupButton() {
        setupButtonStyle()
        if let imageView = self.imageView{
            self.bringSubviewToFront(imageView)
        }
    }
    
    func setupButtonStyle() {
        self.setImage(image, for: .normal)
        self.setTitle(nil, for: .normal)
        self.setTitleColor(UIColor.black, for: .normal)
        backgroundColor = #colorLiteral(red: 0.9244490266, green: 0.9246038795, blue: 0.9244285822, alpha: 1)
        tintColor = .black
        layer.cornerRadius = 15
    }
}
