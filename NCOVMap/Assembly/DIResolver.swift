//
//  DIResolver.swift
//  NCOVMap
//
//  Created by Дмитрий Торопкин on 10.02.2020.
//  Copyright © 2020 ESKARIA. All rights reserved.
//

import UIKit
import EKNetworking

protocol DIResolverComponents {

    /// Network provider
    func getNetworking() -> NetworkRequestProvider

    /// Account manager
    func getAccountManager() -> EKAccountManagerProtocol
}

class DIResolver {

    private var networking: NetworkRequestProvider?
    private var accountManager: EKAccountManagerProtocol?

    func rootViewController() -> UIViewController {

        let controller = RootViewController(resolver: self)
        return controller
    }

    func mainTabBarController() -> UIViewController {
        let controller = BaseTabBarController(resolver: self)
        return controller
    }
}

// MARK: - DIResolverComponents
extension DIResolver: DIResolverComponents {

    func getNetworking() -> NetworkRequestProvider {
        if let networking = self.networking {
            return networking
        }

        /// networking
        let networkWrapper = EKNetworkRequestWrapper()
        networkWrapper.delegate = self

        let network = NetworkRequestProvider(networkWrapper: networkWrapper, accountManager: self.getAccountManager())
        self.networking = network

        return self.getNetworking()
    }

    func getAccountManager() -> EKAccountManagerProtocol {
        if let accountManager = self.accountManager {
            return accountManager
        }
        
        let accountManager = AccountManager(environmet: .production, serverPort: 80)

        self.accountManager = accountManager
        return self.accountManager!
    }


}

// MARK: - EKErrorHandleDelegate
extension DIResolver: EKErrorHandleDelegate {
    func handle(error: EKNetworkError?, statusCode: Int) {
        // TODO: - handle error from api for global notifiactions
    }
}
