//
//  BeautyProviderGeneralInfoView.swift
//  ZapisKZ
//
//  Created by Sultan on 11/16/20.
//  Copyright © 2020 Sultan Irkaliyev. All rights reserved.
//

import UIKit
import Cosmos

class BeautyProviderGeneralInfoView: UIView {

    //MARK: - IBOutlets
    @IBOutlet weak var beautyProviderNameLabel:             UILabelDeviceClass!
    @IBOutlet weak var beautyProviderTypeLabel:             UILabelDeviceClass!
    @IBOutlet weak var beautyProviderAddressLabel:          UILabelDeviceClass!
    @IBOutlet weak var beautyProviderAverageRatingLabel:    UILabelDeviceClass!
    @IBOutlet weak var beautyProviderRatingView:            CosmosView!
    @IBOutlet weak var beautyProviderReviewCountLabel:      UILabelDeviceClass!
    @IBOutlet weak var beautyProviderReservationCountLabel: UILabelDeviceClass!
    @IBOutlet weak var beautyCheckRatingView:               CosmosView!
    
    //MARK: - Delegate
    var delegate: BeautyProviderGeneralInfoViewDelegate?
    
    //MARK: - Properties
    var view: UIView!
    var nibName: String = "BeautyProviderGeneralInfoView"
    
    var beautyProvider: BeautyProvider? {
        willSet(beautyProvider) {
            guard let beautyProvider = beautyProvider else { return }
            beautyProviderNameLabel.text = beautyProvider.name
            beautyProviderTypeLabel.text = beautyProvider.type
            beautyProviderAddressLabel.text = beautyProvider.address
            
            if let averageRating = beautyProvider.averageRating {
                beautyProviderAverageRatingLabel.text = "\(averageRating)"
                beautyProviderRatingView.rating = averageRating
            } else {
                beautyProviderAverageRatingLabel.text = "0.0"
                beautyProviderRatingView.rating = 0
            }
            
            if let reviewCount = beautyProvider.reviewCount {
                beautyProviderReviewCountLabel.text = "\(reviewCount) отзывов"
            } else {
                beautyProviderReviewCountLabel.text = "Нет отзывов"
            }
            
            if let reservationCount = beautyProvider.todayReservationsCount {
                beautyProviderReservationCountLabel.text = "\(reservationCount)"
            } else {
                beautyProviderReservationCountLabel.text = "0"
            }
            
            if let checkRating = beautyProvider.checkRating {
                beautyCheckRatingView.rating = Double(checkRating)
            } else {
                beautyCheckRatingView.rating = 0.0
            }
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    func loadFromNib() -> UIView {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: nibName, bundle: bundle)
        let view = nib.instantiate(withOwner: self, options: nil).first as! UIView
        return view
    }
    
    func setupView() {
        view = loadFromNib()
        view.frame = bounds
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.layer.masksToBounds = true
        view.backgroundColor = .clear
        addSubview(view)
        setupUI()
    }
    
    func setupUI() {
        beautyProviderRatingView.settings.updateOnTouch = false
    }
    
    override class func awakeFromNib() {
        super.awakeFromNib()
    }
    
    //MARK: - IBActions
    
    @IBAction func locationButtonTapped(_ sender: UIButton) {
        delegate?.didTapLocationButton()
    }
}
