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
import EKIPLocation

enum MapViewControllerCountLabelType {
    case recovered
    case confirmed
    case death
}

class MapViewController: BaseViewController {
    
    var presenter: MapPresenterProtocol!
    
    var mapView: GMSMapView!
    
    var recoveredCOuntLabel: UILabel!
    var confirmedCountLabel: UILabel!
    var deathCountLabel: UILabel!
    
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
        
        self.view.backgroundColor = R.color.appDark()
        
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        
        let stackView = self.createStackView()
        
        let mapContainer = UIView()
        let camera = GMSCameraPosition(latitude: 0, longitude: 0, zoom: 1)
        self.mapView = GMSMapView(frame: mapContainer.frame, camera: camera)
        self.mapView.delegate = self
        self.mapView.setMinZoom(3, maxZoom: 10)
        self.setupMaps()
        
        mapContainer.addSubview(self.mapView)
        self.mapView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        
        self.view.addSubview(mapContainer)
        self.view.addSubview(stackView)
        mapContainer.snp.makeConstraints {
            $0.top.equalTo(self.view.safeAreaLayoutGuide.snp.top).offset(15)
            $0.left.right.equalToSuperview()
            $0.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom)
        }
        
        stackView.snp.makeConstraints { (make) in
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top).offset(15)
            make.left.equalTo(15)
            make.right.equalTo(-15)
            make.height.equalTo(56)
        }
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
    
    private func createStackView() -> UIStackView {
        
        self.confirmedCountLabel = UILabel.makeLabel(size: 22, weight: .bold, color: .white)
        self.confirmedCountLabel.adjustsFontSizeToFitWidth = true
        self.confirmedCountLabel.numberOfLines = 1
        
        self.recoveredCOuntLabel = UILabel.makeLabel(size: 22, weight: .bold, color: .white)
        self.recoveredCOuntLabel.adjustsFontSizeToFitWidth = true
        self.recoveredCOuntLabel.numberOfLines = 1
        
        self.deathCountLabel = UILabel.makeLabel(size: 22, weight: .bold, color: .white)
        self.deathCountLabel.adjustsFontSizeToFitWidth = true
        self.deathCountLabel.numberOfLines = 1
        
        self.confirmedCountLabel.text = "0"
        self.recoveredCOuntLabel.text = "0"
        self.deathCountLabel.text = "0"
        
        let views = [
            self.createViewForStack(type: .recovered, valueLabel: self.recoveredCOuntLabel),
            self.createViewForStack(type: .confirmed, valueLabel: self.confirmedCountLabel),
            self.createViewForStack(type: .death, valueLabel: self.deathCountLabel)
        ]
        
        let stackView = UIStackView()
        stackView.distribution = .fillEqually
        stackView.alignment = .leading
        views.forEach { stackView.addArrangedSubview($0) }
        
        return stackView
    }
    
    private func createViewForStack(type: MapViewControllerCountLabelType, valueLabel: UILabel) -> UIView {
        let _view = UIView()
        _view.backgroundColor = .clear
        
        let titleLabel = UILabel.makeLabel(size: 14, weight: .regular, color: R.color.appBattleshipGrey().unwrapped())
        
        var title = ""
        switch type {
        case .recovered:
            title = R.string.localizable.map_Recovered_Title()
            let separator = self.getSeparator()
            _view.addSubview(separator)
            separator.snp.makeConstraints { (make) in
                make.width.equalTo(1)
                make.top.bottom.right.equalToSuperview()
            }
            let tap = UITapGestureRecognizer(target: self, action: #selector(didClickRecovered(_:)))
            _view.addGestureRecognizer(tap)
        case .confirmed:
            title = R.string.localizable.map_Confirmed_Title()
            let tap = UITapGestureRecognizer(target: self, action: #selector(didClickConfirmed(_:)))
            _view.addGestureRecognizer(tap)
        case .death:
            title = R.string.localizable.map_Death_Title()
            let separator = self.getSeparator()
            _view.addSubview(separator)
            separator.snp.makeConstraints { (make) in
                make.width.equalTo(1)
                make.top.bottom.left.equalToSuperview()
            }
            let tap = UITapGestureRecognizer(target: self, action: #selector(didClickDeath(_:)))
            _view.addGestureRecognizer(tap)
        }
        titleLabel.text = title
        
        _view.addSubview(titleLabel)
        _view.addSubview(valueLabel)
        
        titleLabel.snp.makeConstraints { (make) in
            make.left.equalTo(20)
            make.right.equalTo(-20)
            make.height.equalTo(22)
            make.top.equalToSuperview()
        }
        
        valueLabel.snp.makeConstraints { (make) in
            make.top.equalTo(titleLabel.snp.bottom)
            make.left.equalTo(20)
            make.right.equalTo(-20)
            make.height.equalTo(28)
            make.bottom.equalToSuperview()
        }
        titleLabel.adjustsFontSizeToFitWidth = true
        titleLabel.numberOfLines = 1
        titleLabel.sizeToFit()
        
        titleLabel.layoutIfNeeded()
        
        
        _view.bringSubviewToFront(titleLabel)
        return _view
    }
    
    private func getSeparator() -> UIView {
        let _view = UIView()
        _view.backgroundColor = .gray
        return _view
    }
}

extension MapViewController: MapViewProtocol {
    func centerOnPlace(_ place: EKPlaceModel) {
        if let lat = place.lat, let lng = place.lon {
            let coord = CLLocationCoordinate2D(latitude: lat, longitude: lng)
            DispatchQueue.main.async {
                self.mapView.animate(toLocation: coord)
            }
        }
    }
    
    
    func showOnMap(model: [StatisticsCircleViewModel]) {
        let queue = DispatchQueue(label: "com.mapview.googleMaps.insertData", qos: .utility)
        queue.async {
            self.mapView.clear()
            for dotkaOnMap in model {
                let position = CLLocationCoordinate2D(latitude: dotkaOnMap.latitude, longitude: dotkaOnMap.longitude)
                let circle = GMSCircle(position: position, radius: dotkaOnMap.radius)
                let color = UIColor.red.withAlphaComponent(CGFloat(dotkaOnMap.alpha / 100))
                circle.fillColor = color
                circle.strokeColor = .clear
                circle.map = self.mapView
                
                let marker = GMSMarker(position: position)
                marker.opacity = 0
                marker.icon = UIImage()
                marker.setIconSize(scaledToSize: CGSize(width: 50, height: 30))
                marker.title = dotkaOnMap.countryName
                if let confirmed = dotkaOnMap.totalConfirmed, let death = dotkaOnMap.totalDeath, let recovered = dotkaOnMap.totalRecovered {
                    let infoStringConfirmed = "\(R.string.localizable.map_Confirmed_Snippet()) \(confirmed)"
                    let infoStringRecovered = "\(R.string.localizable.map_Recovered_Snippet()) \(recovered)"
                    let infoStringDeath = "\(R.string.localizable.map_Death_Snippet()) \(death)"
                    marker.snippet = "\(infoStringConfirmed)\n\(infoStringRecovered)\n\(infoStringDeath)"
                }
                marker.map = self.mapView
            }
        }
    }
    
    func show(count: [ModelCountry]) {
        
        var totalCases = 0
        var totalDeaths = 0
        var totalRecovered = 0
        
        count.forEach {
            totalCases += $0.cases
            totalDeaths += $0.deaths
            totalRecovered += $0.recovered
        }
        
        self.incrementLabel(to: totalCases, in: self.confirmedCountLabel)
        self.incrementLabel(to: totalDeaths, in: self.recoveredCOuntLabel)
        self.incrementLabel(to: totalRecovered, in: self.deathCountLabel)
    }
    
    func incrementLabel(to endValue: Int, in label: UILabel) {
        let duration: Double = 2 //seconds
        
        let queue = DispatchQueue(label: "com.mapview.counterLabel.increment", qos: .utility)
        queue.async {
            for i in 0...endValue {
                let sleepTime = UInt32(duration / Double(endValue) * 10000.0)
                usleep(sleepTime)
                
                if i % 10 == 0 || i == endValue {
                    DispatchQueue.main.async {
                        label.text = "\(i)"
                    }
                }
            }
            DispatchQueue.main.async {
                label.sizeToFit()
                label.layoutIfNeeded()
            }
        }
    }
}

extension MapViewController: GMSMapViewDelegate {
    
}

// MARK: - Private
extension MapViewController {
    @objc private func didClickConfirmed(_ sender: UIButton) {
        self.presenter.didClickConfirmed()
    }
    
    @objc private func didClickDeath(_ sender: UIButton) {
        self.presenter.didClickDied()
    }
    
    @objc private func didClickRecovered(_ sender: UIButton) {
        self.presenter.didClickCured()
    }
}
