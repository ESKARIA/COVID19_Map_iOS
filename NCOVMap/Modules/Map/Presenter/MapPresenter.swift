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

    init(view: MapViewProtocol, wireFrame: MapWireFrameProtocol, interactor: MapInteractorProtocol) {
        self.view = view
        self.interactor = interactor
        self.wireFrame = wireFrame
    }
}

extension MapPresenter: MapPresenterProtocol {
    
    func viewLoaded() {
        
    }
    
    func viewAppeared() {
        self.wireFrame.presentStatisticsVC(from: view)
    }
    
    func getStatistics() {
        self.interactor.getStatistics { (model, error) in
            if let error = error {
                return
            }
            guard let showedData = model?.regionsData else { return }
            self.view?.showOnMap(model: showedData)
        }
    }
}
