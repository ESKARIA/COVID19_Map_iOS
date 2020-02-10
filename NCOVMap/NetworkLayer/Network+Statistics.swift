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
    func getStatistics(_ completion: @escaping(StatisticsJSONModel?, EKNetworkError?) -> Void)
}
