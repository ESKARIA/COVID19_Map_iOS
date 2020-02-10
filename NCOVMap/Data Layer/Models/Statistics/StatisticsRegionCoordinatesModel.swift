//
//  StatisticsRegionCoordinatesModel.swift
//  NCOVMap
//
//  Created by Дмитрий Торопкин on 10.02.2020.
//  Copyright © 2020 ESKARIA. All rights reserved.
//

import Foundation

class StatisticsRegionCoordinatesModel {
    
    var latitude: Double = 0
    var longitude: Double = 0
}

extension StatisticsRegionCoordinatesModel {
    
    static func convert(apiModel: StatisticsRegionJSONModel) -> StatisticsRegionCoordinatesModel {
        let model = StatisticsRegionCoordinatesModel()
        
        model.latitude = Double(apiModel.lat) ?? 0
        model.longitude = Double(apiModel.long) ?? 0
        
        return model
    }
}
