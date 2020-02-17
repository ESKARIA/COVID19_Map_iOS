//
//  MapViewController.swift
//  NCOV_Map
//
//  Created by Dmitriy on 10/02/2020.
//  Copyright © 2020 ESKARIA. All rights reserved.
//

import UIKit
import SnapKit
import GoogleMaps
import GooglePlaces
import DevHelper

class MapViewController: BaseViewController {

    var presenter: MapPresenterProtocol!
    
    var mapView: GMSMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.createUI()
        self.presenter.viewLoaded()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.presenter.viewAppeared()
    }

    private func createUI() {

        self.view.backgroundColor = .white
        self.title = "Map"
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: themeManager.mapScreenGetTitleNavigationColor()]
        
        let mapContainer = UIView()
        let camera = GMSCameraPosition(latitude: 0, longitude: 0, zoom: 1)
        self.mapView = GMSMapView(frame: mapContainer.frame, camera: camera)
        self.mapView.delegate = self
        self.setupMaps()
        mapContainer.addSubview(self.mapView)
        self.mapView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        
        self.view.addSubview(mapContainer)
        mapContainer.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
//        
//        let confirmedButton = UIButton(type: .custom)
//        confirmedButton.setTitle("Confirmed", for: .normal)
//        confirmedButton.addTarget(self, action: #selector(didClickConfirmed(_:)), for: .touchUpInside)
//        confirmedButton.backgroundColor = .systemBlue
//        
//        self.view.addSubview(confirmedButton)
//        confirmedButton.snp.makeConstraints {
//            $0.center.equalToSuperview()
//            $0.height.equalTo(44)
//            $0.width.equalTo(140)
//        }
//        
        self.setNeedsStatusBarAppearanceUpdate()
    }

    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    
    //map design
    private func setupMaps() {
        do {
          // Set the map style by passing the URL of the local file.
            if let styleURL = self.themeManager.mapScreenGetGoogleMapsColorMode() {
            mapView.mapStyle = try GMSMapStyle(contentsOfFileURL: styleURL)
          } else {
            NSLog("Unable to find style.json")
          }
        } catch {
          NSLog("One or more of the map styles failed to load. \(error)")
        }
    }
    
    override func userActivatedDarkMode(execute: (() -> Void)? = nil) {
        super.userActivatedDarkMode {
            self.setupMaps()
            self.navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: self.themeManager.mapScreenGetTitleNavigationColor()]
        }
    }
    
    override func userActivateLightMode(execute: (() -> Void)? = nil) {
        super.userActivateLightMode {
            self.setupMaps()
            self.navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: self.themeManager.mapScreenGetTitleNavigationColor()]
        }
    }
     
}
extension MapViewController: MapViewProtocol {
    
    func showOnMap(model: [StatisticsCircleViewModel]) {
        mapView.clear()
        for dotkaOnMap in model {
            let position = CLLocationCoordinate2D(latitude: dotkaOnMap.latitude, longitude: dotkaOnMap.longitude)
            let circle = GMSCircle(position: position, radius: dotkaOnMap.radius)
            let color = UIColor.red.withAlphaComponent(CGFloat(dotkaOnMap.alpha / 100))
            circle.fillColor = color
            circle.strokeColor = .clear
            circle.map = mapView
        }
    }
}

extension MapViewController: GMSMapViewDelegate {}

// MARK: - Private
extension MapViewController {
    @objc private func didClickConfirmed(_ sender: UIButton) {
        self.presenter.didClickConfirmed()
    }
}
