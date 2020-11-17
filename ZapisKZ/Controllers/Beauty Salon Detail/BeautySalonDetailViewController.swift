//
//  BeautySalonDetailViewController.swift
//  ZapisKZ
//
//  Created by Sultan on 11/16/20.
//  Copyright © 2020 Sultan Irkaliyev. All rights reserved.
//

import UIKit

class BeautySalonDetailViewController: UIViewController, Storyboarded {
    
    //MARK: - IBOutlets    
    @IBOutlet weak var beautyProviderImagesCollectionView: AutoScrollCollectionView!
    @IBOutlet weak var beautyProviderGeneralInfoView:      BeautyProviderGeneralInfoView!
    @IBOutlet weak var tableView:                          ContentSizedTableView!
    @IBOutlet weak var appointmentButtonContainerView:     UIView!
    
    //MARK: - Coordinator
    var coordinator: BeautySalonDetailCoordinator?
    
    //MARK: - ViewModel
    var viewModel: BeautySalonDetailViewModel?
    
    //MARK: - UIViewController lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        registerTableViewCells()
        setupCollectionView()
        registerCollectionViewCells()
        bindData()
    }
    
    //MARK: - MVVM Data Binding
    
    func bindData() {
        if let viewModel = viewModel {
            
            viewModel.beautyProviderDetailPageData.bind { [weak self] in
                guard let value = $0 else { return }
                self?.hideLoading()
                if let beautyProviderName = value.firm?.name {
                    self?.setupNavigationBar(withTitle: beautyProviderName)
                }
                self?.fillBeautyProviderMainInformation(beautyProvider: value.firm)
                self?.tableView.reloadData()
                self?.beautyProviderImagesCollectionView.reloadData()
            }
        }
    }
}

extension BeautySalonDetailViewController: ViewControllerAppearanceProtocol {
    
    func setupUI() {
        self.view.backgroundColor = tableView.backgroundColor
        
        appointmentButtonContainerView.setCustomShadow(color: UIColor(red: 0, green: 0, blue: 0, alpha: 0.2), opacity: 1, offset: CGSize.zero, radius: 0)
        self.showLoadingWithText(text: "Загружаем информацию о салоне")
    }
    
    func setupNavigationBar() {}
    func setupNavigationBar(withTitle title: String) {
        self.title = title
    }
    
    func fillBeautyProviderMainInformation(beautyProvider: BeautyProvider?) {
        guard let beautyProvider = beautyProvider else { return }
        beautyProviderGeneralInfoView.beautyProvider = beautyProvider
        beautyProviderGeneralInfoView.delegate = self
    }
    
    func setupTableView() {
        tableView.tableFooterView = UIView()
    }
    
    func registerTableViewCells() {
        tableView.register(UINib(nibName: "BeautyHoursTableViewCell", bundle: nil), forCellReuseIdentifier: BeautyHoursTableViewCell.reuseID)
        tableView.register(UINib(nibName: "BeautyServiceTableViewCell", bundle: nil), forCellReuseIdentifier: BeautyServiceTableViewCell.reuseID)
        tableView.register(UINib(nibName: "BeautyMasterTableViewCell", bundle: nil), forCellReuseIdentifier: BeautyMasterTableViewCell.reuseID)
    }
    
    func setupCollectionView() {
        if let layout = beautyProviderImagesCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.scrollDirection = .horizontal
        }
        beautyProviderImagesCollectionView.layoutIfNeeded()
        beautyProviderImagesCollectionView.startAutoScrolling(withTimeInterval: 2.0)
    }
    
    func registerCollectionViewCells() {
        beautyProviderImagesCollectionView.register(UINib(nibName: "BeautyProviderImageCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: BeautyProviderImageCollectionViewCell.reuseID)
    }
}

extension BeautySalonDetailViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        guard let viewModel = viewModel else { return nil }
        return viewModel.getTableViewSectionHeaderTitle(atSection: section)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let viewModel = viewModel else { return 0 }
        
        switch section {
            case 0: return viewModel.getNumberOfWeekday()
            case 1: return viewModel.getNumberOfBeautyServices()
            case 2: return viewModel.getNumberOfMasters()
            default: return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let viewModel = viewModel else { return UITableViewCell() }
        
        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: BeautyHoursTableViewCell.reuseID, for: indexPath) as! BeautyHoursTableViewCell
            if let cellViewModel = viewModel.getBeautyHoursTableViewCellViewModel(atIndexPath: indexPath) {
                cell.viewModel = cellViewModel
            }
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: BeautyServiceTableViewCell.reuseID, for: indexPath) as! BeautyServiceTableViewCell
            if let cellViewModel = viewModel.getBeautyServiceTableViewCellViewModel(atIndexPath: indexPath) {
                cell.viewModel = cellViewModel
            }
            return cell
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: BeautyMasterTableViewCell.reuseID, for: indexPath) as! BeautyMasterTableViewCell
            if let cellViewModel = viewModel.getBeautyMasterTableViewCellViewModel(atIndexPath: indexPath) {
                cell.viewModel = cellViewModel
                cell.accessoryType = .disclosureIndicator
            }
            return cell
        default: return UITableViewCell()
        }
    }
}

extension BeautySalonDetailViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let viewModel = viewModel else { return 0 }
        return viewModel.getNumberOfGalleryImages()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let viewModel = viewModel else { return UICollectionViewCell() }
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BeautyProviderImageCollectionViewCell.reuseID, for: indexPath) as! BeautyProviderImageCollectionViewCell
        
        if let cellViewModel = viewModel.getBeautyImageCollectionViewCellViewModel(atIndexPath: indexPath) {
            cell.viewModel = cellViewModel
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.beautyProviderImagesCollectionView.bounds.width, height: 200)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
}

extension BeautySalonDetailViewController: BeautyProviderGeneralInfoViewDelegate {
    
    func didTapLocationButton() {
        guard let viewModel = viewModel, let location = viewModel.getLocation() else { return }
        coordinator?.showBeautyProviderOnMap(beautyProviderLocation: location)
    }
}
