//
//  DIResolver+Donate.swift
//  NCOV_Map
//
//  Created by Emil Karimov on 18/02/2020.
//  Copyright © 2020 ESKARIA. All rights reserved.
//

import UIKit

// MARK: - Donate
protocol DonateProtocol {
    func presentDonateViewController() -> UIViewController
}

extension DIResolver: DonateProtocol {
    func presentDonateViewController() -> UIViewController {
        let viewController = DonateViewController(themeManager: self.getThemeManager())
        let interactor = DonateInteractor()
        let wireFrame = DonateWireFrame(resolver: self)
        let presenter = DonatePresenter(view: viewController, wireFrame: wireFrame, interactor: interactor)
        viewController.presenter = presenter
        return viewController
    }
}
