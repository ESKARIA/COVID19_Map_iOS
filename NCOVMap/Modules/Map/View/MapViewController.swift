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

        self.view.backgroundColor = .white

        self.navigationController?.setNavigationBarHidden(true, animated: false)

        let stackView = self.createStackView()

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
        self.view.addSubview(stackView)
        mapContainer.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }

        stackView.snp.makeConstraints { (make) in
            make.left.equalTo(15)
            make.right.equalTo(-15)
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top).offset(15)
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

        self.confirmedCountLabel = UILabel.makeLabel(size: 25, weight: .bold, color: .white)
        self.recoveredCOuntLabel = UILabel.makeLabel(size: 25, weight: .bold, color: .white)
        self.deathCountLabel = UILabel.makeLabel(size: 25, weight: .bold, color: .white)

        self.confirmedCountLabel.text = "0"
        self.recoveredCOuntLabel.text = "0"
        self.deathCountLabel.text = "0"

        let views = [self.createViewForStack(type: .confirmed, valueLabel: self.confirmedCountLabel),
            self.createViewForStack(type: .recovered, valueLabel: self.recoveredCOuntLabel),
            self.createViewForStack(type: .death, valueLabel: self.deathCountLabel)]

        let stackView = UIStackView()
        stackView.distribution = .fillEqually
        stackView.alignment = .fill
        views.forEach { stackView.addArrangedSubview($0) }

        return stackView
    }

    private func createViewForStack(type: MapViewControllerCountLabelType, valueLabel: UILabel) -> UIView {
        let _view = UIView()
        _view.backgroundColor = .clear

        let titleLabel = UILabel.makeLabel(size: 18, weight: .regular, color: .gray)

        var title = ""
        switch type {
        case .confirmed:
            title = "Confirmed"
            let separator = self.getSeparator()
            _view.addSubview(separator)
            separator.snp.makeConstraints { (make) in
                make.width.equalTo(1)
                make.top.bottom.right.equalToSuperview()
            }
            let tap = UITapGestureRecognizer(target: self, action: #selector(didClickConfirmed(_:)))
            _view.addGestureRecognizer(tap)
        case .recovered:
            title = "Recovered"
            let tap = UITapGestureRecognizer(target: self, action: #selector(didClickRecovered(_:)))
            _view.addGestureRecognizer(tap)
        case .death:
            title = "Death"
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

    func show(count: StatisticsTotalModel) {
        self.incrementLabel(to: count.totalConfirmed, in: self.confirmedCountLabel)
        self.incrementLabel(to: count.totalRecovered, in: self.recoveredCOuntLabel)
        self.incrementLabel(to: count.totalDeath, in: self.deathCountLabel)
    }

    func incrementLabel(to endValue: Int, in label: UILabel) {
        let duration: Double = 2.0 //seconds
        DispatchQueue.global().async {
            for i in 0 ..< (endValue + 1) {
                let sleepTime = UInt32(duration / Double(endValue) * 1000000.0)
                usleep(sleepTime)
                DispatchQueue.main.async {
                    label.text = "\(i)"
                }
            }
        }
    }
}

extension MapViewController: GMSMapViewDelegate { }

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
