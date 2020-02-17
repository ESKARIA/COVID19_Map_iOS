//
//  DescriptionProtocols.swift
//  NCOV_Map
//
//  Created by Emil Karimov on 17/02/2020.
//  Copyright © 2020 ESKARIA. All rights reserved.
//

import UIKit

enum DescriptionCase {

    case confirmed
    case died
    case cured

    var icon: UIImage? {
        switch self {
        case .confirmed: return R.image.confirmed()
        case .cured: return R.image.cured()
        case .died: return R.image.died()
        }
    }

    var title: String? {
        switch self {
        case .confirmed: return "Заболело"
        case .cured: return "Вылечено"
        case .died: return "Погибло"
        }
    }
}

// PRESENTER -> VIEW
protocol DescriptionViewProtocol: class {
    func setContent(_ type: DescriptionCase, model: StatisticsModel)
}

// PRESENTER -> WIREFRAME
protocol DescriptionWireFrameProtocol: class { }

// VIEW -> PRESENTER
protocol DescriptionPresenterProtocol: class {
    func viewDidLoad()
}

// PRESENTER -> INTERACTOR
protocol DescriptionInteractorProtocol: class { }
