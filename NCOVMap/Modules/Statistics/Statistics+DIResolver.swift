//
//  DIResolver+Statistics.swift
//  NCOV_Map
//
//  Created by Dmitriy on 10/02/2020.
//  Copyright © 2020 ESKARIA. All rights reserved.
//

import UIKit

// MARK: - Statistics
protocol StatisticsProtocol {
    func presentStatisticsViewController() -> UIViewController
}

extension DIResolver: StatisticsProtocol {
    func presentStatisticsViewController() -> UIViewController {
        let viewController = StatisticsViewController(themeManager: self.getThemeManager())
        let interactor = StatisticsInteractor()
        let wireFrame = StatisticsWireFrame(resolver: self)
        let presenter = StatisticsPresenter(view: viewController, wireFrame: wireFrame, interactor: interactor)
        viewController.presenter = presenter
        return viewController
    }
}
