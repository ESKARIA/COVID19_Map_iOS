//
//  StatisticsApiRequest.swift
//  NCOVMap
//
//  Created by Emil Karimov on 10.02.2020.
//  Copyright © 2020 ESKARIA LLC. All rights reserved.
//

import EKNetworking

/// Запрос получение списков покупок
struct StatisticsApiRequest: EKNetworkRequest {

    var path: String {
        return "/countries"
    }

    var method: EKRequestHTTPMethod {
        return .get
    }

    var urlParameters: [String: Any] {
        return [:]
    }

    var bodyParameters: [String: Any] {
        return [:]
    }
    
    var headers: [EKHeadersKey : String] {
        return [:]
    }
}

