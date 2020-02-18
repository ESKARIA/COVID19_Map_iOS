//
//  NetworkRequestProvider.swift
//  NCOVMap
//
//  Created by Emil Karimov on 10.02.2020.
//  Copyright © 2020 ESKARIA LLC. All rights reserved.
//

import Foundation
import EKNetworking
import Fabric
import Crashlytics
import Firebase

public enum LogEventType {
    case signup
    case login
    case custom(title: String)
    case purchase
    case addToCart
    case unknown
}

class NetworkRequestProvider {

    let networkWrapper: EKNetworkRequestWrapperProtocol
    let accountManager: EKAccountManagerProtocol

    init(networkWrapper: EKNetworkRequestWrapperProtocol, accountManager: EKAccountManagerProtocol) {
        self.networkWrapper = networkWrapper
        self.accountManager = accountManager
    }

    internal func runRequest(_ request: EKNetworkRequest, progressResult: ((Double) -> Void)?, completion: @escaping(_ statusCode: Int, _ requestData: Data?, _ error: EKNetworkError?) -> Void) {

        var baseUrl = self.accountManager.getBaseUrl()
        var tokenString: String?
        let token = accountManager.getUserToken()
        if !token.isEmpty {
            tokenString = "Bearer " + accountManager.getUserToken()
        }
        self.networkWrapper.runRequest(request, baseURL: baseUrl, authToken: tokenString, progressResult: progressResult) { (statusCode, data, error) in

            guard let error = error else {
                completion(statusCode, data, nil)
                return
            }

            switch error.type {
            case .unauthorized:
                completion(statusCode, nil, error)
                break
            default:
                completion(statusCode, nil, error)
                break
            }
        }
    }

    public func log(event: LogEventType, error: EKNetworkError?, identifier: String?, statusCode: Int) {

        var dic: [String: Any] = [:]
        dic.updateValue("\(statusCode)", forKey: "statusCode")

        if let value = identifier {

            let key: String
            switch event {
            case .signup, .login:
                break
            default:
                key = "userId"
                dic.updateValue(value, forKey: key)
            }
        }

        if let uuid = UIDevice.current.identifierForVendor?.uuidString {
            dic.updateValue(uuid, forKey: "uuid")
        }

        let success: String = (error == nil) ? "true" : "false"
        switch event {
        case .signup:

            Answers.logSignUp(withMethod: identifier, success: (error == nil) ? 1 : 0, customAttributes: dic)
            Analytics.logEvent(AnalyticsEventSignUp, parameters: dic)
        case .login:

            Answers.logLogin(withMethod: identifier, success: (error == nil) ? 1 : 0, customAttributes: dic)
            Analytics.logEvent(AnalyticsEventLogin, parameters: dic)
        case .custom(let title):

            dic.updateValue(success, forKey: "success")
            Answers.logCustomEvent(withName: title, customAttributes: dic)
            Analytics.logEvent(title, parameters: dic)
        default:

            dic.updateValue(success, forKey: "success")
            Answers.logCustomEvent(withName: "unknown", customAttributes: dic)
            Analytics.logEvent("unknown", parameters: dic)
        }
    }
}

