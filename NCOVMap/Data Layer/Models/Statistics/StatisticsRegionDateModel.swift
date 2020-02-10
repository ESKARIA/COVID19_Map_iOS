//
//  StatisticsRegionDateModel.swift
//  NCOVMap
//
//  Created by Дмитрий Торопкин on 10.02.2020.
//  Copyright © 2020 ESKARIA. All rights reserved.
//

import Foundation

class StatisticsRegionDateModel {
    
    var date = Date()
    var confirmed = 0
    var recovered = 0
    var death = 0
}

extension StatisticsRegionDateModel {
    
    static func convert(apiModel: StatisticsRegionDateJSONModel) -> StatisticsRegionDateModel {
        let model = StatisticsRegionDateModel()
        
        model.confirmed = apiModel.confirmed
        model.recovered = apiModel.recovered
        model.death = apiModel.death
        
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let date = dateFormatter.date(from:apiModel.date)
        model.date = date ?? Date()
        
        return model
    }
    
    static func convert(apiModel: [StatisticsRegionDateJSONModel]) -> [StatisticsRegionDateModel] {
        
        var result = [StatisticsRegionDateModel]()
        for _apiModel in apiModel {
            let model = StatisticsRegionDateModel()
            
            model.confirmed = _apiModel.confirmed
            model.recovered = _apiModel.recovered
            model.death = _apiModel.death
            
            let dateFormatter = DateFormatter()
            dateFormatter.locale = Locale(identifier: "en_US_POSIX")
            dateFormatter.dateFormat = "yyyy-MM-dd"
            let date = dateFormatter.date(from: _apiModel.date)
            model.date = date ?? Date()
            
            result.append(model)
        }
        return result
    }
}
