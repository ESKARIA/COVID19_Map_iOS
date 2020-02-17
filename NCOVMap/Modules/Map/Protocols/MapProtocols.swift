//
//  MapProtocols.swift
//  NCOV_Map
//
//  Created by Dmitriy on 10/02/2020.
//  Copyright © 2020 ESKARIA. All rights reserved.
//

import UIKit
import EKNetworking

// PRESENTER -> VIEW
protocol MapViewProtocol: class {
    func showOnMap(model: [StatisticsCircleViewModel])
}

// PRESENTER -> WIREFRAME
protocol MapWireFrameProtocol: class {
    func presentStatisticsVC(from view: MapViewProtocol?)
    func presentDescriptionViewController(from view: MapViewProtocol?, type: DescriptionCase, model: StatisticsModel)
}

// VIEW -> PRESENTER
protocol MapPresenterProtocol: class {
    func viewLoaded()
    func viewAppeared()
    func requestPoint(zoom: Float)
    func didClickConfirmed()
    func didClickDied()
    func didClickCured()
}

// PRESENTER -> INTERACTOR
protocol MapInteractorProtocol: class {
    func getStatistics(completion: @escaping (StatisticsModel?, EKNetworkError?) -> Void)
}
