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

    
    private var themeMananger: ThemeManager?
    
    func rootViewController() -> UIViewController {

        let controller = RootViewController(resolver: self)
        return controller
    }
    
    func getThemeManager() -> ThemeManager {
        
        if self.themeMananger != nil {
            return self.themeMananger!
        }
        
        guard let mode = UIApplication.shared.windows.first?.overrideUserInterfaceStyle else {
            self.themeMananger = ThemeManager(mode: .light)
            return self.themeMananger!
        }
        
        if mode == .light || mode == .unspecified {
            self.themeMananger = ThemeManager(mode: .light)
        }
        
        if mode == .dark {
            self.themeMananger = ThemeManager(mode: .dark)
        }
        
        return self.themeMananger!
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
        
        let accountManager = AccountManager(environmet: .production, serverPort: 3000)

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
