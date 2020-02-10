//
//  MapProtocols.swift
//  NCOV_Map
//
//  Created by Dmitriy on 10/02/2020.
//  Copyright © 2020 ESKARIA. All rights reserved.
//

import UIKit

// PRESENTER -> VIEW
protocol MapViewProtocol: class { }

// PRESENTER -> WIREFRAME
protocol MapWireFrameProtocol: class { }

// VIEW -> PRESENTER
protocol MapPresenterProtocol: class { }

// PRESENTER -> INTERACTOR
protocol MapInteractorProtocol: class { }
