//
//  CustomAppointmentButton.swift
//  ZapisKZ
//
//  Created by Sultan on 11/17/20.
//  Copyright © 2020 Sultan Irkaliyev. All rights reserved.
//

import UIKit

class CustomAppointmentButton: UIButtonDeviceClass {
    
    @IBInspectable var indicatorColor : UIColor = .white
    
    var originalButtonText: String?
    var activityIndicator: UIActivityIndicatorView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupButton()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupButton()
    }
    
    override var isEnabled: Bool {
        didSet {
            if isEnabled {
                setupButton()
            } else {
                setupDisabledButtonStyle()
            }
        }
    }
    
    func setupButton() {
        setupButtonStyle()
        if let imageView = self.imageView{
            self.bringSubviewToFront(imageView)
        }
    }
    
    func setupButtonStyle() {
        self.setTitleColor(UIColor.white, for: .normal)
        backgroundColor = #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)
        tintColor = .white
        layer.cornerRadius = 10
    }
    
    func setupDisabledButtonStyle() {
        self.setTitleColor(UIColor.white, for: .normal)
        backgroundColor = #colorLiteral(red: 0.721568644, green: 0.8862745166, blue: 0.5921568871, alpha: 1)
        tintColor = .white
        layer.cornerRadius = 10
    }
}

//MARK: - Activity Indicator extension

extension CustomAppointmentButton {
    
    func showLoading() {
        originalButtonText = self.titleLabel?.text
        self.setTitle("", for: .normal)
        
        if (activityIndicator == nil) {
            activityIndicator = createActivityIndicator()
        }
        self.isUserInteractionEnabled = false
        showSpinning()
    }
    
    func hideLoading() {
        DispatchQueue.main.async(execute: {
            if self.activityIndicator != nil {
                self.setTitle(self.originalButtonText, for: .normal)
                self.activityIndicator.stopAnimating()
                self.isUserInteractionEnabled = true
            }
        })
    }
    
    private func createActivityIndicator() -> UIActivityIndicatorView {
        let activityIndicator = UIActivityIndicatorView()
        activityIndicator.hidesWhenStopped = true
        activityIndicator.color = indicatorColor
        return activityIndicator
    }
    
    private func showSpinning() {
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(activityIndicator)
        centerActivityIndicatorInButton()
        activityIndicator.startAnimating()
    }
    
    private func centerActivityIndicatorInButton() {
        let xCenterConstraint = NSLayoutConstraint(item: self, attribute: .centerX, relatedBy: .equal, toItem: activityIndicator, attribute: .centerX, multiplier: 1, constant: 0)
        self.addConstraint(xCenterConstraint)
        
        let yCenterConstraint = NSLayoutConstraint(item: self, attribute: .centerY, relatedBy: .equal, toItem: activityIndicator, attribute: .centerY, multiplier: 1, constant: 0)
        self.addConstraint(yCenterConstraint)
    }
}
