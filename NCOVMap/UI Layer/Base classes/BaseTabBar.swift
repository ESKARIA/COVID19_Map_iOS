//
//  BaseTabBar.swift
//  NCOVMap
//
//  Created by Дмитрий Торопкин on 10.02.2020.
//  Copyright © 2020 ESKARIA. All rights reserved.
//

import UIKit

class BaseTabBarController: UITabBarController {
    
    private var resolver: DIResolver
    
    init(resolver: DIResolver) {
        self.resolver = resolver
        super.init(nibName: nil, bundle: nil)
        self.viewControllers = self.getControllers()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func getControllers() -> [UIViewController] {
        
        let mapController = self.resolver.presentMapViewController()
        let mainController = self.resolver.presentNavigationViewController(rootController: mapController)
        let mapButton = UITabBarItem(title: "Map", image: nil, selectedImage: nil)
        mapButton.tag = 1
        mainController.tabBarItem = mapButton
        
        return [mainController]
    }
}
