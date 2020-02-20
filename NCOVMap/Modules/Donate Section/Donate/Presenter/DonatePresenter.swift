//
//  DonatePresenter.swift
//  NCOV_Map
//
//  Created by Emil Karimov on 18/02/2020.
//  Copyright © 2020 ESKARIA. All rights reserved.
//

import DTPurchase

class DonatePresenter: BasePresenter {
    
    weak var view: DonateViewProtocol?
    private var wireFrame: DonateWireFrameProtocol
    private var interactor: DonateInteractorProtocol
    
    init(view: DonateViewProtocol, wireFrame: DonateWireFrameProtocol, interactor: DonateInteractorProtocol) {
        self.view = view
        self.interactor = interactor
        self.wireFrame = wireFrame
    }
    
    private func getProducts() {
        self.interactor.getProducts { (products) in
            self.view?.insert(products: products)
        }
    }
}

extension DonatePresenter: DonatePresenterProtocol {
    
    func viewLoaded() {
        self.getProducts()
    }
    
    func didClickDonate(product: DTIAPProduct) {
        self.view?.showLoading()
        self.interactor.purchase(product: product) { (status) in
            self.view?.hideLoading()
            if status == .purchased {
                self.view?.showSuccess()
            } else {
                self.view?.showOkAlert(with: R.string.localizable.donate_Bought_Error(), description: R.string.localizable.donate_Bought_Error_Description())
            }
        }
    }
}
