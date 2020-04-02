//
//  DIResolver+Description.swift
//  NCOV_Map
//
//  Created by Emil Karimov on 17/02/2020.
//  Copyright © 2020 ESKARIA. All rights reserved.
//

import UIKit

// MARK: - Description
protocol DescriptionProtocol {
    func presentDescriptionViewController(type: DescriptionCase, models: [ModelCountry]) -> UIViewController
}

extension DIResolver: DescriptionProtocol {
    func presentDescriptionViewController(type: DescriptionCase, models: [ModelCountry]) -> UIViewController {
        let viewController = DescriptionViewController(themeManager: self.getThemeManager())
        let interactor = DescriptionInteractor()
        let wireFrame = DescriptionWireFrame(resolver: self)
        let presenter = DescriptionPresenter(view: viewController, wireFrame: wireFrame, interactor: interactor, type: type, models: models)
        viewController.presenter = presenter
        return viewController
    }
}
