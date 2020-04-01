//
//  MapProtocols.swift
//  NCOV_Map
//
//  Created by Dmitriy on 10/02/2020.
//  Copyright © 2020 ESKARIA. All rights reserved.
//

import UIKit
import EKNetworking
import EKIPLocation

// PRESENTER -> VIEW
protocol MapViewProtocol: class {
    func showOnMap(model: [StatisticsCircleViewModel])
    func show(count: [ModelCountry])
    func centerOnPlace(_ place: EKPlaceModel)
}

// PRESENTER -> WIREFRAME
protocol MapWireFrameProtocol: class {
    func presentDescriptionViewController(from view: MapViewProtocol?, type: DescriptionCase, models: [ModelCountry])
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
    func getStatistics(completion: @escaping ([ModelCountry]?, EKNetworkError?) -> Void)
}
