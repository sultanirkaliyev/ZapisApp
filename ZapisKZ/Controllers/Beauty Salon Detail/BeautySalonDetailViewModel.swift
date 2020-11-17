//
//  BeautySalonDetailViewModel.swift
//  ZapisKZ
//
//  Created by Sultan on 11/16/20.
//  Copyright © 2020 Sultan Irkaliyev. All rights reserved.
//

import Foundation
import PromiseKit

class BeautySalonDetailViewModel {
    
    //MARK: - Moya Provider
    var beautySalonListDataService: BeautySalonListDataService
    
    //MARK: - Data Binding Properties
    var networkRequestFailureReason: Box<NetworkRequestFailureReason?> = Box(nil)
    var beautyProviderDetailPageData: Box<ServerResponseBeautyProviderDetailData?> = Box(nil)
    
    //MARK: - Properties
    var weekDates = Date().getWeekDays(date: Date())
    var beautyProviderID: Int
    
    init(beautyProviderID: Int, beautySalonListDataService: BeautySalonListDataService) {
        self.beautyProviderID = beautyProviderID
        self.beautySalonListDataService = beautySalonListDataService
        fetchBeautyProviderInformation()
    }
    
    func getLocation() -> BeautyProviderLocation? {
        return beautyProviderDetailPageData.value?.location
    }
}

//MARK: - Table View helper

extension BeautySalonDetailViewModel {
    
    func getTableViewSectionHeaderTitle(atSection section: Int) -> String? {
        switch section {
            case 0: return "Расписание".uppercased()
            case 1: return "Список услуг".uppercased()
            case 2: return "Мастера".uppercased()
            default: return nil
        }
    }
    
    func getNumberOfWeekday() -> Int {
        return weekDates.count
    }
    
    func getBeautyHoursTableViewCellViewModel(atIndexPath indexPath: IndexPath) -> BeautyHoursTableViewCellViewModel? {
        guard let workStartTime = beautyProviderDetailPageData.value?.firm?.workStartTime, let workEndTime = beautyProviderDetailPageData.value?.firm?.workEndTime else { return nil }
        return BeautyHoursTableViewCellViewModel(workStartTime: workStartTime, workEndTime: workEndTime, date: weekDates[indexPath.row], indexPath: indexPath)
    }
    
    func getNumberOfBeautyServices() -> Int {
        guard let beautyServices = beautyProviderDetailPageData.value?.services else { return 0 }
        return beautyServices.count
    }
    
    func getBeautyServiceTableViewCellViewModel(atIndexPath indexPath: IndexPath) -> BeautyServiceTableViewCellViewModel? {
        guard let beautyService = beautyProviderDetailPageData.value?.services?[indexPath.row] else { return nil }
        return BeautyServiceTableViewCellViewModel(beautyService: beautyService, indexPath: indexPath)
    }
    
    func getNumberOfMasters() -> Int {
        guard let masters = beautyProviderDetailPageData.value?.masters else { return 0 }
        return masters.count
    }
    
    func getBeautyMasterTableViewCellViewModel(atIndexPath indexPath: IndexPath) -> BeautyMasterTableViewCellViewModel? {
        guard let masters = beautyProviderDetailPageData.value?.masters else { return nil }
        return BeautyMasterTableViewCellViewModel(beautyMaster: masters[indexPath.row], indexPath: indexPath)
    }
}

//MARK: - Collection View helper

extension BeautySalonDetailViewModel {
    
    func getNumberOfGalleryImages() -> Int {
        guard let images = beautyProviderDetailPageData.value?.firm?.pictures else { return 0 }
        return images.count
    }
    
    func getBeautyImageCollectionViewCellViewModel(atIndexPath indexPath: IndexPath) -> BeautyProviderImageCollectionViewCellViewModel? {
        guard let image = beautyProviderDetailPageData.value?.firm?.pictures?[indexPath.row] else { return nil }
        return BeautyProviderImageCollectionViewCellViewModel(image: image, indexPath: indexPath)
    }
}

//MARK: - Data fetch

extension BeautySalonDetailViewModel {
    
    func fetchBeautyProviderInformation() {
        
        firstly {
            beautySalonListDataService.getBeautyProviderInformation(beautyProviderID: beautyProviderID)
        }.done { (result) in
            switch result {
            case .success(payload: let serverData): self.beautyProviderDetailPageData.value = serverData
            default: break
            }
        }.catch { (error) in
            self.networkRequestFailureReason.value = error as? NetworkRequestFailureReason
        }
    }
}
