//
//  IPPlaceApiRequest.swift
//  NCOVMap
//
//  Created by Emil Karimov on 18.02.2020.
//  Copyright © 2020 ESKARIA LLC. All rights reserved.
//

import Foundation
import EKNetworking

/// получение положение по ip
struct IPPlaceApiRequest: EKNetworkRequest {

    var path: String {
        return "/json"
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

