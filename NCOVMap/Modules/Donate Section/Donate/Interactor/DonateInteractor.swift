//
//  DonateInteractor.swift
//  NCOV_Map
//
//  Created by Emil Karimov on 18/02/2020.
//  Copyright © 2020 ESKARIA. All rights reserved.
//

import DTPurchase

class DonateInteractor: BaseInteractor {
    
    var purchaseProvider: DTIAPProvider
    
    init(purchaseProvider: DTIAPProvider) {
        self.purchaseProvider = purchaseProvider
    }
}

extension DonateInteractor: DonateInteractorProtocol {
    
    func getProducts(completion: @escaping ([DTIAPProduct]) -> Void) {
        self.purchaseProvider.getAvailableItem(completion: completion)
    }
    
    func purchase(product: DTIAPProduct, completion: @escaping (DTPurchaseStatus) -> Void) {
        self.purchaseProvider.purchaseProduct(product: product, completion: completion)
    }
}
