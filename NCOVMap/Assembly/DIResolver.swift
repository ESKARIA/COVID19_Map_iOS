//
//  DIResolver.swift
//  NCOVMap
//
//  Created by Дмитрий Торопкин on 10.02.2020.
//  Copyright © 2020 ESKARIA. All rights reserved.
//

import UIKit

class DIResolver {
    
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
