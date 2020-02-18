//
//  StatisticsModel.swift
//  NCOVMap
//
//  Created by Дмитрий Торопкин on 10.02.2020.
//  Copyright © 2020 ESKARIA. All rights reserved.
//

import Foundation

class StatisticsModel {
    
    var totalInfo = StatisticsTotalModel()
    var regionsData = [StatisticsRegionModel]()
    
    // optional
    var fromCountry: String?
    
    func copy() -> StatisticsModel {
        let newValue = StatisticsModel()
        newValue.totalInfo = self.totalInfo.copy()
        newValue.regionsData = self.regionsData.compactMap({ $0.copy() })
        newValue.fromCountry = self.fromCountry
        return newValue
    }
}

extension StatisticsModel {
    
    static func convert(apiModel: StatisticsJSONModel) -> StatisticsModel {
        
        let model = StatisticsModel()
        model.totalInfo = StatisticsTotalModel.convert(apiModel: apiModel)
        model.regionsData = StatisticsRegionModel.convert(apiModel: apiModel.data ?? [])
        return model
    }
    
    func mergeCountries() -> [StatisticsRegionModel] {
        var datas = [StatisticsRegionModel]()
        let copyDatas = self.regionsData.compactMap { $0.copy() }
        for country in copyDatas {
            
            if let first = datas.first(where: { $0.countryName == country.countryName }) {
                first.stats.confirmed += country.stats.confirmed
                first.stats.death += country.stats.death
                first.stats.recovered += country.stats.recovered
            } else {
                datas.append(country)
            }
        }
        
        return datas
    }
}
