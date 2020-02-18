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

    }
    
    func getStatistics() {
        self.interactor.getStatistics { (model, error) in
            if error != nil {
                // TODO: - обработать ошибку
                return
            }
            guard let model = model else { return }
            self.statisticsModel = model
            self.requestPoint()
            
            self.interactor.getLocation { (place, error) in
                if error != nil {
                    // TODO: - обработать ошибку
                    return
                }
                self.statisticsModel.fromCountry = place?.country
            }
        }
    }
    
    func requestPoint(zoom: Float = 0) {
        
        var result = [StatisticsCircleViewModel]()
        for coordinatesModel in self.statisticsModel.regionsData {
            
            let totalConfirmed = Double(self.statisticsModel.totalInfo.totalConfirmed)
            let currentRegionConfirmed = Double(coordinatesModel.dates.last?.confirmed ?? 0)
            
            var radius = (currentRegionConfirmed / totalConfirmed) * 1000000
            
            if radius < 100000 {
                radius = 100000
            }
            
            if radius > 1000000 {
                radius = 1000000
            }
            
            let totalDeath = Double(self.statisticsModel.totalInfo.totalDeath)
            let currentRegionDeath = Double(coordinatesModel.dates.last?.death ?? 0)
            
            var alpha = (currentRegionDeath / totalDeath) * 100
            
            alpha = alpha * 0.7
            if alpha < 28 {
                alpha = 28
            }
            
            let _coordinate = StatisticsCircleViewModel(longitude: coordinatesModel.coordinates.longitude,
                                                        latitude: coordinatesModel.coordinates.latitude,
                                                        radius: radius,
                                                        alpha: alpha,
                                                        countryName: coordinatesModel.countryName,
                                                        totalConfirmed: coordinatesModel.dates.last?.confirmed,
                                                        totalDeath: coordinatesModel.dates.last?.death,
                                                        totalRecovered: coordinatesModel.dates.last?.recovered)
        
            result.append(_coordinate)
        }
        self.view?.showOnMap(model: result)
        self.view?.show(count: self.statisticsModel.totalInfo)
    }
    
    func didClickConfirmed() {
        self.wireFrame.presentDescriptionViewController(from: self.view, type: .confirmed, model: self.statisticsModel)
    }
    
    func didClickDied() {
        self.wireFrame.presentDescriptionViewController(from: self.view, type: .died, model: self.statisticsModel)
    }
    
    func didClickCured() {
        self.wireFrame.presentDescriptionViewController(from: self.view, type: .recovered, model: self.statisticsModel)
    }
}
