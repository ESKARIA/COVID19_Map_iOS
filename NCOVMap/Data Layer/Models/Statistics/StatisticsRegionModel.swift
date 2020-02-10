//
//  StatisticsRegionModel.swift
//  NCOVMap
//
//  Created by Дмитрий Торопкин on 10.02.2020.
//  Copyright © 2020 ESKARIA. All rights reserved.
//

import Foundation

class StatisticsRegionModel {
    
    var stateName: String = ""
    var countryName: String = ""
    var coordinates = StatisticsRegionCoordinatesModel()
    var dates = [StatisticsRegionDateModel]()
}

extension StatisticsRegionModel {
    
    static func convert(apiModel: StatisticsRegionJSONModel) -> StatisticsRegionModel {
        let model = StatisticsRegionModel()
        model.stateName = apiModel.state
        model.countryName = apiModel.country
        model.coordinates = StatisticsRegionCoordinatesModel.convert(apiModel: apiModel)
        model.dates = StatisticsRegionDateModel.convert(apiModel: apiModel.dates)
        return model
    }
    
    static func convert(apiModel: [StatisticsRegionJSONModel]) -> [StatisticsRegionModel] {
        var result = [StatisticsRegionModel]()
        for _apiModel in apiModel {
            let model = StatisticsRegionModel()
            model.stateName = _apiModel.state
            model.countryName = _apiModel.country
            model.coordinates = StatisticsRegionCoordinatesModel.convert(apiModel: _apiModel)
            model.dates = StatisticsRegionDateModel.convert(apiModel: _apiModel.dates)
            result.append(model)
        }
        return result
    }
}
