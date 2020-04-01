//
//  JSONCountryBase.swift
//  NCOVMap
//
//  Created by Emil Karimov on 01.04.2020.
//  Copyright © 2020 ESKARIA. All rights reserved.
//


import Foundation

struct JSONCountryBase: Codable {

    let country: String
    let countryInfo: JSONCountryInfo?
    let cases: Int
    let todayCases: Int?
    let deaths: Int
    let todayDeaths: Int?
    let recovered: Int
    let active: Int?
    let critical: Int?
    let casesPerOneMillion: Double?
    let deathsPerOneMillion: Double?
    let updated: Int?

    enum CodingKeys: String, CodingKey {

        case country = "country"
        case countryInfo = "countryInfo"
        case cases = "cases"
        case todayCases = "todayCases"
        case deaths = "deaths"
        case todayDeaths = "todayDeaths"
        case recovered = "recovered"
        case active = "active"
        case critical = "critical"
        case casesPerOneMillion = "casesPerOneMillion"
        case deathsPerOneMillion = "deathsPerOneMillion"
        case updated = "updated"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        country = try values.decode(String.self, forKey: .country)
        countryInfo = try values.decodeIfPresent(JSONCountryInfo.self, forKey: .countryInfo)
        cases = try values.decode(Int.self, forKey: .cases)
        todayCases = try values.decodeIfPresent(Int.self, forKey: .todayCases)
        deaths = try values.decode(Int.self, forKey: .deaths)
        todayDeaths = try values.decodeIfPresent(Int.self, forKey: .todayDeaths)
        recovered = try values.decode(Int.self, forKey: .recovered)
        active = try values.decodeIfPresent(Int.self, forKey: .active)
        critical = try values.decodeIfPresent(Int.self, forKey: .critical)
        casesPerOneMillion = try values.decodeIfPresent(Double.self, forKey: .casesPerOneMillion)
        deathsPerOneMillion = try values.decodeIfPresent(Double.self, forKey: .deathsPerOneMillion)
        updated = try values.decodeIfPresent(Int.self, forKey: .updated)
    }

}
