//
//  DIResolver+InfoDetail.swift
//  NCOV_Map
//
//  Created by Emil Karimov on 19/02/2020.
//  Copyright © 2020 ESKARIA. All rights reserved.
//

import UIKit

// MARK: - InfoDetail
protocol InfoDetailProtocol {
    func presentInfoDetailViewController(type: InfoRow) -> UIViewController
}

extension DIResolver: InfoDetailProtocol {
    func presentInfoDetailViewController(type: InfoRow) -> UIViewController {
        let viewController = InfoDetailViewController(themeManager: self.getThemeManager())
        let interactor = InfoDetailInteractor()
        let wireFrame = InfoDetailWireFrame(resolver: self)
        let presenter = InfoDetailPresenter(view: viewController, wireFrame: wireFrame, interactor: interactor, type: type)
        viewController.presenter = presenter
        return viewController
    }
}
