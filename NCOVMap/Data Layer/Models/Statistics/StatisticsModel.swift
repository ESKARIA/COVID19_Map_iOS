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
}

extension StatisticsModel {
    
    static func convert(apiModel: StatisticsJSONModel) -> StatisticsModel {
        
        let model = StatisticsModel()
        model.totalInfo = StatisticsTotalModel.convert(apiModel: apiModel)
        model.regionsData = StatisticsRegionModel.convert(apiModel: apiModel.data)
        
        return model
    }
}
