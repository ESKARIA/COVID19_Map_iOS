//
//  AppDelegate.swift
//  NCOVMap
//
//  Created by Дмитрий Торопкин on 10.02.2020.
//  Copyright © 2020 ESKARIA. All rights reserved.
//

import UIKit
import GoogleMaps
import GooglePlaces
import Fabric
import Crashlytics
import Firebase

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.

        self.setupFirebase()
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
}

extension UIResponder {
    
    func setupFirebase() {
        self.setupAnalytics()
        self.setupGoogleMapsApi()
    }
    
    private func setupGoogleMapsApi() {
        guard let googleMapsKey = Bundle.main.object(forInfoDictionaryKey: "GoogleMapsApiKey") as? String else {
            fatalError("Insert API key in info.plist!")
        }
        GMSServices.provideAPIKey(googleMapsKey)
        GMSPlacesClient.provideAPIKey(googleMapsKey)
    }
    
    private func setupAnalytics() {
        FirebaseApp.configure()
    }
}
