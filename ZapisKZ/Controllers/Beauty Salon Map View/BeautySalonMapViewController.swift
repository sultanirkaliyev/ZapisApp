//
//  BeautySalonMapViewController.swift
//  ZapisKZ
//
//  Created by Sultan on 11/17/20.
//  Copyright © 2020 Sultan Irkaliyev. All rights reserved.
//

import UIKit
import YandexMapKit

class BeautySalonMapViewController: UIViewController, Storyboarded {
    
    //MARK: - IBOutlets
    @IBOutlet weak var mapView: YMKMapView!
    
    //MARK: - ViewModel
    var viewModel: BeautySalonMapViewModel?
    
    //MARK: - UIViewController lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        setupNavigationBar()
        
        guard let viewModel = viewModel else { return }
        if let location = viewModel.getLocation() {
            coordinateToObjectOnMap(latitude: location.latitude, longitude: location.longitude)
        }
    }
}

extension BeautySalonMapViewController: YMKMapObjectTapListener {
    
    func coordinateToObjectOnMap(latitude: Double, longitude: Double) {
        let placemark = mapView.mapWindow.map.mapObjects.addPlacemark(with: YMKPoint(latitude: latitude, longitude: longitude))
        placemark.setIconWith(UIImage(named: "placemark_icon")!)
        placemark.addTapListener(with: self)
        
        mapView.mapWindow.map.move(
            with: YMKCameraPosition.init(target: YMKPoint(latitude: latitude, longitude: longitude), zoom: 15, azimuth: 0, tilt: 0),
            animationType: YMKAnimation(type: YMKAnimationType.smooth, duration: 2),
            cameraCallback: nil)
    }
    
    func onMapObjectTap(with mapObject: YMKMapObject, point: YMKPoint) -> Bool {
        guard let userPoint = mapObject as? YMKPlacemarkMapObject else {
            return true
        }
        print("Placemark tapped")
        return true
    }
}

extension BeautySalonMapViewController: ViewControllerAppearanceProtocol {
    
    func setupUI() {
        self.view.backgroundColor = .white
    }
    
    func setupNavigationBar() {
        self.title = "Местоположение салона"
    }
}
