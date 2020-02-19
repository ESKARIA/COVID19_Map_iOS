//
//  InfoDetailProtocols.swift
//  NCOV_Map
//
//  Created by Emil Karimov on 19/02/2020.
//  Copyright © 2020 ESKARIA. All rights reserved.
//

import UIKit

// PRESENTER -> VIEW
protocol InfoDetailViewProtocol: class {
    func setDetails(_ text: String)
}

// PRESENTER -> WIREFRAME
protocol InfoDetailWireFrameProtocol: class { }

// VIEW -> PRESENTER
protocol InfoDetailPresenterProtocol: class {
    func viewDidLoad()
}

// PRESENTER -> INTERACTOR
protocol InfoDetailInteractorProtocol: class { }
