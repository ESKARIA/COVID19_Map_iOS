//
//  MapViewController.swift
//  NCOV_Map
//
//  Created by Dmitriy on 10/02/2020.
//  Copyright © 2020 ESKARIA. All rights reserved.
//

import UIKit
import SnapKit

class MapViewController: BaseViewController {

    var presenter: MapPresenterProtocol!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.createUI()

    }

    private func createUI() {

//        let label = UILabel.makeLabel(size: 36, weight: .medium, color: .black)
//        label.text = "Map"
//
//        self.view.addSubview(label)
//        label.snp.makeConstraints {
//            $0.center.equalToSuperview()
//        }
    }

}
extension MapViewController: MapViewProtocol { }
