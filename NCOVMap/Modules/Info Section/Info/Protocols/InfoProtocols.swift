//
//  InfoProtocols.swift
//  NCOV_Map
//
//  Created by Emil Karimov on 19/02/2020.
//  Copyright © 2020 ESKARIA. All rights reserved.
//

import UIKit

// PRESENTER -> VIEW
protocol InfoViewProtocol: class { }

// PRESENTER -> WIREFRAME
protocol InfoWireFrameProtocol: class {
    func presentInfoDetail(from view: InfoViewProtocol?, with type: InfoRow)
}

// VIEW -> PRESENTER
protocol InfoPresenterProtocol: class {
    func didClick(on item: InfoRow)
}

// PRESENTER -> INTERACTOR
protocol InfoInteractorProtocol: class { }
