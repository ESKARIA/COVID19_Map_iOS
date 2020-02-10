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

    override func viewDidLoad() {
        super.viewDidLoad()
        self.createUI()

    }

    private func createUI() {

        let ma
    }

}
extension MapViewController: MapViewProtocol { }
