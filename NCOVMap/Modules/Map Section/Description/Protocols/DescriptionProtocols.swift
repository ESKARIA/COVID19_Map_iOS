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
    case recovered

    var icon: UIImage? {
        switch self {
        case .confirmed: return R.image.confirmed_icon()
        case .recovered: return R.image.recovered_icon()
        case .died: return R.image.died_icon()
        }
    }

    var title: String? {
        switch self {
        case .confirmed: return R.string.localizable.descript_confirmed_title()
        case .recovered: return R.string.localizable.descript_recovered_title()
        case .died: return R.string.localizable.descript_deaths_title()
        }
    }
    
    var description: String? {
        switch self {
        case .confirmed: return R.string.localizable.descript_Confirmed_text()
        case .recovered: return R.string.localizable.descript_Recovered_text()
        case .died: return R.string.localizable.descript_Died_text()
        }
    }
}

// PRESENTER -> VIEW
protocol DescriptionViewProtocol: class {
    func setContent(_ type: DescriptionCase, models: [ModelCountry])
}

// PRESENTER -> WIREFRAME
protocol DescriptionWireFrameProtocol: class { }

// VIEW -> PRESENTER
protocol DescriptionPresenterProtocol: class {
    func viewDidLoad()
}

// PRESENTER -> INTERACTOR
protocol DescriptionInteractorProtocol: class { }
