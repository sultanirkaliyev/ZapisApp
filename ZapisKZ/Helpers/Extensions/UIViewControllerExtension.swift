//
//  UIViewControllerExtension.swift
//  ZapisKZ
//
//  Created by Sultan on 11/17/20.
//  Copyright © 2020 Sultan Irkaliyev. All rights reserved.
//

import Foundation
import UIKit
import SnapKit

fileprivate var activityIndicatorView: UIView?

extension UIViewController {
    
    //MARK: - Activity Indicator animating
    
    func showLoading() {
        activityIndicatorView = UIView(frame: self.view.bounds)
        activityIndicatorView?.backgroundColor = .white
        let activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.center = activityIndicatorView!.center
        activityIndicator.startAnimating()
        activityIndicatorView?.addSubview(activityIndicator)
        self.view.addSubview(activityIndicatorView!)
    }
    
    func hideLoading() {
        activityIndicatorView?.removeFromSuperview()
        activityIndicatorView = nil
    }
    
    func showLoadingWithText(text: String) {
        
        activityIndicatorView = UIView(frame: self.view.bounds)
        activityIndicatorView?.backgroundColor = .white
        let activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.startAnimating()
        
        let activityIndicatorText = UILabelDeviceClass()
        activityIndicatorText.textAlignment = .center
        activityIndicatorText.textColor = .black
        activityIndicatorText.text = text
        activityIndicatorText.font = .systemFont(ofSize: 14)
        activityIndicatorText.numberOfLines = 3
        activityIndicatorText.overrideFontSize(fontSize: 14)
        
        let stackView = UIStackView(arrangedSubviews: [activityIndicator, activityIndicatorText])
        stackView.alignment = .center
        stackView.distribution = .equalCentering
        stackView.spacing = 0
        stackView.axis = .vertical
        
        activityIndicatorView?.addSubview(stackView)
        
        stackView.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
        }
        
        self.view.addSubview(activityIndicatorView!)
    }
}
