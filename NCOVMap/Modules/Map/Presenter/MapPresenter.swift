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
                // TODO: - обработать ошибку
                return
            }
            guard let model = model else { return }
            self.statisticsModel = model
            self.requestPoint()
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
            
            if alpha < 28 {
                alpha = 28
            }
            
            let _coordinate = StatisticsCircleViewModel(longitude: coordinatesModel.coordinates.longitude, latitude: coordinatesModel.coordinates.latitude, radius: radius, alpha: alpha)
        
            result.append(_coordinate)
        }
        self.view?.showOnMap(model: result)
        self.view?.show(count: self.statisticsModel.totalInfo)
    }
    
}
