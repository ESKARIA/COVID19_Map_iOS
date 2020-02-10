//
//  MapPresenter.swift
//  NCOV_Map
//
//  Created by Dmitriy on 10/02/2020.
//  Copyright © 2020 ESKARIA. All rights reserved.
//
import EKNetworking
import UIKit

class MapPresenter: BasePresenter {

    weak var view: MapViewProtocol?
    private var wireFrame: MapWireFrameProtocol
    private var interactor: MapInteractorProtocol

    private var statisticsModel = StatisticsModel()
    
    init(view: MapViewProtocol, wireFrame: MapWireFrameProtocol, interactor: MapInteractorProtocol) {
        self.view = view
        self.interactor = interactor
        self.wireFrame = wireFrame
    }
}

extension MapPresenter: MapPresenterProtocol {
    
    func viewLoaded() {
        self.getStatistics()
    }
    
    func viewAppeared() {
        self.wireFrame.presentStatisticsVC(from: view)
    }
    
    func getStatistics() {
        self.interactor.getStatistics { (model, error) in
            if let error = error {
                return
            }
            guard let model = model else { return }
            self.statisticsModel = model
            self.requestPoint()
        }
    }
    
    func requestPoint() {
        var encodedCoordinates = [String]()
        for coordinatesModel in self.statisticsModel.regionsData {
            let hash = Geohash.encode(latitude: coordinatesModel.coordinates.latitude, longitude: coordinatesModel.coordinates.longitude, precision: .sixHundredThirtyKilometers)
            encodedCoordinates.append(hash)
        }
        
        encodedCoordinates = Array(Set(encodedCoordinates))
        let decodedCoordinates = encodedCoordinates.compactMap{Geohash.decode(hash: $0)}
        
        var result = [StatisticsRegionCoordinatesModel]()
        for coordinate in decodedCoordinates {
            let _coordinate = StatisticsRegionCoordinatesModel()
            _coordinate.latitude = coordinate.latitude.max - coordinate.latitude.min
            _coordinate.longitude = coordinate.longitude.max - coordinate.longitude.min
            
            result.append(_coordinate)
        }
        
        self.view?.showOnMap(model: result)
    }
    
}
