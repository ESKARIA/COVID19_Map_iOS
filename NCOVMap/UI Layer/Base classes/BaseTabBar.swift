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
        self.view.backgroundColor = .white
        self.tabBar.tintColor = UIColor.RGB(r: 16, g: 23, b: 36)
    }

    private func getControllers() -> [UIViewController] {

        let selectedColor = UIColor.RGB(r: 62, g: 81, b: 97)

        let mapController = self.resolver.presentNavigationViewController(rootController: self.resolver.presentMapViewController())
    
        let mapButton = UITabBarItem.init(title: "Map", image: R.image.map(), selectedImage: R.image.mapSelect())
        mapButton.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: selectedColor], for: UIControl.State.selected)
        mapButton.tag = 1
        mapController.tabBarItem = mapButton

        let donateController = self.resolver.presentNavigationViewController(rootController: self.resolver.presentDonateViewController())
        let donateButton = UITabBarItem.init(title: "Donate", image: R.image.donate(), selectedImage: R.image.donateSelect())
        donateButton.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: selectedColor], for: UIControl.State.selected)
        donateButton.tag = 2
        donateController.tabBarItem = donateButton

        return [mapController, donateController]
    }
}
