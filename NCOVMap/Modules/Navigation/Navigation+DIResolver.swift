//
//  DIResolver+Navigation.swift
//  NCOV_Map
//
//  Created by Dmitriy on 10/02/2020.
//  Copyright © 2020 ESKARIA. All rights reserved.
//

import UIKit

// MARK: - Navigation
protocol NavigationProtocol {
    func presentNavigationViewController(rootController: UIViewController) -> UIViewController
}

extension DIResolver: NavigationProtocol {
    func presentNavigationViewController(rootController: UIViewController) -> UIViewController {
        let viewController = NavigationViewController(rootViewController: rootController)
        let interactor = NavigationInteractor()
        let wireFrame = NavigationWireFrame(resolver: self)
        let presenter = NavigationPresenter(view: viewController, wireFrame: wireFrame, interactor: interactor)
        viewController.presenter = presenter
        
        return viewController
    }
}
