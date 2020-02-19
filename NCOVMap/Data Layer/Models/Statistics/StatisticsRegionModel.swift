//
//  StatisticsRegionModel.swift
//  NCOVMap
//
//  Created by Дмитрий Торопкин on 10.02.2020.
//  Copyright © 2020 ESKARIA. All rights reserved.
//

import Foundation

struct StatsRegionModel {
    var confirmed = 0
    var recovered = 0
    var death = 0
    
    func copy() -> StatsRegionModel {
        var newValue = StatsRegionModel()
        newValue.confirmed = self.confirmed
        newValue.death = self.death
        newValue.recovered = self.recovered
        
        return newValue
    }
    
}

class StatisticsRegionModel {

    var stateName: String = ""
    var countryName: String = ""
    var coordinates = StatisticsRegionCoordinatesModel()
    var dates = [StatisticsRegionDateModel]()

    //optionals
    var stats: StatsRegionModel = StatsRegionModel()
    
    func copy() -> StatisticsRegionModel {
        let newValue = StatisticsRegionModel()
        newValue.stateName = self.stateName
        newValue.countryName = self.countryName
        newValue.coordinates = self.coordinates
        newValue.dates = self.dates
        newValue.stats = self.stats.copy()
        
        return newValue
    }
}

extension StatisticsRegionModel {

    static func convert(apiModel: StatisticsRegionJSONModel) -> StatisticsRegionModel {
        let model = StatisticsRegionModel()
        model.stateName = apiModel.state
        model.countryName = apiModel.country
        model.coordinates = StatisticsRegionCoordinatesModel.convert(apiModel: apiModel)
        model.dates = StatisticsRegionDateModel.convert(apiModel: apiModel.dates)
        model.stats = model.getStatsByRegion()
        return model
    }

    static func convert(apiModel: [StatisticsRegionJSONModel]) -> [StatisticsRegionModel] {
        let models = apiModel.compactMap({ StatisticsRegionModel.convert(apiModel: $0) })
        return models
    }

    private func getStatsByRegion() -> StatsRegionModel {

        var stats = StatsRegionModel()

        guard let date = self.dates.sorted(by: { $0.date < $1.date }).last else { return stats }
        stats.confirmed = date.confirmed
        stats.death = date.death
        stats.recovered = date.recovered

        return stats
    }
}
