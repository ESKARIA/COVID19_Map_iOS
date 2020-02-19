//
//  StatisticsTotalModel.swift
//  NCOVMap
//
//  Created by Дмитрий Торопкин on 10.02.2020.
//  Copyright © 2020 ESKARIA. All rights reserved.
//

import Foundation

class StatisticsTotalModel {

    var totalConfirmed: Int = 0
    var totalRecovered: Int = 0
    var totalDeath: Int = 0

    func copy() -> StatisticsTotalModel {
        let newValue = StatisticsTotalModel()
        newValue.totalDeath = self.totalDeath
        newValue.totalConfirmed = self.totalConfirmed
        newValue.totalRecovered = self.totalRecovered
        return newValue
    }
}

extension StatisticsTotalModel {

    static func convert(apiModel: StatisticsJSONModel) -> StatisticsTotalModel {
        let model = StatisticsTotalModel()
        model.totalConfirmed = apiModel.totalConfirmed
        model.totalRecovered = apiModel.totalRecovered
        model.totalDeath = apiModel.totalDeath

        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"

        return model
    }
}
