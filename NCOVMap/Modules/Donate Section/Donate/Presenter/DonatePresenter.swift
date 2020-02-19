//
//  DonatePresenter.swift
//  NCOV_Map
//
//  Created by Emil Karimov on 18/02/2020.
//  Copyright © 2020 ESKARIA. All rights reserved.
//

class DonatePresenter: BasePresenter {

    weak var view: DonateViewProtocol?
    private var wireFrame: DonateWireFrameProtocol
    private var interactor: DonateInteractorProtocol

    init(view: DonateViewProtocol, wireFrame: DonateWireFrameProtocol, interactor: DonateInteractorProtocol) {
        self.view = view
        self.interactor = interactor
        self.wireFrame = wireFrame
    }
}

extension DonatePresenter: DonatePresenterProtocol { }
