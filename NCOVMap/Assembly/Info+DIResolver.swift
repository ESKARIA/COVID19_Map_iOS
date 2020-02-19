//
//  DIResolver+Info.swift
//  NCOV_Map
//
//  Created by Emil Karimov on 19/02/2020.
//  Copyright © 2020 ESKARIA. All rights reserved.
//

import UIKit

// MARK: - Info
protocol InfoProtocol {
    func presentInfoViewController() -> UIViewController
}

extension DIResolver: InfoProtocol {
    func presentInfoViewController() -> UIViewController {
        let viewController = InfoViewController(themeManager: self.getThemeManager())
        let interactor = InfoInteractor()
        let wireFrame = InfoWireFrame(resolver: self)
        let presenter = InfoPresenter(view: viewController, wireFrame: wireFrame, interactor: interactor)
        viewController.presenter = presenter
        return viewController
    }
}
