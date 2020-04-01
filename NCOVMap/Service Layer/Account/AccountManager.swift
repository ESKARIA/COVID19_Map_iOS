//
//  AccountManager.swift
//  NCOVMap
//
//  Created by Emil Karimov on 10.02.2020.
//  Copyright © 2020 ESKARIA LLC. All rights reserved.
//

import Foundation
import EKNetworking
import FirebaseAuth

struct DefaultsKeys {
    static let app_token = "com.eskaria.ncov.ios.app.token"
    static let user_token = "com.eskaria.ncov.ios.user.token"
    static let refresh_token = "com.eskaria.ncov.ios.user.refresh.token"
    static let user_model = "com.eskaria.ncov.ios.user.model"
}

enum Environmet {
    case local
    case develop
    case production
}

enum GrantType: String {
    case credentials = "client_credentials"
    case password = "password"
}

class AccountManager {

    private let serverPort: String
    private let apiPath: String
    private var environmet: Environmet

    private let defaults = UserDefaults.standard

    init(environmet: Environmet, serverPort: Int) {
        self.environmet = environmet
        self.serverPort = ":\(serverPort)"
        self.apiPath = "/api"
    }
}

// MARK: - Account Manager Protocol
extension AccountManager: EKAccountManagerProtocol {

    func getBaseUrl() -> String {
        switch environmet {
        case .production: return "https://corona.lmao.ninja"
        default: return "https://corona.lmao.ninja"
        }
    }

    func getMediaBaseUrl() -> String {
        return ""
    }

    func getUserToken() -> String {
        return self.defaults.string(forKey: DefaultsKeys.user_token) ?? ""
    }

    func setUserToken(newToken: String) {
        self.defaults.set(newToken, forKey: DefaultsKeys.user_token)
    }

    func logOut() {

    }
}

