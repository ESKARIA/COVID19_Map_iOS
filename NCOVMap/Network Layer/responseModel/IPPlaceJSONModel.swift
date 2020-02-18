//
//  IPPlace.swift
//  NCOVMap
//
//  Created by Emil Karimov on 18.02.2020.
//  Copyright © 2020 ESKARIA LLC. All rights reserved.
//

import Foundation

// MARK: - IPPlaceJSONModel
class IPPlaceJSONModel: Codable {
    var status: String?
    var country: String?
    var countryCode: String?
    var region: String?
    var regionName: String?
    var city: String?
    var zip: String?
    var lat, lon: Double?
    var timezone: String?
    var isp: String?
    var org: String?
    var ipPlaceJSONModelAs: String?
    var query: String?

    enum CodingKeys: String, CodingKey {
        case status
        case country
        case countryCode
        case region
        case regionName
        case city
        case zip
        case lat
        case lon
        case timezone
        case isp
        case org
        case ipPlaceJSONModelAs = "as"
        case query
    }

    init(status: String?, country: String?, countryCode: String?, region: String?, regionName: String?, city: String?, zip: String?, lat: Double?, lon: Double?, timezone: String?, isp: String?, org: String?, ipPlaceJSONModelAs: String?, query: String?) {
        self.status = status
        self.country = country
        self.countryCode = countryCode
        self.region = region
        self.regionName = regionName
        self.city = city
        self.zip = zip
        self.lat = lat
        self.lon = lon
        self.timezone = timezone
        self.isp = isp
        self.org = org
        self.ipPlaceJSONModelAs = ipPlaceJSONModelAs
        self.query = query
    }
}
