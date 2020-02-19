//
//  InfoPresenter.swift
//  NCOV_Map
//
//  Created by Emil Karimov on 19/02/2020.
//  Copyright © 2020 ESKARIA. All rights reserved.
//

class InfoPresenter: BasePresenter {

    weak var view: InfoViewProtocol?
    private var wireFrame: InfoWireFrameProtocol
    private var interactor: InfoInteractorProtocol

    init(view: InfoViewProtocol, wireFrame: InfoWireFrameProtocol, interactor: InfoInteractorProtocol) {
        self.view = view
        self.interactor = interactor
        self.wireFrame = wireFrame
    }
}

extension InfoPresenter: InfoPresenterProtocol { }
