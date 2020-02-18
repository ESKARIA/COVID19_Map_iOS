//
//  Network+Statistics.swift
//  NCOVMap
//
//  Created by Emil Karimov on 10.02.2020.
//  Copyright © 2020 ESKARIA LLC. All rights reserved.
//

import Foundation
import EKNetworking


protocol NetworkStatisticsProtocol {
    /// Get full statistics method
    ///
    /// - Parameter completion: statistic model(optioanl), error(optional)
    func getStatistics(_ completion: @escaping(StatisticsModel?, EKNetworkError?) -> Void)
    
    func getLocation(_ completion: @escaping(IPPlaceJSONModel?, EKNetworkError?) -> Void)
}

extension NetworkRequestProvider: NetworkStatisticsProtocol {
    
    func getStatistics(_ completion: @escaping (StatisticsModel?, EKNetworkError?) -> Void) {
        let request = StatisticsApiRequest()
        self.runRequest(request, progressResult: nil) { (statusCode, data, networkError) in
            defer {
                self.log(event: .custom(title: "getStatistics"),
                         error: networkError,
                         identifier: UIDevice.current.identifierForVendor?.uuidString,
                         statusCode: statusCode)
            }
            if let error = networkError {
                completion(nil, error)
                return
            }
            do {
                if let data = data {
                    let jsonDecoder = JSONDecoder()
                    let jsonModel = try jsonDecoder.decode(StatisticsJSONModel.self, from: data)

                    let model = StatisticsModel.convert(apiModel: jsonModel)
                    
                    completion(model, nil)
                }
            } catch {
                completion(nil, EKNetworkErrorStruct(error: error as NSError))
            }
        }
    }
    
    func getLocation(_ completion: @escaping (IPPlaceJSONModel?, EKNetworkError?) -> Void) {
        let request = IPPlaceApiRequest()
        self.runRequest(request, progressResult: nil) { (statusCode, data, networkError) in
            defer {
                self.log(event: .custom(title: "getLocation"),
                         error: networkError,
                         identifier: UIDevice.current.identifierForVendor?.uuidString,
                         statusCode: statusCode)
            }
            if let error = networkError {
                completion(nil, error)
                return
            }
            do {
                if let data = data {
                    let jsonDecoder = JSONDecoder()
                    let jsonModel = try jsonDecoder.decode(IPPlaceJSONModel.self, from: data)
                    completion(jsonModel, nil)
                }
            } catch {
                completion(nil, EKNetworkErrorStruct(error: error as NSError))
            }
        }
    }
}
