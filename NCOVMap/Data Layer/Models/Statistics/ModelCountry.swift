//
//  ModelCountry.swift
//  NCOVMap
//
//  Created by Emil Karimov on 01.04.2020.
//  Copyright © 2020 ESKARIA. All rights reserved.
//


import Foundation

class ModelCountry {

    var country: String = ""
    var countryInfo: ModelCountryInfo?
    var cases: Int = 0
    var todayCases: Int?
    var deaths: Int = 0
    var todayDeaths: Int?
    var recovered: Int = 0
    var active: Int?
    var critical: Int?
    var casesPerOneMillion: Double?
    var deathsPerOneMillion: Double?
    var updated: Date?

    var fromCountry: String?

}

extension ModelCountry {

    static func convert(apiModel: JSONCountryBase) -> ModelCountry {

        let model = ModelCountry()
        model.country = apiModel.country
        if let value = apiModel.countryInfo {
            model.countryInfo = ModelCountryInfo.convert(apiModel: value)
        }
        model.cases = apiModel.cases
        model.todayCases = apiModel.todayCases
        model.deaths = apiModel.deaths
        model.todayDeaths = apiModel.todayDeaths
        model.recovered = apiModel.recovered
        model.active = apiModel.active
        model.critical = apiModel.critical
        model.casesPerOneMillion = apiModel.casesPerOneMillion
        model.deathsPerOneMillion = apiModel.deathsPerOneMillion
        if let value = apiModel.updated {
            model.updated = Date(timeIntervalSince1970: TimeInterval(value/1000))
        }
        return model
    }
}
