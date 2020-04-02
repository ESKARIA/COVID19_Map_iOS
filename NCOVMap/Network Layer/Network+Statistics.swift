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
    func getStatistics(_ completion: @escaping([ModelCountry]?, EKNetworkError?) -> Void)
}

extension NetworkRequestProvider: NetworkStatisticsProtocol {
    
    func getStatistics(_ completion: @escaping ([ModelCountry]?, EKNetworkError?) -> Void) {
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
                    let jsonModels = try jsonDecoder.decode([JSONCountryBase].self, from: data)

                    let models = jsonModels.map { ModelCountry.convert(apiModel: $0) }
                    
                    completion(models, nil)
                }
            } catch {
                completion(nil, EKNetworkErrorStruct(error: error as NSError))
            }
        }
    }
}
