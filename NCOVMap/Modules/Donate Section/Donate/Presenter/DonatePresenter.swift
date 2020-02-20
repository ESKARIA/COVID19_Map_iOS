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
    
    private var products = [DTIAPProduct]()
    
    init(view: DonateViewProtocol, wireFrame: DonateWireFrameProtocol, interactor: DonateInteractorProtocol) {
        self.view = view
        self.interactor = interactor
        self.wireFrame = wireFrame
    }
    
    private func getProducts() {
        self.interactor.getProducts { (products) in
            self.products = products
        }
    }
}

extension DonatePresenter: DonatePresenterProtocol {
    
    func viewLoaded() {
        self.getProducts()
    }
    
    func didClickDonate(value: DonatePrice) {
        self.view?.showLoading()
        var product: DTIAPProduct?
        switch value {
            
        case .ninetyNineCents:
            product = products.filter{ $0.productIdentifier == "com.eskaria.ncov.ios.donate.1" }.first
            
        case .fiveDollars:
            product = products.filter{ $0.productIdentifier == "com.eskaria.ncov.ios.donate.2" }.first
        case .tenDollats:
            product = products.filter{ $0.productIdentifier == "com.eskaria.ncov.ios.donate.3" }.first
        case .twentyFiveDollars:
            product = products.filter{ $0.productIdentifier == "com.eskaria.ncov.ios.donate.4" }.first
        case .fiftyDollars:
            product = products.filter{ $0.productIdentifier == "com.eskaria.ncov.ios.donate.5" }.first
        case .oneHundredDollars:
            product = products.filter{ $0.productIdentifier == "com.eskaria.ncov.ios.donate.6" }.first
        }
        if let _product = product {
            self.interactor.purchase(product: _product) { (status) in
                self.view?.hideLoading()
                if status == .purchased {
                    self.view?.showSuccess()
                } else {
                    self.view?.showOkAlert(with: R.string.localizable.donate_Bought_Error(), description: R.string.localizable.donate_Bought_Error_Description())
                }
            }
        } else {
            //ошибка при получении покупки
            self.view?.showOkAlert(with: R.string.localizable.donate_Bought_Error(), description: R.string.localizable.donate_Bought_Error_Description())
        }
    }
}
