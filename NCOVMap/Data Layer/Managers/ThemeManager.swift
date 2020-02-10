//
//  ThemeManager.swift
//  NCOVMap
//
//  Created by Дмитрий Торопкин on 10.02.2020.
//  Copyright © 2020 ESKARIA. All rights reserved.
//

import UIKit

enum AppColorMode {
    case light
    case dark
}

class ThemeManager {
    
    private var mode: AppColorMode
    
    init(mode: AppColorMode) {
        self.mode = mode
    }
    
    func setLight() {
        mode = .light
    }
    
    func setDark() {
        mode = .dark
    }
    
    /// тема гугл карт
    func mapScreenGetGoogleMapsColorMode() -> URL? {
        switch self.mode {
            
        case .light:
            return Bundle.main.url(forResource: "GoogleMapStyleLight", withExtension: "json")
        case .dark:
            return Bundle.main.url(forResource: "GoogleMapStyleDark", withExtension: "json")
        }
    }
    
    func mapScreenGetTitleNavigationColor() -> UIColor {
        switch self.mode {
        case .light:
            return .yellow
        case .dark:
            return .blue
        }
    }
}
