//
//  DonateProtocols.swift
//  NCOV_Map
//
//  Created by Emil Karimov on 18/02/2020.
//  Copyright © 2020 ESKARIA. All rights reserved.
//

import UIKit
import DTPurchase

// PRESENTER -> VIEW
protocol DonateViewProtocol: class { }

// PRESENTER -> WIREFRAME
protocol DonateWireFrameProtocol: class { }

// VIEW -> PRESENTER
protocol DonatePresenterProtocol: class { }

// PRESENTER -> INTERACTOR
protocol DonateInteractorProtocol: class {
    func getProducts(completion: @escaping ([DTIAPProduct]) -> Void)
    func purchase(product: DTIAPProduct, completion: @escaping (DTPurchaseStatus) -> Void)
}
