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
        
        let mapContainer = UIView()
        let camera = GMSCameraPosition(latitude: 0, longitude: 0, zoom: 1)
        self.mapView = GMSMapView(frame: mapContainer.frame, camera: camera)
        self.setupMaps()
        mapContainer.addSubview(self.mapView)
        self.mapView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        
        self.view.addSubview(mapContainer)
        mapContainer.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }

    //map design
    private func setupMaps() {
        do {
          // Set the map style by passing the URL of the local file.
            if let styleURL = self.themeManager.googleMapsColorMode() {
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
        }
    }
    
    override func userActivateLightMode(execute: (() -> Void)? = nil) {
        super.userActivateLightMode {
            self.setupMaps()
        }
    }
     
}
extension MapViewController: MapViewProtocol { }
