//
//  MapPresenter.swift
//  NCOV_Map
//
//  Created by Dmitriy on 10/02/2020.
//  Copyright © 2020 ESKARIA. All rights reserved.
//
import EKNetworking
import UIKit
import EKIPLocation
import Crashlytics

class MapPresenter: BasePresenter {
    
    weak var view: MapViewProtocol?
    private var wireFrame: MapWireFrameProtocol
    private var interactor: MapInteractorProtocol
    
    private var countries = [ModelCountry]()
    private var fromCountry: String?
    
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
        self.interactor.getStatistics { (models, error) in
            
            if let error = error {
                print(error.localizedDescription)
            }
            
            EKIPLocationManager.shared.fetchLocation { (place) in
                guard let models = models else { return }
                models.forEach {
                    $0.fromCountry = place?.country
                }
                self.fromCountry = place?.country
                if let place = place {
                    self.view?.centerOnPlace(place)
                }
                
                if error != nil {
                    // TODO: - обработать ошибку
                    return
                }
                self.countries = models
                self.requestPoint()
            }
            
        }
    }
    
    func requestPoint(zoom: Float = 0) {
        
        let queue = DispatchQueue(label: "MapRresenter")
        
        queue.async {
            var result = [StatisticsCircleViewModel]()
            
            var totalConfirmed: Double = 0
            var totalDeath: Double = 0
            
            self.countries.forEach {
                totalConfirmed += Double($0.cases)
                totalDeath += Double($0.deaths)
            }
            
            for countryModel in self.countries {
                
                let currentRegionConfirmed = Double(countryModel.cases)
                
                var radius = (currentRegionConfirmed / totalConfirmed) * 1000000
                
                if radius < 100000 {
                    radius = 100000
                }
                
                if radius > 1000000 {
                    radius = 1000000
                }
                
                let currentRegionDeath = Double(countryModel.deaths)
                
                var alpha = (currentRegionDeath / totalDeath) * 100
                
                alpha = alpha * 0.7
                if alpha < 28 {
                    alpha = 28
                }
                
                let _coordinate = StatisticsCircleViewModel(longitude: countryModel.countryInfo?.long ?? 0,
                                                            latitude: countryModel.countryInfo?.lat ?? 0,
                                                            radius: radius,
                                                            alpha: alpha,
                                                            countryName: countryModel.country,
                                                            totalConfirmed: countryModel.cases,
                                                            totalDeath: countryModel.deaths,
                                                            totalRecovered: countryModel.recovered)
                
                result.append(_coordinate)
            }
            
            DispatchQueue.main.async {
                self.view?.showOnMap(model: result)
                self.view?.show(count: self.countries)
            }
        }
    }
    
    func didClickConfirmed() {
        self.wireFrame.presentDescriptionViewController(from: self.view, type: .confirmed, models: self.countries)
    }
    
    func didClickDied() {
        self.wireFrame.presentDescriptionViewController(from: self.view, type: .died, models: self.countries)
    }
    
    func didClickCured() {
        self.wireFrame.presentDescriptionViewController(from: self.view, type: .recovered, models: self.countries)
    }
}
