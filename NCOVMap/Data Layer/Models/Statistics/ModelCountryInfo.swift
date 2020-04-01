//
//  ModelCountryInfo.swift
//  NCOVMap
//
//  Created by Emil Karimov on 01.04.2020.
//  Copyright © 2020 ESKARIA. All rights reserved.
//


import Foundation

class ModelCountryInfo {

    var _id: Int?
    var iso2: String?
    var iso3: String?
    var lat: Double?
    var long: Double?
    var flag: String?

}

extension ModelCountryInfo {
    
    static func convert(apiModel: JSONCountryInfo) -> ModelCountryInfo {

        let model = ModelCountryInfo()
        
        model._id = apiModel._id
        model.iso2 = apiModel.iso2
        model.iso3 = apiModel.iso3
        model.lat = apiModel.lat
        model.long = apiModel.long
        model.flag = apiModel.flag

        return model
    }
}
