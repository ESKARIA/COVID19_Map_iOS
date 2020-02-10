//
//  DIResolver+Map.swift
//  NCOV_Map
//
//  Created by Dmitriy on 10/02/2020.
//  Copyright © 2020 ESKARIA. All rights reserved.
//

import UIKit

// MARK: - Map
protocol MapProtocol {
    func presentMapViewController() -> UIViewController
}

extension DIResolver: MapProtocol {
    func presentMapViewController() -> UIViewController {
        let viewController = MapViewController(themeManager: self.getThemeManager())
        let interactor = MapInteractor(networking: self.getNetworking())
        let wireFrame = MapWireFrame(resolver: self)
        let presenter = MapPresenter(view: viewController, wireFrame: wireFrame, interactor: interactor)
        viewController.presenter = presenter
        return viewController
    }
}
