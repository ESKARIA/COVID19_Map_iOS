//
//  StatisticsJSONModel.swift
//  NCOVMap
//
//  Created by Дмитрий Торопкин on 10.02.2020.
//  Copyright © 2020 ESKARIA. All rights reserved.
//

import Foundation

struct StatisticsJSONModel: Codable {
    
    var totalConfirmed: Int
    var totalRecovered: Int
    var totalDeath: Int
    var lastUpdateDate: String
    var data: [StatisticsRegionJSONModel]
    
    enum CodingKeys: String, CodingKey {
        case totalConfirmed = "total_confirmed"
        case totalRecovered = "total_recovered"
        case totalDeath = "total_death"
        case lastUpdateDate = "last_update"
        case data = "data"
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(totalConfirmed, forKey: .totalConfirmed)
        try container.encode(totalRecovered, forKey: .totalRecovered)
        try container.encode(totalDeath, forKey: .totalDeath)
        try container.encode(lastUpdateDate, forKey: .lastUpdateDate)
        try container.encode(data, forKey: .data)

    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.totalConfirmed = try container.decode(Int.self, forKey: .totalConfirmed)
        self.totalRecovered = try container.decode(Int.self, forKey: .totalRecovered)
        self.totalDeath = try container.decode(Int.self, forKey: .totalDeath)
        self.lastUpdateDate = try container.decode(String.self, forKey: .lastUpdateDate)
        self.data = try container.decode([StatisticsRegionJSONModel].self, forKey: .data)
    }
}

struct StatisticsRegionJSONModel: Codable {
    
    var state: String
    var country: String
    var lat: String
    var long: String
    var dates: [StatisticsRegionDateJSONModel]
    
    enum CodingKeys: String, CodingKey {
        case state = "Province/State"
        case country = "Country/Region"
        case lat = "Lat"
        case long = "Long"
        case dates = "dates"
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(state, forKey: .state)
        try container.encode(country, forKey: .country)
        try container.encode(lat, forKey: .lat)
        try container.encode(long, forKey: .long)
        try container.encode(dates, forKey: .dates)
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.state = try container.decode(String.self, forKey: .state)
        self.country = try container.decode(String.self, forKey: .country)
        self.lat = try container.decode(String.self, forKey: .lat)
        self.long = try container.decode(String.self, forKey: .long)
        self.dates = try container.decode([StatisticsRegionDateJSONModel].self, forKey: .dates)
    }
}

struct StatisticsRegionDateJSONModel: Codable {
    
    var date: String
    var confirmed: Int
    var recovered: Int
    var death: Int
    
    enum CodingKeys: String, CodingKey {
        case date = "date"
        case confirmed = "confirmed"
        case recovered = "recovered"
        case death = "death"
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(date, forKey: .date)
        try container.encode(confirmed, forKey: .confirmed)
        try container.encode(recovered, forKey: .recovered)
        try container.encode(death, forKey: .death)
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.date = try container.decode(String.self, forKey: .date)
        self.confirmed = try container.decode(Int.self, forKey: .confirmed)
        self.recovered = try container.decode(Int.self, forKey: .recovered)
        self.death = try container.decode(Int.self, forKey: .death)
    }
    
}
