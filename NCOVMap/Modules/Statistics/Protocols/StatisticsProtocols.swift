//
//  StatisticsProtocols.swift
//  NCOV_Map
//
//  Created by Dmitriy on 10/02/2020.
//  Copyright © 2020 ESKARIA. All rights reserved.
//

import UIKit

// PRESENTER -> VIEW
protocol StatisticsViewProtocol: class { }

// PRESENTER -> WIREFRAME
protocol StatisticsWireFrameProtocol: class { }

// VIEW -> PRESENTER
protocol StatisticsPresenterProtocol: class { }

// PRESENTER -> INTERACTOR
protocol StatisticsInteractorProtocol: class { }
