//
//  JSONCountryInfo.swift
//  NCOVMap
//
//  Created by Emil Karimov on 01.04.2020.
//  Copyright © 2020 ESKARIA. All rights reserved.
//


import Foundation

struct JSONCountryInfo: Codable {

    let _id: Int?
    let iso2: String?
    let iso3: String?
    let lat: Double?
    let long: Double?
    let flag: String?

    enum CodingKeys: String, CodingKey {

        case _id = "_id"
        case iso2 = "iso2"
        case iso3 = "iso3"
        case lat = "lat"
        case long = "long"
        case flag = "flag"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        _id = try values.decodeIfPresent(Int.self, forKey: ._id)
        iso2 = try values.decodeIfPresent(String.self, forKey: .iso2)
        iso3 = try values.decodeIfPresent(String.self, forKey: .iso3)
        lat = try values.decodeIfPresent(Double.self, forKey: .lat)
        long = try values.decodeIfPresent(Double.self, forKey: .long)
        flag = try values.decodeIfPresent(String.self, forKey: .flag)
    }

}
