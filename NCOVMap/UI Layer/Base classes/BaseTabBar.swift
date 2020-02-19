//
//  BaseTabBar.swift
//  NCOVMap
//
//  Created by Дмитрий Торопкин on 19.02.2020.
//  Copyright © 2020 ESKARIA LLC. All rights reserved.
//

import UIKit

class BaseTabBarController: UITabBarController {

    private var resolver: DIResolver! = nil

    init(resolver: DIResolver) {
        self.resolver = resolver

        super.init(nibName: nil, bundle: nil)
        self.viewControllers = self.getControllers()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        if #available(iOS 13.0, *) {
            self.overrideUserInterfaceStyle = .light
        }

        self.createUI()
    }

}

// MARK: - Privates
extension BaseTabBarController {

    private func createUI() {
        self.view.backgroundColor = R.color.appDark()
        self.tabBar.tintColor = UIColor.RGB(r: 16, g: 23, b: 36)
        self.tabBar.isTranslucent = false
    }

    private func getControllers() -> [UIViewController] {

        let selectedColor: UIColor = .white

        let mapController = self.resolver.presentNavigationViewController(rootController: self.resolver.presentMapViewController())
        let infoController = self.resolver.presentNavigationViewController(rootController: self.resolver.presentInfoViewController())
        let donateController = self.resolver.presentNavigationViewController(rootController: self.resolver.presentDonateViewController())
    
        let mapButton = UITabBarItem.init(title: R.string.localizable.tabbar_map_title(), image: R.image.map()?.withRenderingMode(.alwaysOriginal), selectedImage: R.image.mapSelect()?.withRenderingMode(.alwaysOriginal))
        mapButton.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: selectedColor], for: UIControl.State.selected)
        mapButton.tag = 1
        mapController.tabBarItem = mapButton
        
        
        let infoButton = UITabBarItem.init(title: R.string.localizable.tabbar_info_title(), image: R.image.info()?.withRenderingMode(.alwaysOriginal), selectedImage: R.image.infoSelect()?.withRenderingMode(.alwaysOriginal))
        infoButton.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: selectedColor], for: UIControl.State.selected)
        infoButton.tag = 2
        infoController.tabBarItem = infoButton

        
        let donateButton = UITabBarItem.init(title: R.string.localizable.tabbar_donate_title(), image: R.image.donate()?.withRenderingMode(.alwaysOriginal), selectedImage: R.image.donateSelect()?.withRenderingMode(.alwaysOriginal))
        donateButton.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: selectedColor], for: UIControl.State.selected)
        donateButton.tag = 3
        donateController.tabBarItem = donateButton

        return [mapController, infoController, donateController]
    }
}
