//
//  MapProtocols.swift
//  NCOV_Map
//
//  Created by Dmitriy on 10/02/2020.
//  Copyright © 2020 ESKARIA. All rights reserved.
//

import UIKit

// PRESENTER -> VIEW
protocol MapViewProtocol: class {
}

// PRESENTER -> WIREFRAME
protocol MapWireFrameProtocol: class {
    func presentStatisticsVC(from view: MapViewProtocol?)
}

// VIEW -> PRESENTER
protocol MapPresenterProtocol: class {
    func viewLoaded()
    func viewAppeared()
}

// PRESENTER -> INTERACTOR
protocol MapInteractorProtocol: class { }
