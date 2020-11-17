//
//  BeautyProviderImageCollectionViewCell.swift
//  ZapisKZ
//
//  Created by Sultan on 11/17/20.
//  Copyright © 2020 Sultan Irkaliyev. All rights reserved.
//

import UIKit

class BeautyProviderImageCollectionViewCell: UICollectionViewCell, ConfigurableCell {
    
    //MARK: - IBOutlets
    @IBOutlet weak var imageView: UIImageView!
    
    //MARK: - Reuse Identifier
    static var reuseID: String = "BeautyProviderImageCollectionViewCell"
    
    //MARK: - IndexPath
    private var indexPath: IndexPath?
    
    //MARK: - ViewModel
    var viewModel: BeautyProviderImageCollectionViewCellViewModel? {
        willSet(viewModel) {
            guard let viewModel = viewModel else { return }
            indexPath = viewModel.indexPath
            
            if let url = URL(string: viewModel.preparedImage) {
                imageView.setIndicatorStyle(.medium)
                imageView.setShowActivityIndicator(true)
                imageView.sd_setImage(with: url, placeholderImage: UIImage(named: "image_not_found_placeholder"))
            } else {
                imageView.image = UIImage(named: "image_not_found_placeholder")
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }
}

extension BeautyProviderImageCollectionViewCell {
    
    func setupUI() {
        imageView.contentMode = .scaleAspectFill
        imageView.layer.masksToBounds = true
    }
}
