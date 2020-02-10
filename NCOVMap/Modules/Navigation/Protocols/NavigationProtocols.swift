//
//  NavigationProtocols.swift
//  NCOV_Map
//
//  Created by Dmitriy on 10/02/2020.
//  Copyright © 2020 ESKARIA. All rights reserved.
//

import UIKit

// PRESENTER -> VIEW
protocol NavigationViewProtocol: class { }

// PRESENTER -> WIREFRAME
protocol NavigationWireFrameProtocol: class { }

// VIEW -> PRESENTER
protocol NavigationPresenterProtocol: class { }

// PRESENTER -> INTERACTOR
protocol NavigationInteractorProtocol: class { }
